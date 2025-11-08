package com.example.hackathon_app

import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Color
import android.graphics.ImageFormat
import android.graphics.Matrix
import android.media.Image
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.TextView
import androidx.camera.core.*
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.camera.view.PreviewView
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import com.google.mediapipe.framework.image.BitmapImageBuilder
import com.google.mediapipe.tasks.core.BaseOptions
import com.google.mediapipe.tasks.vision.core.RunningMode
import com.google.mediapipe.tasks.vision.facelandmarker.FaceLandmarker
import com.google.mediapipe.tasks.vision.facelandmarker.FaceLandmarkerResult
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.*
import java.io.ByteArrayOutputStream
import java.io.File
import java.nio.ByteBuffer
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors

class NativeCameraHandler(
    private val context: Context,
    private val eventChannel: EventChannel
) : EventChannel.StreamHandler {

    companion object {
        private const val TAG = "NativeCameraHandler"
        private const val SMILE_THRESHOLD = 0.5
        private const val CONSECUTIVE_FRAMES_REQUIRED = 2
        private const val TARGET_FPS = 20
        private const val FRAME_INTERVAL_MS = 1000L / TARGET_FPS
    }

    private var cameraProvider: ProcessCameraProvider? = null
    private var camera: Camera? = null
    private var preview: Preview? = null
    private var imageCapture: ImageCapture? = null
    private var imageAnalysis: ImageAnalysis? = null
    private var cameraExecutor: ExecutorService = Executors.newSingleThreadExecutor()

    private var previewView: PreviewView? = null
    private var cameraPreviewContainer: FrameLayout? = null

    // カウントダウン UI
    private var countdownTextView: TextView? = null
    private var countdownJob: Job? = null
    private var currentCountdown = 5

    private var faceLandmarker: FaceLandmarker? = null
    private var isSmileDetectionActive = false
    private var smileDetectionEventSink: EventChannel.EventSink? = null
    private var consecutiveSmileFrames = 0
    private var lastFrameProcessedTime = 0L

    private var capturedImagePath: String? = null
    private var capturedImageData: ByteArray? = null
    private var onCaptureCompleted: (() -> Unit)? = null

    private val mainHandler = Handler(Looper.getMainLooper())
    private val scope = CoroutineScope(Dispatchers.Main + SupervisorJob())

    init {
        eventChannel.setStreamHandler(this)
        initializeMediaPipe()
    }

    fun setCameraPreviewContainer(container: FrameLayout) {
        this.cameraPreviewContainer = container
    }

    // EventChannel.StreamHandler の実装
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        smileDetectionEventSink = events
    }

    override fun onCancel(arguments: Any?) {
        smileDetectionEventSink = null
    }

    private fun initializeMediaPipe() {
        try {
            // MediaPipe FaceLandmarker の初期化
            val baseOptions = BaseOptions.builder()
                .setModelAssetPath("face_landmarker.task")
                .build()

            val options = FaceLandmarker.FaceLandmarkerOptions.builder()
                .setBaseOptions(baseOptions)
                .setRunningMode(RunningMode.VIDEO)
                .setNumFaces(1)
                .setMinFaceDetectionConfidence(0.5f)
                .setMinFacePresenceConfidence(0.5f)
                .setMinTrackingConfidence(0.5f)
                .build()

            faceLandmarker = FaceLandmarker.createFromOptions(context, options)
            Log.d(TAG, "MediaPipe initialized successfully")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to initialize MediaPipe", e)
        }
    }

    fun startCamera(countdownSeconds: Int, onCaptureCompleted: () -> Unit) {
        currentCountdown = countdownSeconds
        this.onCaptureCompleted = onCaptureCompleted

        val cameraProviderFuture = ProcessCameraProvider.getInstance(context)

        cameraProviderFuture.addListener({
            cameraProvider = cameraProviderFuture.get()

            // カメラ起動
            bindCameraUseCases()

            // カウントダウンUIを表示
            showCountdownUI()
            startCountdownTimer()
        }, ContextCompat.getMainExecutor(context))
    }

    private fun bindCameraUseCases() {
        val cameraProvider = cameraProvider ?: return
        val container = cameraPreviewContainer ?: return

        // 既存のバインドを解除
        cameraProvider.unbindAll()

        // PreviewViewを作成してコンテナに追加
        if (previewView == null) {
            previewView = PreviewView(context).apply {
                layoutParams = FrameLayout.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
                )
            }
            container.addView(previewView, 0)
        }

        // カメラセレクター（フロントカメラ）
        val cameraSelector = CameraSelector.DEFAULT_FRONT_CAMERA

        // Preview（プレビュー用）
        preview = Preview.Builder()
            .build()
            .also {
                it.setSurfaceProvider(previewView?.surfaceProvider)
            }

        // ImageCapture（撮影用）
        imageCapture = ImageCapture.Builder()
            .setCaptureMode(ImageCapture.CAPTURE_MODE_MINIMIZE_LATENCY)
            .setTargetRotation(android.view.Surface.ROTATION_0)
            .build()

        // ImageAnalysis（MediaPipe用）
        imageAnalysis = ImageAnalysis.Builder()
            .setTargetRotation(android.view.Surface.ROTATION_0)
            .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
            .setOutputImageFormat(ImageAnalysis.OUTPUT_IMAGE_FORMAT_RGBA_8888)
            .build()
            .also { analysis ->
                analysis.setAnalyzer(cameraExecutor) { imageProxy ->
                    processImageForSmileDetection(imageProxy)
                }
            }

        try {
            // ライフサイクルにバインド
            camera = cameraProvider.bindToLifecycle(
                context as LifecycleOwner,
                cameraSelector,
                preview,
                imageCapture,
                imageAnalysis
            )
            Log.d(TAG, "Camera bound successfully")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to bind camera", e)
        }
    }

    // カウントダウンUIを表示
    private fun showCountdownUI() {
        val container = cameraPreviewContainer ?: return

        mainHandler.post {
            // 既存のカウントダウンビューを削除
            countdownTextView?.let { container.removeView(it.parent as? View) }

            // カウントダウンテキストビューを作成
            countdownTextView = TextView(context).apply {
                text = currentCountdown.toString()
                textSize = 120f
                setTextColor(Color.WHITE)
                gravity = Gravity.CENTER
            }

            // 背景ビュー
            val backgroundView = FrameLayout(context).apply {
                layoutParams = FrameLayout.LayoutParams(
                    (200 * context.resources.displayMetrics.density).toInt(),
                    (200 * context.resources.displayMetrics.density).toInt()
                ).apply {
                    gravity = Gravity.CENTER
                }
                setBackgroundColor(Color.argb(128, 0, 0, 0))
            }

            backgroundView.addView(countdownTextView, FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            ))

            container.addView(backgroundView)
        }
    }

    // カウントダウンタイマーを開始
    private fun startCountdownTimer() {
        countdownJob?.cancel()
        countdownJob = scope.launch {
            while (currentCountdown > 0) {
                delay(1000)
                currentCountdown--
                updateCountdownUI()
            }
            hideCountdownUI()
            captureImage()
        }
    }

    // カウントダウンUIを更新
    private fun updateCountdownUI() {
        mainHandler.post {
            countdownTextView?.text = currentCountdown.toString()

            // カウントダウンに応じて色を変化
            val color = when (currentCountdown) {
                5, 4 -> Color.GREEN
                3 -> Color.YELLOW
                2 -> Color.rgb(255, 165, 0) // Orange
                1 -> Color.RED
                else -> Color.WHITE
            }

            countdownTextView?.setTextColor(color)
        }
    }

    // カウントダウンUIを非表示
    private fun hideCountdownUI() {
        mainHandler.post {
            countdownTextView?.let { textView ->
                val parent = textView.parent as? ViewGroup
                parent?.let { cameraPreviewContainer?.removeView(it) }
            }
            countdownTextView = null
        }
    }

    private fun captureImage() {
        val imageCapture = imageCapture ?: return

        // 一時ファイルに保存
        val photoFile = File(
            context.cacheDir,
            "capture_${System.currentTimeMillis()}.jpg"
        )

        val outputOptions = ImageCapture.OutputFileOptions.Builder(photoFile).build()

        imageCapture.takePicture(
            outputOptions,
            ContextCompat.getMainExecutor(context),
            object : ImageCapture.OnImageSavedCallback {
                override fun onImageSaved(output: ImageCapture.OutputFileResults) {
                    capturedImagePath = photoFile.absolutePath

                    // 画像データも読み込んでおく
                    capturedImageData = photoFile.readBytes()

                    Log.d(TAG, "Image captured: ${photoFile.absolutePath}")

                    // 撮影完了をFlutter側に通知
                    onCaptureCompleted?.invoke()
                }

                override fun onError(exception: ImageCaptureException) {
                    Log.e(TAG, "Image capture failed", exception)

                    // エラーでも通知
                    onCaptureCompleted?.invoke()
                }
            }
        )
    }

    fun startSmileDetection() {
        isSmileDetectionActive = true
        consecutiveSmileFrames = 0
        Log.d(TAG, "Smile detection started")
    }

    fun stopSmileDetection() {
        isSmileDetectionActive = false
        consecutiveSmileFrames = 0
        Log.d(TAG, "Smile detection stopped")
    }

    private fun processImageForSmileDetection(imageProxy: ImageProxy) {
        if (!isSmileDetectionActive) {
            imageProxy.close()
            return
        }

        // フレームレート制御
        val currentTime = System.currentTimeMillis()
        if (currentTime - lastFrameProcessedTime < FRAME_INTERVAL_MS) {
            imageProxy.close()
            return
        }
        lastFrameProcessedTime = currentTime

        try {
            // ImageProxyをBitmapに変換
            val bitmap = imageProxy.toBitmap()

            // MediaPipeで処理
            val mpImage = BitmapImageBuilder(bitmap).build()
            val result = faceLandmarker?.detectForVideo(
                mpImage,
                currentTime
            )

            // 笑顔判定
            val isSmiling = detectSmile(result)

            // 連続フレーム判定
            if (isSmiling) {
                consecutiveSmileFrames++
            } else {
                consecutiveSmileFrames = 0
            }

            val isSmilingConfirmed = consecutiveSmileFrames >= CONSECUTIVE_FRAMES_REQUIRED

            // Flutter側に送信
            smileDetectionEventSink?.success(
                mapOf(
                    "isSmiling" to isSmilingConfirmed,
                    "confidence" to if (isSmiling) SMILE_THRESHOLD else 0.0,
                    "timestamp" to currentTime
                )
            )

        } catch (e: Exception) {
            Log.e(TAG, "Error processing image for smile detection", e)
        } finally {
            imageProxy.close()
        }
    }

    private fun detectSmile(result: FaceLandmarkerResult?): Boolean {
        if (result == null) {
            return false
        }

        val blendshapesList = result.faceBlendshapes()
        if (blendshapesList.isEmpty()) {
            return false
        }

        // MediaPipeの顔表情データから笑顔を判定
        // blendshapes には mouthSmileLeft, mouthSmileRight などが含まれる
        // get()はList<List<Category>>を返すので、最初のリストを取得
        val blendshapes = blendshapesList.get()[0]

        var smileScore = 0.0f
        for (i in 0 until blendshapes.size) {
            val category = blendshapes[i]
            // MediaPipeのCategoryクラスはdisplayName()とscore()をメソッドとして持つ
            val name = category.displayName()
            if (name == "mouthSmileLeft" || name == "mouthSmileRight") {
                smileScore += category.score()
            }
        }

        // 平均スコアを計算
        val averageSmileScore = smileScore / 2.0f

        return averageSmileScore > SMILE_THRESHOLD
    }

    fun stopCamera() {
        countdownJob?.cancel()
        countdownJob = null

        mainHandler.post {
            countdownTextView?.let { textView ->
                val parent = textView.parent as? ViewGroup
                parent?.let { cameraPreviewContainer?.removeView(it) }
            }
            countdownTextView = null

            previewView?.let { cameraPreviewContainer?.removeView(it) }
            previewView = null
        }

        cameraProvider?.unbindAll()
        isSmileDetectionActive = false
        Log.d(TAG, "Camera stopped")
    }

    fun getCapturedImagePath(): String? {
        return capturedImagePath
    }

    fun getCapturedImageData(): ByteArray? {
        return capturedImageData
    }

    fun cleanup() {
        stopCamera()
        faceLandmarker?.close()
        cameraExecutor.shutdown()
        scope.cancel()
    }
}

// ImageProxy を Bitmap に変換する拡張関数
private fun ImageProxy.toBitmap(): Bitmap {
    val buffer = planes[0].buffer
    val bytes = ByteArray(buffer.remaining())
    buffer.get(bytes)
    return BitmapFactory.decodeByteArray(bytes, 0, bytes.size)
}
