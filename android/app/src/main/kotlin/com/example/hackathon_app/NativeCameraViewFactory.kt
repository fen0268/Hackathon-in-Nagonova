package com.example.hackathon_app

import android.content.Context
import android.view.View
import android.widget.FrameLayout
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeCameraViewFactory(
    private val handler: NativeCameraHandler
) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return NativeCameraView(context, handler)
    }
}

class NativeCameraView(
    context: Context,
    private val handler: NativeCameraHandler
) : PlatformView {

    private val containerView: FrameLayout = FrameLayout(context).apply {
        setBackgroundColor(android.graphics.Color.BLACK)
    }

    init {
        // カメラプレビューのコンテナとして使用
        handler.setCameraPreviewContainer(containerView)
    }

    override fun getView(): View {
        return containerView
    }

    override fun dispose() {
        // Clean up
    }
}
