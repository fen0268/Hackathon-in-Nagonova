# MediaPipe Models

このディレクトリにMediaPipeのFaceLandmarkerモデルを配置してください。

## ダウンロード

以下のURLからモデルファイルをダウンロードしてください:

https://storage.googleapis.com/mediapipe-models/face_landmarker/face_landmarker/float16/1/face_landmarker.task

ダウンロードしたファイルを `face_landmarker.task` という名前でこのディレクトリに配置してください。

```
android/app/src/main/assets/
  └── face_landmarker.task
```

## 注意

- このモデルファイルは約 10MB のサイズです
- .gitignore に追加されているため、Git には含まれません
- 各開発者は個別にダウンロードする必要があります
