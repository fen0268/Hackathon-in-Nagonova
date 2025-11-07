import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../game/game_page.dart';
import 'service/matchmaking_provider.dart';

class MatchingPage extends ConsumerStatefulWidget {
  const MatchingPage({super.key});

  static const routeName = '/matching';

  @override
  ConsumerState<MatchingPage> createState() => MatchingPageState();
}

class MatchingPageState extends ConsumerState<MatchingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラー初期化
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // マッチング開始
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(matchmakingControllerProvider.notifier).startMatching();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchingState = ref.watch(matchmakingControllerProvider);

    // マッチング成立時の画面遷移
    ref.listen<MatchmakingState>(
      matchmakingControllerProvider,
      (previous, next) {
        if (next.status == MatchmakingStatus.matched && next.matchId != null) {
          // 対戦画面に遷移
          context.go(GamePage.routeName);
        }

        if (next.status == MatchmakingStatus.error) {
          // エラー表示
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.errorMessage ?? 'エラーが発生しました'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('マッチング中'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(matchmakingControllerProvider.notifier).cancelMatching();
            context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ローディングアニメーション
              Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2 * 3.14159,
                      child: Icon(
                        Icons.person_search,
                        size: 120,
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 48),

              // 状態メッセージ
              Center(
                child: Text(
                  _getStatusMessage(matchingState.status),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              // 補助メッセージ
              Center(
                child: Text(
                  _getSubMessage(matchingState.status),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 48),

              // キャンセルボタン
              if (matchingState.status != MatchmakingStatus.matched)
                OutlinedButton(
                  onPressed: () {
                    ref
                        .read(matchmakingControllerProvider.notifier)
                        .cancelMatching();
                    context.pop();
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('キャンセル'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusMessage(MatchmakingStatus status) {
    switch (status) {
      case MatchmakingStatus.idle:
        return '準備中...';
      case MatchmakingStatus.joiningQueue:
        return 'キューに参加中...';
      case MatchmakingStatus.waiting:
        return '対戦相手を探しています...';
      case MatchmakingStatus.matched:
        return 'マッチング成立！';
      case MatchmakingStatus.error:
        return 'エラーが発生しました';
    }
  }

  String _getSubMessage(MatchmakingStatus status) {
    switch (status) {
      case MatchmakingStatus.idle:
        return 'しばらくお待ちください';
      case MatchmakingStatus.joiningQueue:
        return 'マッチングシステムに接続中';
      case MatchmakingStatus.waiting:
        return '他のプレイヤーの参加を待っています';
      case MatchmakingStatus.matched:
        return '対戦画面に移動します';
      case MatchmakingStatus.error:
        return 'もう一度お試しください';
    }
  }
}
