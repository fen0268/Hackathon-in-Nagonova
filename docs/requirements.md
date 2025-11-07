# にらめっこアプリ 要件定義書

**プロジェクト名**: にらめっこ（仮）
**作成日**: 2025-11-07
**バージョン**: 1.0

---

## 1. プロジェクト概要

### 1.1 目的
若者向けの暇つぶし用1対1オンラインにらめっこ対決アプリの開発。
ランダムマッチング、リアルタイム対戦、笑顔判定による勝敗決定を実現する。

### 1.2 ターゲットユーザー
- ライトユーザー〜カジュアルゲーマー
- スマートフォンユーザー（iOS/Android）
- 暇つぶし・エンタメ目的のユーザー

### 1.3 MVP仕様
- 完全無料
- 匿名認証（ニックネームのみ）
- ランダムマッチング
- 1対1対戦
- 笑顔判定による自動勝敗判定

---

## 2. 技術スタック

### 2.1 開発環境
- **フロントエンド**: Flutter（iOS/Android クロスプラットフォーム）
- **バックエンド**: Firebase
  - Authentication（匿名認証）
  - Firestore（データベース）
  - Storage（画像保存）
  - Hosting（Webホスティング）
- **笑顔判定**: MediaPipe（iOS/Android ネイティブ実装）
- **アニメーション**: Lottie

### 2.2 MediaPipe 仕様
- **実装方式**: iOS（Swift）、Android（Kotlin）のネイティブ実装
- **笑顔判定閾値**: 0.7
- **処理フレームレート**: 20fps
- **判定条件**: 連続3フレーム以上で閾値超過

---

## 3. 主要機能

### 3.1 認証・ユーザー管理
- **認証方式**: Firebase Anonymous Authentication
- **ユーザー情報**:
  - ニックネーム（ランダム生成 or ユーザー設定）
  - 累計対戦数
  - 勝利数
  - 勝率

### 3.2 マッチング機能
- **方式**: ランダムマッチング
- **仕様**:
  - マッチング待機キューに追加
  - 先着順で2人をペアリング
  - マッチング成立後、即座に対戦画面へ遷移

### 3.3 対戦機能

#### 3.3.1 対戦フロー

```
カウントダウン (5→4→3→2→1→0)
↓
撮影（音あり）→ Firebase Storage アップロード
↓
5秒待機（自動的に次へ進む）
  - 5秒後に自動的に画像表示画面へ遷移
  - URLがない場合の判定:
    - 片方のみURLなし → その人の負け → result 画面
    - 両方URLなし → 引き分け → result 画面
↓
画像表示 + MediaPipe 起動 + にらめっこ開始（10秒）
↓
【勝敗判定】
  - 笑顔検知（10秒以内）→ 笑った方の負け → result 画面
  - 10秒経過しても笑わず → 引き分け → result 画面
```

#### 3.3.2 勝敗パターン

| 状況 | 結果 |
|---------|--------|
| player1が笑った | player2が勝 |
| player2が笑った | player1が勝 |
| player1のURLなし | player2が勝 |
| player2のURLなし | player1が勝 |
| 両者URLなし | 引き分け |
| 両者10秒間笑わず | 引き分け |

#### 3.3.3 画像仕様
- **撮影タイミング**: カウントダウン0秒時点（自動撮影、音あり）
- **画像サイズ**: 640x480 JPEG
- **画質**: 80%
- **保存先**: Firebase Storage
- **保存パス**: `matches/{matchId}/round{N}_player{N}.jpg`
- **削除ポリシー**: 削除なし（永続保存）

#### 3.3.4 表示仕様
- **対戦画面レイアウト**:
  - 相手の静止画（大画面）
  - 自分のリアルタイムカメラ（プレビューはない）
  - 笑顔判定状態表示
  - 残り時間表示

### 3.5 ランキング機能
- **表示内容**:
  - 全体ランキング（勝率順）
  - ユーザーニックネーム
  - 累計対戦数
  - 勝利数
  - 勝率
- **更新頻度**: リアルタイム（Firestore リアルタイム集計）

### 3.6 結果画面
- **表示内容**:
  - 勝敗結果
  - 対戦相手のニックネーム
  - 統計情報（反応速度など）
  - 再戦ボタン
  - ホームに戻るボタン
- **アニメーション**: Lottie による勝利/敗北演出

---

## 4. データベース設計

### 4.1 Firestore コレクション

#### 4.1.1 users コレクション
```javascript
{
  userId: "auto-generated",
  nickname: "ユーザー123",
  createdAt: timestamp,
  totalMatches: 0,
  wins: 0,
  winRate: 0.0
}
```

