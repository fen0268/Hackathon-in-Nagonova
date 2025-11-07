import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/feature/game/component/native_camera_view.dart';
import 'package:hackathon_app/feature/game/service/game_state_provider.dart';
import 'package:hackathon_app/feature/result/result_page.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({required this.matchId, super.key});

  final String matchId;
  static const routeName = '/game';

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  bool _hasNavigatedToResult = false;

  @override
  void initState() {
    super.initState();

    // ゲーム開始を少し遅延させてUIが準備できるまで待つ
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        ref.read(gameStateProvider(widget.matchId).notifier).startGame();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider(widget.matchId));

    // エラーがある場合
    if (gameState.error != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                'エラーが発生しました',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                gameState.error!,
                style: const TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('ホームに戻る'),
              ),
            ],
          ),
        ),
      );
    }

    // ゲーム終了時は結果画面へ遷移（1回のみ）
    if (gameState.phase == GamePhase.finished && !_hasNavigatedToResult) {
      _hasNavigatedToResult = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.pushReplacement(
            ResultPage.routeName,
            extra: {'matchId': widget.matchId},
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // メインコンテンツ
            Column(
              children: [
                _buildHeader(gameState),
                Expanded(
                  child: _buildMainContent(gameState),
                ),
              ],
            ),
            // ローディングオーバーレイ（撮影後のアップロード中）
            if (gameState.isUploading)
              ColoredBox(
                color: Colors.black.withValues(alpha: 0.8),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 3,
                      ),
                      SizedBox(height: 24),
                      Text(
                        '撮影完了',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        '画像をアップロード中...',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// ヘッダー部分（残り時間など）
  Widget _buildHeader(GameState gameState) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // フェーズに応じた情報表示（対戦中のみ表示）
          if (gameState.phase == GamePhase.playing)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '残り時間: ${gameState.playingTimeRemaining}秒',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// メインコンテンツ（フェーズごとに表示を切り替え）
  Widget _buildMainContent(GameState gameState) {
    switch (gameState.phase) {
      case GamePhase.waiting:
        return _buildWaitingView();

      case GamePhase.countdown:
        return _buildCountdownView(gameState);

      case GamePhase.preparing:
        return _buildPreparingView(gameState);

      case GamePhase.playing:
        return _buildPlayingView(gameState);

      case GamePhase.finished:
        return _buildFinishedView();
    }
  }

  /// 待機中の表示
  Widget _buildWaitingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 24),
          Text(
            'ゲームを開始しています...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  /// 撮影前のカウントダウン表示（5→4→3→2→1）
  /// ネイティブ側でカメラビューとカウントダウンUIを表示
  Widget _buildCountdownView(GameState gameState) {
    // ネイティブ側でカウントダウンUIを表示するため、Flutter側はシンプルに表示
    return const SizedBox.expand(
      child: NativeCameraView(),
    );
  }

  /// 準備中の表示（5秒自動待機）
  Widget _buildPreparingView(GameState gameState) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Colors.white),
          const SizedBox(height: 24),
          const Text(
            '画像をアップロード中...',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${gameState.preparingTimeRemaining}秒後に自動的に開始します',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  /// にらめっこ対戦中の表示
  Widget _buildPlayingView(GameState gameState) {
    return Column(
      children: [
        // 相手の画像（大きく表示）
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            color: Colors.grey[900],
            child: gameState.opponentImageUrl != null
                ? CachedNetworkImage(
                    imageUrl: gameState.opponentImageUrl!,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error, color: Colors.red, size: 48),
                    ),
                  )
                : const Center(
                    child: Text(
                      '画像を読み込み中...',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
          ),
        ),

        // 笑顔判定状態
        Container(
          padding: const EdgeInsets.all(16),
          color: gameState.isPlayerSmiling
              ? Colors.red[900]
              : Colors.green[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                gameState.isPlayerSmiling
                    ? Icons.sentiment_very_satisfied
                    : Icons.sentiment_neutral,
                color: Colors.white,
                size: 32,
              ),
              const SizedBox(width: 12),
              Text(
                gameState.isPlayerSmiling ? '笑顔を検出中...' : '真顔を保持中',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // カメラプレビュー（小さく表示）
        Expanded(
          flex: 2,
          child: Container(
            width: double.infinity,
            color: Colors.black,
            child: const Center(
              child: Text(
                'カメラプレビュー\n（ネイティブ実装）',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 終了時の表示
  Widget _buildFinishedView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 24),
          Text(
            'ゲーム終了\n結果を集計中...',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
