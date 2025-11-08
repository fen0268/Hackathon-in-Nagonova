import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ネイティブカメラビューを表示するウィジェット
/// iOS: UiKitView、Android: AndroidView を使用
class NativeCameraView extends StatelessWidget {
  const NativeCameraView({super.key});

  static const String viewType = 'com.fenc0268.hackathon_app/camera_view';

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return const UiKitView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: <String, dynamic>{},
        creationParamsCodec: StandardMessageCodec(),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            EagerGestureRecognizer.new,
          ),
        },
      );
    } else if (Platform.isAndroid) {
      return const AndroidView(
        viewType: viewType,
        layoutDirection: TextDirection.ltr,
        creationParams: <String, dynamic>{},
        creationParamsCodec: StandardMessageCodec(),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory<OneSequenceGestureRecognizer>(
            EagerGestureRecognizer.new,
          ),
        },
      );
    } else {
      return const Center(
        child: Text(
          'このプラットフォームはサポートされていません',
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }
}
