import AVFoundation
import Flutter
import UIKit
import MediaPipeTasksVision

class NativeCameraHandler: NSObject {
    private static let SMILE_THRESHOLD: Float = 0.7
    private static let CONSECUTIVE_FRAMES_REQUIRED = 3
    private static let TARGET_FPS = 20
    private static let FRAME_INTERVAL: TimeInterval = 1.0 / Double(TARGET_FPS)

    private weak var viewController: UIViewController?
    private var eventChannel: FlutterEventChannel
    private var eventSink: FlutterEventSink?

    private var captureSession: AVCaptureSession?
    private var photoOutput: AVCapturePhotoOutput?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var previewLayer: AVCaptureVideoPreviewLayer?

    private var faceLandmarker: FaceLandmarker?
    private var isSmileDetectionActive = false
    private var consecutiveSmileFrames = 0
    private var lastFrameProcessedTime: TimeInterval = 0

    private var capturedImagePath: String?
    private var capturedImageData: Data?

    private let sessionQueue = DispatchQueue(label: "camera.session.queue")
    private let processingQueue = DispatchQueue(label: "camera.processing.queue")

    init(viewController: UIViewController, eventChannel: FlutterEventChannel) {
        self.viewController = viewController
        self.eventChannel = eventChannel
        super.init()

        eventChannel.setStreamHandler(self)
        initializeMediaPipe()
    }

    private func initializeMediaPipe() {
        do {
            // MediaPipe FaceLandmarker の初期化
            guard let modelPath = Bundle.main.path(forResource: "face_landmarker", ofType: "task") else {
                print("Failed to load MediaPipe model")
                return
            }

            let options = FaceLandmarkerOptions()
            options.baseOptions.modelAssetPath = modelPath
            options.runningMode = .video
            options.numFaces = 1
            options.minFaceDetectionConfidence = 0.5
            options.minFacePresenceConfidence = 0.5
            options.minTrackingConfidence = 0.5

            faceLandmarker = try FaceLandmarker(options: options)
            print("MediaPipe initialized successfully")
        } catch {
            print("Failed to initialize MediaPipe: \(error)")
        }
    }

    func startCamera(countdownSeconds: Int) {
        sessionQueue.async { [weak self] in
            self?.setupCaptureSession()

            // カウントダウン後に撮影
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(countdownSeconds)) {
                self?.captureImage()
            }
        }
    }

    private func setupCaptureSession() {
        let session = AVCaptureSession()
        session.beginConfiguration()

        // フロントカメラの設定
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              session.canAddInput(videoDeviceInput) else {
            print("Failed to setup camera input")
            return
        }

        session.addInput(videoDeviceInput)

        // 写真出力の設定
        let photoOutput = AVCapturePhotoOutput()
        if session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            self.photoOutput = photoOutput
        }

        // ビデオ出力の設定（MediaPipe用）
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: processingQueue)
        videoOutput.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
        ]

        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            self.videoOutput = videoOutput
        }

        session.commitConfiguration()

        self.captureSession = session

        // プレビューレイヤーの設定
        DispatchQueue.main.async {
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = self.viewController?.view.bounds ?? .zero
            self.viewController?.view.layer.insertSublayer(previewLayer, at: 0)
            self.previewLayer = previewLayer
        }

        // セッション開始
        session.startRunning()
        print("Camera session started")
    }

    private func captureImage() {
        guard let photoOutput = photoOutput else { return }

        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    func startSmileDetection() {
        isSmileDetectionActive = true
        consecutiveSmileFrames = 0
        print("Smile detection started")
    }

    func stopSmileDetection() {
        isSmileDetectionActive = false
        consecutiveSmileFrames = 0
        print("Smile detection stopped")
    }

    func stopCamera() {
        sessionQueue.async { [weak self] in
            self?.captureSession?.stopRunning()
            self?.isSmileDetectionActive = false

            DispatchQueue.main.async {
                self?.previewLayer?.removeFromSuperlayer()
            }

            print("Camera stopped")
        }
    }

    func getCapturedImagePath() -> String? {
        return capturedImagePath
    }

    func getCapturedImageData() -> FlutterStandardTypedData? {
        guard let data = capturedImageData else { return nil }
        return FlutterStandardTypedData(bytes: data)
    }

    private func processImageForSmileDetection(sampleBuffer: CMSampleBuffer) {
        guard isSmileDetectionActive else { return }

        // フレームレート制御
        let currentTime = CACurrentMediaTime()
        if currentTime - lastFrameProcessedTime < Self.FRAME_INTERVAL {
            return
        }
        lastFrameProcessedTime = currentTime

        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        // CVPixelBuffer を MPImage に変換
        let mpImage = try? MPImage(pixelBuffer: imageBuffer)
        guard let mpImage = mpImage else { return }

        // MediaPipeで処理
        let timestampMs = Int(currentTime * 1000)
        guard let result = try? faceLandmarker?.detect(videoFrame: mpImage, timestampInMilliseconds: timestampMs) else {
            return
        }

        // 笑顔判定
        let isSmiling = detectSmile(result: result)

        // 連続フレーム判定
        if isSmiling {
            consecutiveSmileFrames += 1
        } else {
            consecutiveSmileFrames = 0
        }

        let isSmilingConfirmed = consecutiveSmileFrames >= Self.CONSECUTIVE_FRAMES_REQUIRED

        // Flutter側に送信
        DispatchQueue.main.async { [weak self] in
            self?.eventSink?([
                "isSmiling": isSmilingConfirmed,
                "confidence": isSmiling ? Self.SMILE_THRESHOLD : 0.0,
                "timestamp": Int(currentTime * 1000)
            ])
        }
    }

    private func detectSmile(result: FaceLandmarkerResult) -> Bool {
        guard let blendshapes = result.faceBlendshapes.first else {
            return false
        }

        var smileScore: Float = 0.0
        var smileCount = 0

        for category in blendshapes.categories {
            if category.categoryName == "mouthSmileLeft" || category.categoryName == "mouthSmileRight" {
                smileScore += category.score
                smileCount += 1
            }
        }

        if smileCount > 0 {
            let averageSmileScore = smileScore / Float(smileCount)
            return averageSmileScore > Self.SMILE_THRESHOLD
        }

        return false
    }
}

// MARK: - FlutterStreamHandler
extension NativeCameraHandler: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension NativeCameraHandler: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }

        guard let imageData = photo.fileDataRepresentation() else { return }

        // 一時ファイルに保存
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileName = "capture_\(Int(Date().timeIntervalSince1970)).jpg"
        let fileURL = tempDirectory.appendingPathComponent(fileName)

        do {
            try imageData.write(to: fileURL)
            capturedImagePath = fileURL.path
            capturedImageData = imageData
            print("Image captured: \(fileURL.path)")
        } catch {
            print("Error saving captured image: \(error)")
        }
    }
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
extension NativeCameraHandler: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        processImageForSmileDetection(sampleBuffer: sampleBuffer)
    }
}
