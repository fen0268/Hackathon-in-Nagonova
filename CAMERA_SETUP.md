# ネイティブカメラ機能 セットアップガイド

このドキュメントは、にらめっこアプリのネイティブカメラ機能を実装するためのセットアップ手順を説明します。

## 概要

このアプリは以下の技術スタックを使用しています:

- **Flutter**: UI フレームワーク
- **ネイティブカメラ (iOS/Android)**: カメラ撮影とプレビュー
- **MediaPipe (iOS/Android)**: リアルタイム笑顔判定
- **Method Channel & Event Channel**: Flutter ⇔ ネイティブ間の通信

## アーキテクチャ

```
┌─────────────────────────────────────────────────────────┐
│                    Flutter Layer                        │
│  - game_page.dart (UI)                                  │
│  - native_camera_service.dart (Bridge)                  │
└─────────────────────────────────────────────────────────┘
                          ↕
           Method Channel / Event Channel
                          ↕
┌─────────────────────────────────────────────────────────┐
│                   Native Layer                          │
│  iOS (Swift)              Android (Kotlin)              │
│  - NativeCameraHandler    - NativeCameraHandler         │
│  - AVFoundation           - CameraX                     │
│  - MediaPipe Tasks        - MediaPipe Tasks             │
└─────────────────────────────────────────────────────────┘
```

## セットアップ手順

### 1. MediaPipe モデルファイルのダウンロード

#### Android

1. 以下の URL からモデルファイルをダウンロード:

   ```
   https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/1/face_landmarker.task
   ```

2. ダウンロードしたファイルを以下のディレクトリに配置:
   ```
   android/app/src/main/assets/face_landmarker.task
   ```

#### iOS

1. 同じ URL からモデルファイルをダウンロード

2. ダウンロードしたファイルを以下のディレクトリに配置:

   ```
   ios/Runner/Resources/face_landmarker.task
   ```

3. Xcode でプロジェクトを開く:

   ```bash
   open ios/Runner.xcworkspace
   ```

4. Xcode で以下の操作を実行:
   - `face_landmarker.task` ファイルをプロジェクトにドラッグ&ドロップ
   - "Copy items if needed" にチェック
   - "Add to targets" で `Runner` を選択

### 2. 依存関係のインストール

#### Android

依存関係は `android/app/build.gradle.kts` に既に追加されています。

Gradle 同期を実行:

```bash
cd android && ./gradlew build
```

#### iOS

依存関係は `ios/Podfile` に既に追加されています。

CocoaPods をインストール:

```bash
cd ios && pod install
```

### 3. カメラ権限の設定

#### Android

`android/app/src/main/AndroidManifest.xml` に既に追加済み:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" android:required="true" />
```

#### iOS

`ios/Runner/Info.plist` に既に追加済み:

```xml
<key>NSCameraUsageDescription</key>
<string>このアプリはにらめっこ対戦のためにカメラを使用します</string>
```

### 4. アプリのビルドと実行

```bash
# Flutter依存関係の取得
fvm flutter pub get

# iOS の場合
fvm flutter run -d ios

# Android の場合
fvm flutter run -d android
```

## 実装フロー

### 1. カメラ起動からカウントダウン

```dart
// Flutter側
await cameraService.startCameraWithCountdown(countdownSeconds: 5);

// ↓ Method Channel

// Native側（iOS/Android）
- カメラセッション初期化
- MediaPipe 初期化（判定は無効状態）
- カウントダウン開始（5→4→3→2→1→0）
- カウント0で自動撮影
```

### 2. 撮影完了

```dart
// Native側
- 画像をキャプチャ
- 一時ファイルに保存
- 画像データを保持

// Flutter側
- 撮影完了画面を表示
- 3秒待機
```

### 3. 笑顔判定開始

```dart
// Flutter側
await cameraService.startSmileDetection();

// ↓ Method Channel

// Native側
- isSmileDetectionActive = true
- カメラフレームを20fpsでMediaPipeに送信
- 笑顔スコアが閾値(0.7)を超えたら判定

// ↓ Event Channel (ストリーム)

