import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/feature/auth/model/user_model.dart';
import 'package:hackathon_app/feature/auth/service/auth_provider.dart';
import 'package:hackathon_app/feature/auth/service/user_repository.dart';
import 'package:hackathon_app/feature/game/model/match_model.dart';
import 'package:hackathon_app/feature/game/service/match_repository.dart';
import 'package:hackathon_app/feature/home/home_page.dart';

class ResultPage extends ConsumerStatefulWidget {
  const ResultPage({this.matchId, super.key});

  final String? matchId;
  static const routeName = '/result';

  @override
  ConsumerState<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends ConsumerState<ResultPage> {
  @override
  Widget build(BuildContext context) {
    final matchId = widget.matchId;

    if (matchId == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              const Text(
                'マッチIDが見つかりません',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(HomePage.routeName),
                child: const Text('ホームに戻る'),
              ),
            ],
          ),
        ),
      );
    }

    final matchRepository = ref.watch(matchRepositoryProvider);
    final currentUserId = ref.watch(authStateChangesProvider).value?.uid ?? '';

    return FutureBuilder<MatchModel?>(
      future: matchRepository.getMatch(matchId),
      builder: (context, matchSnapshot) {
        if (matchSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        if (matchSnapshot.hasError || matchSnapshot.data == null) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'マッチデータの取得に失敗しました',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.go(HomePage.routeName),
                    child: const Text('ホームに戻る'),
                  ),
                ],
              ),
            ),
          );
        }

        final match = matchSnapshot.data!;
        final isPlayer1 = match.player1 == currentUserId;
        final opponentId = isPlayer1 ? match.player2 : match.player1;

        return FutureBuilder<List<UserModel?>>(
          future: Future.wait([
            ref.read(userRepositoryProvider).getUser(currentUserId),
            ref.read(userRepositoryProvider).getUser(opponentId),
          ]),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }

            final currentUser = userSnapshot.data?[0];
            final opponentUser = userSnapshot.data?[1];

            return _buildResultScreen(
              context,
              match,
              isPlayer1,
              currentUserId,
              currentUser?.nickname ?? 'あなた',
              opponentUser?.nickname ?? '相手',
            );
          },
        );
      },
    );
  }

  Widget _buildResultScreen(
    BuildContext context,
    MatchModel match,
    bool isPlayer1,
    String currentUserId,
    String playerNickname,
    String opponentNickname,
  ) {
    // 勝敗判定
    final winner = match.winner;
    final bool isWinner = _determineWinner(winner, isPlayer1);
    final bool isDraw = winner == 'draw' || winner == null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 32),

                // 結果表示
                _buildResultHeader(isWinner, isDraw),
                const SizedBox(height: 48),

                // 統計情報
                _buildMatchStats(match, isPlayer1),
                const SizedBox(height: 48),

                // ホームに戻るボタン
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => context.go(HomePage.routeName),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'ホームに戻る',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 勝敗判定
  bool _determineWinner(String? winner, bool isPlayer1) {
    if (winner == null) return false;
    if (winner == 'draw') return false;
    if (winner == 'player1' && isPlayer1) return true;
    if (winner == 'player2' && !isPlayer1) return true;
    return false;
  }

  /// 対戦統計情報
  Widget _buildMatchStats(MatchModel match, bool isPlayer1) {
    final playerUploadTime = isPlayer1 ? match.player1UploadTime : match.player2UploadTime;
    final opponentUploadTime = isPlayer1 ? match.player2UploadTime : match.player1UploadTime;
    final playerReactionTime = isPlayer1 ? match.player1ReactionTime : match.player2ReactionTime;
    final opponentReactionTime = isPlayer1 ? match.player2ReactionTime : match.player1ReactionTime;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[800]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '対戦統計',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildStatRow('アップロード時間', playerUploadTime, opponentUploadTime),
          const SizedBox(height: 12),
          _buildStatRow('反応時間', playerReactionTime, opponentReactionTime),
        ],
      ),
    );
  }

  /// 統計行
  Widget _buildStatRow(String label, double? playerValue, double? opponentValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        Row(
          children: [
            Text(
              playerValue != null ? '${playerValue.toStringAsFixed(2)}秒' : '-',
              style: const TextStyle(color: Colors.blue, fontSize: 14),
            ),
            const SizedBox(width: 8),
            const Text('vs', style: TextStyle(color: Colors.white70, fontSize: 12)),
            const SizedBox(width: 8),
            Text(
              opponentValue != null ? '${opponentValue.toStringAsFixed(2)}秒' : '-',
              style: const TextStyle(color: Colors.orange, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  /// 結果ヘッダー
  Widget _buildResultHeader(bool isWinner, bool isDraw) {
    if (isDraw) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[800],
            ),
            child: const Icon(
              Icons.handshake,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '引き分け',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'どちらも笑わなかった！',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isWinner ? Colors.yellow[700] : Colors.grey[800],
          ),
          child: Icon(
            isWinner ? Icons.emoji_events : Icons.sentiment_dissatisfied,
            size: 80,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          isWinner ? '勝利！' : '敗北',
          style: TextStyle(
            color: isWinner ? Colors.yellow : Colors.red,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isWinner ? 'おめでとうございます！' : '次は頑張りましょう！',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

}
