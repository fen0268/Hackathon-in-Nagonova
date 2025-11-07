import Flutter
import UIKit

class NativeCameraViewFactory: NSObject, FlutterPlatformViewFactory {
    private var handler: NativeCameraHandler

    init(handler: NativeCameraHandler) {
        self.handler = handler
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return NativeCameraView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            handler: handler
        )
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class NativeCameraView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var handler: NativeCameraHandler

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        handler: NativeCameraHandler
    ) {
        _view = UIView(frame: frame)
        _view.backgroundColor = .black
        self.handler = handler
        super.init()

        // カメラプレビューのビューとして使用
        handler.setCameraPreviewContainer(_view)
    }

    func view() -> UIView {
        return _view
    }
}