// Flutter側
- リアルタイムで判定結果を受信
- isSmiling == true → 負け判定
- 15秒経過 → 勝ち判定
```

## 主要クラス

### Flutter 側

#### `NativeCameraService`

- Method Channel / Event Channel を管理
- ネイティブ側の機能を呼び出す API 提供

**主要メソッド:**

- `startCameraWithCountdown()`: カメラ起動＋カウントダウン
- `startSmileDetection()`: 笑顔判定開始
- `stopSmileDetection()`: 笑顔判定停止
- `stopCamera()`: カメラ停止
- `smileDetectionStream`: 判定結果のストリーム

#### `GamePage`

- ゲーム画面の UI
- カウントダウン、撮影、判定のフロー制御

### Android 側

#### `MainActivity.kt`

- Method Channel / Event Channel のハンドラー登録
- カメラ権限管理

#### `NativeCameraHandler.kt`

- CameraX によるカメラ制御
- MediaPipe による笑顔判定
- Event Channel で Flutter 側に結果を送信

**主要機能:**

- カメラプレビュー表示
- 写真撮影
- リアルタイム笑顔判定（20fps）

### iOS 側

#### `AppDelegate.swift`

- Method Channel / Event Channel のハンドラー登録

#### `NativeCameraHandler.swift`

- AVFoundation によるカメラ制御
- MediaPipe による笑顔判定
- Event Channel で Flutter 側に結果を送信

**主要機能:**

- カメラプレビュー表示
- 写真撮影
- リアルタイム笑顔判定（20fps）

## MediaPipe 笑顔判定の仕組み

1. **Face Landmarker** を使用して顔のランドマーク（468 点）と表情データ（BlendShapes）を取得

2. **BlendShapes** から以下の値を抽出:

   - `mouthSmileLeft`: 左口角の笑顔スコア
   - `mouthSmileRight`: 右口角の笑顔スコア

3. **判定ロジック:**

   ```
   averageSmileScore = (mouthSmileLeft + mouthSmileRight) / 2
   isSmiling = averageSmileScore > 0.5
   ```

4. **連続フレーム判定:**
   - 3 フレーム連続で笑顔を検出した場合のみ「笑った」と判定
   - 誤検知を防ぐための仕組み

## パフォーマンス設定

- **フレームレート**: 20fps（`TARGET_FPS = 20`）
- **笑顔判定閾値**: 0.7（`SMILE_THRESHOLD = 0.7`）
- **連続判定フレーム数**: 3（`CONSECUTIVE_FRAMES_REQUIRED = 3`）

これらの値は各ネイティブハンドラーで定義されており、調整可能です。

## トラブルシューティング

### カメラが起動しない

**iOS:**

- Info.plist に `NSCameraUsageDescription` が設定されているか確認
- シミュレーターではなく実機で実行しているか確認

**Android:**

- AndroidManifest.xml に `CAMERA` 権限が設定されているか確認
- 実行時にカメラ権限を許可したか確認

### MediaPipe のエラー

**モデルファイルが見つからない:**

- `face_landmarker.task` が正しいディレクトリに配置されているか確認
- iOS: Xcode のプロジェクトに追加されているか確認（Build Phases → Copy Bundle Resources）

**判定精度が低い:**

- 照明条件を改善
- 閾値を調整（`SMILE_THRESHOLD` の値を変更）

### 通信エラー

**Method Channel が動作しない:**

- チャネル名が一致しているか確認:
  - `com.fenc0268.hackathon_app/camera`
  - `com.fenc0268.hackathon_app/camera_events`

## 今後の拡張

### 実装済み

- ✅ カメラ起動・撮影
- ✅ カウントダウン機能
- ✅ リアルタイム笑顔判定（20fps）
- ✅ Flutter ⇔ Native 通信

### 今後実装予定

- ⬜ WebRTCを使用したビデオ通信用の実装
- ⬜ 絵文字エフェクト機能

## 参考リンク

- [MediaPipe Face Landmarker](https://developers.google.com/mediapipe/solutions/vision/face_landmarker)
- [Flutter Platform Channels](https://docs.flutter.dev/platform-integration/platform-channels)
- [CameraX (Android)](https://developer.android.com/training/camerax)
- [AVFoundation (iOS)](https://developer.apple.com/av-foundation/)
