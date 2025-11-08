import 'dart:async';

import 'package:flutter/services.dart';

/// ネイティブカメラの状態
enum NativeCameraState {
  idle, // 待機中
  preparing, // 準備中
  countdown, // カウントダウン中
  captured, // 撮影完了
  judging, // 笑顔判定中
  finished, // 終了
}

/// 笑顔判定結果
class SmileDetectionResult {
  SmileDetectionResult({
    required this.isSmiling,
    required this.confidence,
    required this.timestamp,
  });

  factory SmileDetectionResult.fromMap(Map<dynamic, dynamic> map) {
    return SmileDetectionResult(
      isSmiling: map['isSmiling'] as bool,
      confidence: (map['confidence'] as num).toDouble(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        map['timestamp'] as int,
      ),
    );
  }

  final bool isSmiling;
  final double confidence;
  final DateTime timestamp;
}

/// ネイティブカメラサービス
/// iOS/Android のネイティブカメラとMediaPipeを制御する
class NativeCameraService {
  static const MethodChannel _methodChannel =
      MethodChannel('com.example.hackathon_app/camera');
  static const EventChannel _eventChannel =
      EventChannel('com.example.hackathon_app/camera_events');

  Stream<SmileDetectionResult>? _smileDetectionStream;
  StreamSubscription<SmileDetectionResult>? _smileSubscription;

  NativeCameraState _state = NativeCameraState.idle;
  NativeCameraState get state => _state;

  void dispose() {
    stopCamera();
    _smileSubscription?.cancel();
  }

  /// カメラを起動してカウントダウン開始
  /// countdownSeconds: カウントダウン秒数（デフォルト5秒）
  Future<void> startCameraWithCountdown({int countdownSeconds = 5}) async {
    try {
      _state = NativeCameraState.preparing;

      await _methodChannel.invokeMethod('startCamera', {
        'countdownSeconds': countdownSeconds,
      });

      _state = NativeCameraState.captured;
    } on PlatformException catch (e) {
      throw Exception('Failed to start camera: ${e.message}');
    }
  }

  /// 笑顔判定を開始
  Future<void> startSmileDetection() async {
    try {
      await _methodChannel.invokeMethod('startSmileDetection');
      _state = NativeCameraState.judging;
    } on PlatformException catch (e) {
      throw Exception('Failed to start smile detection: ${e.message}');
    }
  }

  /// 笑顔判定を停止
  Future<void> stopSmileDetection() async {
    try {
      await _methodChannel.invokeMethod('stopSmileDetection');
    } on PlatformException catch (e) {
      throw Exception('Failed to stop smile detection: ${e.message}');
    }
  }

  /// カメラを停止
  Future<void> stopCamera() async {
    try {
      await _methodChannel.invokeMethod('stopCamera');
      _state = NativeCameraState.idle;
    } on PlatformException catch (e) {
      throw Exception('Failed to stop camera: ${e.message}');
    }
  }

  /// 撮影完了を通知（ネイティブ側から呼ばれる）
  void onCaptureCompleted(String imagePath) {
    _state = NativeCameraState.captured;
  }

  /// 笑顔判定結果のストリームを取得
  Stream<SmileDetectionResult> get smileDetectionStream {
    _smileDetectionStream ??= _eventChannel
        .receiveBroadcastStream()
        .map((event) => SmileDetectionResult.fromMap(event as Map));
    return _smileDetectionStream!;
  }

  /// 笑顔判定結果を監視
  void listenToSmileDetection(
    void Function(SmileDetectionResult) onData,
  ) {
    _smileSubscription?.cancel();
    _smileSubscription = smileDetectionStream.listen(onData);
  }

  /// 撮影した画像のパスを取得
  Future<String?> getCapturedImagePath() async {
    try {
      final path = await _methodChannel.invokeMethod<String>(
        'getCapturedImagePath',
      );
      return path;
    } on PlatformException catch (e) {
      throw Exception('Failed to get captured image path: ${e.message}');
    }
  }

  /// 撮影した画像データを取得
  Future<Uint8List?> getCapturedImageData() async {
    try {
      final data = await _methodChannel.invokeMethod<Uint8List>(
        'getCapturedImageData',
      );
      return data;
    } on PlatformException catch (e) {
      throw Exception('Failed to get captured image data: ${e.message}');
    }
  }
}
