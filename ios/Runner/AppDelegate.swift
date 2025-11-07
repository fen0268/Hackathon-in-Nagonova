import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let CAMERA_CHANNEL = "com.example.hackathon_app/camera"
    private let CAMERA_EVENTS_CHANNEL = "com.example.hackathon_app/camera_events"
    private let CAMERA_VIEW_TYPE = "com.example.hackathon_app/camera_view"

    private var nativeCameraHandler: NativeCameraHandler?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        guard let controller = window?.rootViewController as? FlutterViewController else {
            fatalError("rootViewController is not type FlutterViewController")
        }

        // Method Channel のセットアップ
        let methodChannel = FlutterMethodChannel(
            name: CAMERA_CHANNEL,
            binaryMessenger: controller.binaryMessenger
        )

        // Event Channel のセットアップ
        let eventChannel = FlutterEventChannel(
            name: CAMERA_EVENTS_CHANNEL,
            binaryMessenger: controller.binaryMessenger
        )

        // NativeCameraHandler の初期化
        nativeCameraHandler = NativeCameraHandler(
            viewController: controller,
            eventChannel: eventChannel
        )

        // Platform View の登録
        let registrar = self.registrar(forPlugin: "NativeCameraViewPlugin")
        let factory = NativeCameraViewFactory(handler: nativeCameraHandler!)
        registrar?.register(factory, withId: CAMERA_VIEW_TYPE)

        // Method Channel ハンドラー
        methodChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self = self else { return }

            switch call.method {
            case "startCamera":
                if let args = call.arguments as? [String: Any],
                   let countdownSeconds = args["countdownSeconds"] as? Int {
                    self.nativeCameraHandler?.startCamera(countdownSeconds: countdownSeconds) {
                        // 撮影完了をFlutter側に返す
                        result(nil)
                    }
                } else {
                    result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
                }

            case "startSmileDetection":
                self.nativeCameraHandler?.startSmileDetection()
                result(nil)

            case "stopSmileDetection":
                self.nativeCameraHandler?.stopSmileDetection()
                result(nil)

            case "stopCamera":
                self.nativeCameraHandler?.stopCamera()
                result(nil)

            case "getCapturedImagePath":
                result(self.nativeCameraHandler?.getCapturedImagePath())

            case "getCapturedImageData":
                result(self.nativeCameraHandler?.getCapturedImageData())

            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
