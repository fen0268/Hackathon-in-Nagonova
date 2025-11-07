# MediaPipe Models

このディレクトリにMediaPipeのFaceLandmarkerモデルを配置してください。

## ダウンロード

以下のURLからモデルファイルをダウンロードしてください:

https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/1/face_landmarker.task

ダウンロードしたファイルを `face_landmarker.task` という名前でこのディレクトリに配置してください。

```
ios/Runner/Resources/
  └── face_landmarker.task
```

その後、Xcodeで以下の操作を行ってください:
1. Xcodeでプロジェクトを開く
2. `face_landmarker.task` ファイルを `Runner` ターゲットに追加
3. "Copy items if needed" にチェック
4. "Add to targets" で `Runner` を選択

## 注意

- このモデルファイルは約 10MB のサイズです
- .gitignore に追加されているため、Git には含まれません
- 各開発者は個別にダウンロードして追加する必要があります