#### 4.1.2 matches コレクション
```javascript
{
  matchId: "auto-generated",
  player1: "userId1",
  player2: "userId2",

  status: "waiting",

  startedAt: timestamp,
  finishedAt: null,

  // 画像
  player1ImageUrl: null,
  player2ImageUrl: null,

  // タイミング
  shootingAt: null,                  // 撮影時刻（カウントダウン0）
  player1UploadedAt: null,           // アップロード完了時刻
  player2UploadedAt: null,
  imagesDisplayedAt: null,           // 画像表示時刻（5秒後）

  // 笑顔判定
  player1SmileDetectedAt: null,
  player2SmileDetectedAt: null,

  // 結果
  winner: null,
  // "player1" | "player2" | "draw" |
  // "url_missing_player1" | "url_missing_player2" | "url_missing_both"
  gameEndedAt: null,

  // 統計
  player1UploadTime: null,           // 撮影→アップロード (秒)
  player2UploadTime: null,
  player1ReactionTime: null,         // 画像表示→笑顔検知 (秒)
  player2ReactionTime: null,

  createdAt: timestamp
}
```

#### 4.1.3 matchmaking コレクション
```javascript
{
  userId: "userId1",
  status: "waiting",  // waiting | matched
  createdAt: timestamp,
  matchedWith: null,
  matchId: null
}
```

#### 4.1.4 rankings コレクション
```javascript
{
  userId: "userId1",
  nickname: "ユーザー123",
  totalMatches: 10,
  wins: 7,
  winRate: 0.7,
  updatedAt: timestamp
}
```

---

## 5. 画面遷移

```
起動
↓
auth_page（匿名認証）
↓
home_page（ホーム画面）
├─ マッチング開始 → マッチング待機 → game_page
├─ ランキング表示
└─ 設定
↓
game_page（対戦画面）
├─ 5秒カウントダウン後に撮影
├─ 準備待機
├─ 10秒カウント
├─ にらめっこ対戦
└─ 勝敗判定
↓
result_page（結果画面）
├─ 再戦 → マッチング待機
└─ ホームに戻る → home_page
```

---

## 6. 技術検証項目

### 6.1 優先度A（MVP必須）
1. **MediaPipe 笑顔判定の精度検証**
   - Flutter プラグイン統合
   - 閾値調整（0.7 → 最適値探索）
   - 処理速度（20fps 目標）

2. **Firebase Storage アップロード速度**
   - 画像サイズ: 640x480 JPEG（品質80）
   - 想定転送時間: 1〜2秒
   - エラーハンドリング

3. **Firestore リアルタイム同期レイテンシ**
   - 準備完了フラグ監視
   - 両者の同期ずれ許容範囲: ±500ms

### 6.2 優先度B（リリース前推奨）
4. **カメラ撮影音の実装**
   - iOS/Android それぞれの実装確認

5. **3秒カウントダウンのタイミング精度**
   - 両者の同期精度検証

### 6.3 優先度C（改善フェーズ）
6. **画像圧縮最適化**
   - 転送速度 vs 画質のバランス調整

7. **ランキングのパフォーマンス最適化**
   - 大量ユーザー時の集計速度

---

## 7. 非機能要件

### 7.1 パフォーマンス
- 笑顔判定: 20fps
- マッチング時間: 30秒以内
- 画像アップロード: 10秒以内

### 7.2 セキュリティ
- Firebase Security Rules によるデータアクセス制御
- 匿名認証によるユーザー識別

### 7.3 スケーラビリティ
- Firestore 自動スケーリング
- Firebase Storage CDN 配信

---

## 8. 今後の拡張可能性

### 8.1 追加機能候補
- フレンド機能
- プライベートマッチ
- アバター・カスタマイズ
- リプレイ機能
- ボイスチャット

### 8.2 収益化
- 広告表示
- プレミアム機能（絵文字追加など）

---

## 9. 開発スケジュール（仮）

| フェーズ | 期間 | 内容 |
|---------|------|------|
| 技術検証 | 1週間 | MediaPipe統合、Firebase検証 |
| 基本機能開発 | 2週間 | 認証、マッチング、対戦画面 |
| 判定機能開発 | 1週間 | 笑顔判定、勝敗ロジック |
| UI/UX調整 | 1週間 | デザイン、アニメーション |
| テスト | 1週間 | 総合テスト、バグ修正 |
| リリース準備 | 3日 | ストア申請、ドキュメント整備 |

**合計**: 約6週間

---

## 10. リスク管理

### 10.1 技術リスク
- **MediaPipe の精度問題**: 閾値調整、代替ライブラリ検討
- **Firebase 遅延**: タイムアウト処理の実装
- **クロスプラットフォーム互換性**: iOS/Android 個別対応

### 10.2 ユーザー体験リスク
- **マッチング待機時間長期化**: ボット対戦の検討
- **不適切行為**: 報告機能、運営監視

---

## 付録

### A. 用語集
- **MVP**: Minimum Viable Product（実用最小限の製品）
- **MediaPipe**: Google 製の機械学習フレームワーク
- **Firestore**: Firebase のリアルタイムデータベース
- **Lottie**: Adobe After Effects アニメーションを表示するライブラリ

### B. 参考リンク
- Flutter: https://flutter.dev/
- Firebase: https://firebase.google.com/
- MediaPipe: https://mediapipe.dev/
