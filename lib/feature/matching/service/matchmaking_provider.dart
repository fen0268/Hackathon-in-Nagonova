import 'package:hackathon_app/feature/auth/service/auth_provider.dart';
import 'package:hackathon_app/feature/game/service/match_repository.dart';
import 'package:hackathon_app/feature/matching/service/matchmaking_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'matchmaking_provider.g.dart';

/// マッチング状態
enum MatchmakingStatus {
  /// 待機前
  idle,

  /// キューに参加中
  joiningQueue,

  /// 対戦相手を待機中
  waiting,

  /// マッチング成立
  matched,

  /// エラー発生
  error,
}

/// マッチング状態データ
class MatchmakingState {
  const MatchmakingState({
    required this.status,
    this.matchId,
    this.opponentId,
    this.errorMessage,
  });

  final MatchmakingStatus status;
  final String? matchId;
  final String? opponentId;
  final String? errorMessage;

  MatchmakingState copyWith({
    MatchmakingStatus? status,
    String? matchId,
    String? opponentId,
    String? errorMessage,
  }) {
    return MatchmakingState(
      status: status ?? this.status,
      matchId: matchId ?? this.matchId,
      opponentId: opponentId ?? this.opponentId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// マッチメイキングプロバイダー
@riverpod
class MatchmakingController extends _$MatchmakingController {
  @override
  MatchmakingState build() {
    return const MatchmakingState(status: MatchmakingStatus.idle);
  }

  /// マッチング開始
  Future<void> startMatching() async {
    final authService = ref.read(authServiceProvider);
    final userId = authService.currentUser?.uid;

    if (userId == null) {
      state = state.copyWith(
        status: MatchmakingStatus.error,
        errorMessage: 'ユーザーが認証されていません',
      );
      return;
    }

    try {
      // 状態を「キューに参加中」に更新
      state = state.copyWith(status: MatchmakingStatus.joiningQueue);

      final matchmakingRepo = ref.read(matchmakingRepositoryProvider);

      // キューに参加
      await matchmakingRepo.joinQueue(userId);

      // 待機中の対戦相手を検索
      final opponent = await matchmakingRepo.findWaitingOpponent(userId);

      if (opponent != null) {
        // 対戦相手が見つかった → マッチング成立
        await _createMatch(userId, opponent.userId);
      } else {
        // 対戦相手が見つからない → 待機状態
        state = state.copyWith(status: MatchmakingStatus.waiting);

        // マッチング状態を監視して自動マッチング
        _watchForMatch(userId);
      }
    } on Exception catch (e) {
      state = state.copyWith(
        status: MatchmakingStatus.error,
        errorMessage: 'マッチング開始エラー: $e',
      );
    }
  }

  /// マッチング監視（相手が参加するのを待つ）
  void _watchForMatch(String userId) {
    final matchmakingRepo = ref.read(matchmakingRepositoryProvider);

    // マッチング情報をストリームで監視
    final subscription = matchmakingRepo
        .watchMatchmaking(userId)
        .listen(
          (matchmaking) {
            if (matchmaking == null) {
              return;
            }

            // マッチング成立を検知
            if (matchmaking.status == 'matched' &&
                matchmaking.matchId != null &&
                matchmaking.matchedWith != null) {
              state = state.copyWith(
                status: MatchmakingStatus.matched,
                matchId: matchmaking.matchId,
                opponentId: matchmaking.matchedWith,
              );
            }
          },
          onError: (Object error) {
            state = state.copyWith(
              status: MatchmakingStatus.error,
              errorMessage: 'マッチング監視エラー: $error',
            );
          },
        );

    // プロバイダーが破棄されたらサブスクリプションもキャンセル
    ref.onDispose(subscription.cancel);
  }

  /// マッチを作成
  Future<void> _createMatch(String userId, String opponentId) async {
    try {
      final matchRepo = ref.read(matchRepositoryProvider);
      final matchmakingRepo = ref.read(matchmakingRepositoryProvider);

      // マッチを作成
      final matchId = await matchRepo.createMatch(
        player1: userId,
        player2: opponentId,
      );

      // 両方のユーザーのマッチメイキング状態を更新
      await Future.wait([
        matchmakingRepo.updateMatchmakingStatus(
          userId: userId,
          status: 'matched',
          matchedWith: opponentId,
          matchId: matchId,
        ),
        matchmakingRepo.updateMatchmakingStatus(
          userId: opponentId,
          status: 'matched',
          matchedWith: userId,
          matchId: matchId,
        ),
      ]);

      // 状態を「マッチング成立」に更新
      state = state.copyWith(
        status: MatchmakingStatus.matched,
        matchId: matchId,
        opponentId: opponentId,
      );
    } on Exception catch (e) {
      state = state.copyWith(
        status: MatchmakingStatus.error,
        errorMessage: 'マッチ作成エラー: $e',
      );
    }
  }

  /// マッチングをキャンセル
  Future<void> cancelMatching() async {
    final authService = ref.read(authServiceProvider);
    final userId = authService.currentUser?.uid;

    if (userId == null) {
      return;
    }

    try {
      final matchmakingRepo = ref.read(matchmakingRepositoryProvider);
      await matchmakingRepo.leaveQueue(userId);

      state = const MatchmakingState(status: MatchmakingStatus.idle);
    } on Exception catch (e) {
      state = state.copyWith(
        status: MatchmakingStatus.error,
        errorMessage: 'キャンセルエラー: $e',
      );
    }
  }

  /// エラーをクリア
  void clearError() {
    state = const MatchmakingState(status: MatchmakingStatus.idle);
  }
}
