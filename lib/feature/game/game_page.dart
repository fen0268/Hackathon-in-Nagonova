import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/feature/auth/service/auth_provider.dart';
import 'package:hackathon_app/feature/game/service/game_state_provider.dart';
import 'package:hackathon_app/feature/result/result_page.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({required this.matchId, super.key});

  final String matchId;
  static const routeName = '/game';

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage>
    with TickerProviderStateMixin {
  late AnimationController _countdownAnimationController;
  late Animation<double> _countdownScaleAnimation;

  @override
  void initState() {
    super.initState();

    // カウントダウンアニメーションの初期化
    _countdownAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _countdownScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _countdownAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    // ゲーム開始を少し遅延させてUIが準備できるまで待つ
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        ref.read(gameStateProvider(widget.matchId).notifier).startGame();
      }
    });
  }

  @override
  void dispose() {
    _countdownAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider(widget.matchId));

    // カウントダウンが変わったらアニメーション再生
    ref.listen<GameState>(
      gameStateProvider(widget.matchId),
      (previous, next) {
        if (previous?.countdown != next.countdown &&
            (next.phase == GamePhase.round1Countdown ||
                next.phase == GamePhase.round2Countdown)) {
          _countdownAnimationController.forward(from: 0);
        }
      },
    );

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

    // ゲーム終了時は結果画面へ遷移
    if (gameState.phase == GamePhase.finished) {
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

            // 戻るボタン
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  _showQuitDialog();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ヘッダー部分（ラウンド表示、残り時間など）
  Widget _buildHeader(GameState gameState) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ラウンド表示
          Text(
            'ラウンド ${gameState.currentRound}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // フェーズに応じた情報表示
          if (gameState.phase == GamePhase.round1Playing ||
              gameState.phase == GamePhase.round2Playing)
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
            )
          else if (gameState.phase == GamePhase.round1Preparing ||
              gameState.phase == GamePhase.round2Preparing)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '準備完了待ち: ${gameState.preparingTimeoutRemaining}秒',
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

      case GamePhase.round1Countdown:
      case GamePhase.round2Countdown:
        return _buildCountdownView(gameState);

      case GamePhase.round1Preparing:
      case GamePhase.round2Preparing:
        return _buildPreparingView(gameState);

      case GamePhase.round1CountdownToDisplay:
      case GamePhase.round2CountdownToDisplay:
        return _buildDisplayCountdownView(gameState);

      case GamePhase.round1Playing:
      case GamePhase.round2Playing:
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
  Widget _buildCountdownView(GameState gameState) {
    // カウントダウンに応じて色を変化
    Color getCountdownColor(int countdown) {
      switch (countdown) {
        case 5:
          return Colors.green;
        case 4:
          return Colors.lightGreen;
        case 3:
          return Colors.yellow;
        case 2:
          return Colors.orange;
        case 1:
          return Colors.red;
        default:
          return Colors.white;
      }
    }

    final countdownColor = getCountdownColor(gameState.countdown);
    final progress = gameState.countdown / 5.0;

    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            countdownColor.withOpacity(0.3),
            Colors.black,
          ],
          stops: const [0.0, 0.7],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 円形プログレスバー付きカウントダウン
            Stack(
              alignment: Alignment.center,
              children: [
                // 外側のプログレスバー
                SizedBox(
                  width: 280,
                  height: 280,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(countdownColor),
                  ),
                ),

                // アニメーション付き数字
                AnimatedBuilder(
                  animation: _countdownScaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _countdownScaleAnimation.value,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: countdownColor.withOpacity(0.3),
                          boxShadow: [
                            BoxShadow(
                              color: countdownColor.withOpacity(0.5),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${gameState.countdown}',
                            style: TextStyle(
                              color: countdownColor,
                              fontSize: 140,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: countdownColor.withOpacity(0.5),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 60),

            // 説明テキスト
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: countdownColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    '撮影まで',
                    style: TextStyle(
                      color: countdownColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'カメラに向かって面白い顔を作ろう！',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // プログレスドット
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final isActive = index < (5 - gameState.countdown);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isActive
                        ? countdownColor
                        : Colors.white.withOpacity(0.2),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: countdownColor.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// 準備中の表示（画像アップロード待ち）
  Widget _buildPreparingView(GameState gameState) {
    final roundData = gameState.currentRoundData;
    final currentUserId = ref.watch(authStateChangesProvider).value?.uid ?? '';
    final isPlayer1 = gameState.isPlayer1(currentUserId);

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

          // 両プレイヤーの準備状況
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPlayerReadyIndicator(
                'あなた',
                isPlayer1
                    ? roundData?.player1ImageReady ?? false
                    : roundData?.player2ImageReady ?? false,
              ),
              const SizedBox(width: 32),
              _buildPlayerReadyIndicator(
                '相手',
                isPlayer1
                    ? roundData?.player2ImageReady ?? false
                    : roundData?.player1ImageReady ?? false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// プレイヤーの準備完了インジケーター
  Widget _buildPlayerReadyIndicator(String label, bool isReady) {
    return Column(
      children: [
        Icon(
          isReady ? Icons.check_circle : Icons.hourglass_empty,
          color: isReady ? Colors.green : Colors.orange,
          size: 48,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Text(
          isReady ? '準備完了' : '準備中...',
          style: TextStyle(
            color: isReady ? Colors.green : Colors.orange,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  /// 画像表示前の3秒カウントダウン
  Widget _buildDisplayCountdownView(GameState gameState) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${gameState.displayCountdown}',
            style: const TextStyle(
              color: Colors.yellow,
              fontSize: 120,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'まもなくにらめっこ開始！',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '笑わないように準備して！',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
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
          color: gameState.isPlayerSmiling ? Colors.red[900] : Colors.green[900],
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

  /// 終了確認ダイアログ
  void _showQuitDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ゲームを終了しますか？'),
        content: const Text('ゲームを中断すると負けとなります。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref
                  .read(gameStateProvider(widget.matchId).notifier)
                  .quitGame();
              context.pop();
            },
            child: const Text('終了', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
