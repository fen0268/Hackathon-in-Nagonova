# にらめっこアプリ

若者向けの暇つぶし用1対1オンラインにらめっこ対決アプリ。
ランダムマッチング、リアルタイム対戦、笑顔判定による勝敗決定を実現します。

## 主な機能

- **ランダムマッチング**: 待機中のユーザーとリアルタイムでマッチング
- **1対1にらめっこ対戦**: カメラで変顔を撮影し、相手の顔を見て笑ったら負け
- **笑顔判定**: MediaPipeによる自動判定（閾値0.7、20fps）
- **2ラウンド制**: 最大2ラウンドで勝敗を決定
- **絵文字エフェクト**: 相手を笑わせる戦略要素
- **ランキング**: 勝率順のリアルタイムランキング

## 技術スタック

- **Flutter 3.35.7** (FVM管理)
- **Riverpod** (状態管理)
- **GoRouter** (ルーティング)
- **Firebase**
  - Authentication (匿名認証)
  - Firestore (データベース)
  - Storage (画像保存)
- **MediaPipe** (iOS/Android ネイティブ実装で笑顔判定)
- **Lottie** (勝敗アニメーション)

## セットアップ

```bash
# FVMでFlutterバージョンを使用
fvm flutter pub get

# Riverpodコード生成
fvm flutter pub run build_runner build
```

## 実行

```bash
# アプリ起動
fvm flutter run

# コード生成（watch mode）
fvm flutter pub run build_runner watch
```

## プロジェクト構成

```
lib/
├── feature/          # 機能別モジュール
│   ├── auth/        # 認証
│   ├── home/        # ホーム画面
│   ├── capture/     # 撮影
│   └── effect/      # エフェクト
├── config/          # 設定（ルーター等）
├── util/            # ユーティリティ関数
├── app.dart         # ルートウィジェット
└── main.dart        # エントリーポイント
```

## ドキュメント

- [要件定義書](docs/requirements.md) - 詳細な仕様とデータベース設計
- [CLAUDE.md](CLAUDE.md) - 開発ガイド（Claude Code向け）

## 対象ユーザー

- ライトユーザー〜カジュアルゲーマー
- 暇つぶし・エンタメ目的のスマホユーザー（iOS/Android）
