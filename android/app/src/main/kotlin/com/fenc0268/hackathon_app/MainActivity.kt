package com.fenc0268.hackathon_app

import android.Manifest
import android.content.pm.PackageManager
import android.os.Bundle
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CAMERA_CHANNEL = "com.fenc0268.hackathon_app/camera"
    private val CAMERA_EVENTS_CHANNEL = "com.fenc0268.hackathon_app/camera_events"
    private val CAMERA_VIEW_TYPE = "com.fenc0268.hackathon_app/camera_view"
    private val CAMERA_PERMISSION_REQUEST_CODE = 100

    private var methodChannel: MethodChannel? = null
    private var eventChannel: EventChannel? = null
    private var nativeCameraHandler: NativeCameraHandler? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Event Channel のセットアップ（先に作成）
        eventChannel = EventChannel(flutterEngine.dartExecutor.binaryMessenger, CAMERA_EVENTS_CHANNEL)

        // NativeCameraHandler の初期化
        nativeCameraHandler = NativeCameraHandler(this, eventChannel!!)

        // Platform View の登録
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory(
                CAMERA_VIEW_TYPE,
                NativeCameraViewFactory(nativeCameraHandler!!)
            )

        // Method Channel のセットアップ
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CAMERA_CHANNEL)
        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "startCamera" -> {
                    val countdownSeconds = call.argument<Int>("countdownSeconds") ?: 5
                    startCamera(countdownSeconds, result)
                }
                "startSmileDetection" -> {
                    nativeCameraHandler?.startSmileDetection()
                    result.success(null)
                }
                "stopSmileDetection" -> {
                    nativeCameraHandler?.stopSmileDetection()
                    result.success(null)
                }
                "stopCamera" -> {
                    nativeCameraHandler?.stopCamera()
                    result.success(null)
                }
                "getCapturedImagePath" -> {
                    val path = nativeCameraHandler?.getCapturedImagePath()
                    result.success(path)
                }
                "getCapturedImageData" -> {
                    val data = nativeCameraHandler?.getCapturedImageData()
                    result.success(data)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun startCamera(countdownSeconds: Int, result: MethodChannel.Result) {
        if (checkCameraPermission()) {
            nativeCameraHandler?.startCamera(countdownSeconds) {
                // 撮影完了をFlutter側に返す
                result.success(null)
            }
        } else {
            requestCameraPermission()
            result.error("PERMISSION_DENIED", "Camera permission not granted", null)
        }
    }

    private fun checkCameraPermission(): Boolean {
        return ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.CAMERA
        ) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestCameraPermission() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(Manifest.permission.CAMERA),
            CAMERA_PERMISSION_REQUEST_CODE
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == CAMERA_PERMISSION_REQUEST_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // Permission granted
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        nativeCameraHandler?.cleanup()
        methodChannel?.setMethodCallHandler(null)
    }
}
