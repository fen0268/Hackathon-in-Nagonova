import 'dart:async';
import 'dart:io';

import 'package:hackathon_app/feature/auth/service/auth_provider.dart';
import 'package:hackathon_app/feature/game/model/match_model.dart';
import 'package:hackathon_app/feature/game/model/round_model.dart';
import 'package:hackathon_app/feature/game/service/match_repository.dart';
import 'package:hackathon_app/feature/game/service/native_camera_service.dart';
import 'package:hackathon_app/feature/game/service/storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_state_provider.g.dart';

/// ゲームフェーズ（要件定義のステータスに対応）
enum GamePhase {
  waiting, // 待機
  round1Countdown, // ラウンド1カウントダウン
  round1Preparing, // ラウンド1準備中（アップロード待ち）
  round1CountdownToDisplay, // ラウンド1画像表示前の3秒カウント
  round1Playing, // ラウンド1対戦中
  round2Countdown, // ラウンド2カウントダウン
  round2Preparing, // ラウンド2準備中
  round2CountdownToDisplay, // ラウンド2画像表示前の3秒カウント
  round2Playing, // ラウンド2対戦中
  finished, // 終了
}

/// ゲーム状態
class GameState {
  const GameState({
    required this.matchId,
    required this.match,
    required this.phase,
    this.countdown = 5,
    this.displayCountdown = 3,
    this.playingTimeRemaining = 10,
    this.isPlayerSmiling = false,
    this.opponentImageUrl,
    this.preparingTimeoutRemaining = 10,
    this.error,
  });

  final String matchId;
  final MatchModel match;
  final GamePhase phase;
  final int countdown; // 撮影前のカウントダウン（5秒）
  final int displayCountdown; // 画像表示前のカウントダウン（3秒）
  final int playingTimeRemaining; // 対戦中の残り時間（10秒）
  final bool isPlayerSmiling; // プレイヤーが笑顔かどうか
  final String? opponentImageUrl; // 相手の画像URL
  final int preparingTimeoutRemaining; // 準備完了待機の残り時間（10秒）
  final String? error;

  GameState copyWith({
    String? matchId,
    MatchModel? match,
    GamePhase? phase,
    int? countdown,
    int? displayCountdown,
    int? playingTimeRemaining,
    bool? isPlayerSmiling,
    String? opponentImageUrl,
    int? preparingTimeoutRemaining,
    String? error,
  }) {
    return GameState(
      matchId: matchId ?? this.matchId,
      match: match ?? this.match,
      phase: phase ?? this.phase,
      countdown: countdown ?? this.countdown,
      displayCountdown: displayCountdown ?? this.displayCountdown,
      playingTimeRemaining: playingTimeRemaining ?? this.playingTimeRemaining,
      isPlayerSmiling: isPlayerSmiling ?? this.isPlayerSmiling,
      opponentImageUrl: opponentImageUrl ?? this.opponentImageUrl,
      preparingTimeoutRemaining:
          preparingTimeoutRemaining ?? this.preparingTimeoutRemaining,
      error: error ?? this.error,
    );
  }

  /// 現在のラウンド番号を取得
  int get currentRound => match.currentRound;

  /// 自分がplayer1かどうか
  bool isPlayer1(String userId) => match.player1 == userId;

  /// 現在のラウンドデータを取得
  RoundModel? get currentRoundData {
    if (currentRound == 1) {
      return match.round1;
    } else if (currentRound == 2) {
      return match.round2;
    }
    return null;
  }
}

/// ゲーム状態管理プロバイダー
@riverpod
class GameStateNotifier extends _$GameStateNotifier {
  MatchRepository? _matchRepository;
  StorageService? _storageService;
  NativeCameraService? _cameraService;
  String? _currentUserId;
  bool _initialized = false;

  StreamSubscription<MatchModel?>? _matchSubscription;
  Timer? _countdownTimer;
  Timer? _displayCountdownTimer;
  Timer? _playingTimer;
  Timer? _preparingTimeoutTimer;
  StreamSubscription<SmileDetectionResult>? _smileSubscription;

  // Getterで非nullアクセスを保証
  MatchRepository get matchRepository => _matchRepository!;
  StorageService get storageService => _storageService!;
  NativeCameraService get cameraService => _cameraService!;
  String get currentUserId => _currentUserId!;

  @override
  GameState build(String matchId) {
    // 初回のみ初期化
    if (!_initialized) {
      _initialized = true;
      _matchRepository = ref.watch(matchRepositoryProvider);
      _storageService = ref.watch(storageServiceProvider);
      _cameraService = NativeCameraService();
      _currentUserId = ref.watch(authStateChangesProvider).value?.uid ?? '';

      // クリーンアップ
      ref.onDispose(() {
        _matchSubscription?.cancel();
        _countdownTimer?.cancel();
        _displayCountdownTimer?.cancel();
        _playingTimer?.cancel();
        _preparingTimeoutTimer?.cancel();
        _smileSubscription?.cancel();
        _cameraService?.dispose();
      });

      // マッチデータを監視
      _watchMatch(matchId);
    }

    // 初期状態を返す（ダミーマッチデータ）
    // ストリームから実際のデータが来たら更新される
    return GameState(
      matchId: matchId,
      match: MatchModel(
        matchId: matchId,
        player1: '',
        player2: '',
        startedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
      phase: GamePhase.waiting,
    );
  }

  /// マッチデータをFirestoreから監視
  void _watchMatch(String matchId) {
    _matchSubscription = matchRepository
        .watchMatch(matchId)
        .listen(
          (match) {
            if (match == null) {
              state = state.copyWith(
                error: 'マッチが見つかりません',
              );
              return;
            }

            // マッチデータ更新
            state = state.copyWith(match: match);

            // ステータスに応じた処理
            _handleMatchStatusChange(match);
          },
          onError: (error) {
            state = state.copyWith(error: 'マッチの監視エラー: $error');
          },
        );
  }

  /// マッチステータス変更に応じた処理
  void _handleMatchStatusChange(MatchModel match) {
    final status = match.status;
    final currentState = state;

    // 準備完了待機フェーズの監視
    if (currentState.phase == GamePhase.round1Preparing ||
        currentState.phase == GamePhase.round2Preparing) {
      _checkBothPlayersReady(match);
    }
  }

  /// 両プレイヤーの準備完了チェック
  void _checkBothPlayersReady(MatchModel match) {
    final currentState = state;

    final roundData = currentState.currentRoundData;
    if (roundData == null) return;

    // 両者の画像がアップロード完了している場合
    if (roundData.player1ImageReady && roundData.player2ImageReady) {
      // 準備完了タイマーをキャンセル
      _preparingTimeoutTimer?.cancel();

      // 3秒カウントダウンフェーズへ移行
      if (currentState.currentRound == 1) {
        _startDisplayCountdown(GamePhase.round1CountdownToDisplay);
      } else {
        _startDisplayCountdown(GamePhase.round2CountdownToDisplay);
      }
    }
  }

  /// ゲーム開始（ラウンド1のカウントダウン開始）
  Future<void> startGame() async {
    final currentState = state;

    // ラウンド1のカウントダウンフェーズへ
    state = currentState.copyWith(
      phase: GamePhase.round1Countdown,
      countdown: 5,
    );

    // Firestoreのステータス更新
    await matchRepository.updateMatchStatus(
      currentState.matchId,
      'round1_countdown',
    );

    // カウントダウン開始
    await _startShootingCountdown(1);
  }

  /// 撮影前のカウントダウン開始（5→4→3→2→1→0）
  Future<void> _startShootingCountdown(int roundNumber) async {
    final currentState = state;

    // カメラ起動
    try {
      await cameraService.startCameraWithCountdown();
    } catch (e) {
      state = currentState.copyWith(error: 'カメラの起動に失敗: $e');
      return;
    }

    // カウントダウンタイマー
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = state;

      if (current.countdown <= 0) {
        timer.cancel();
        _onShootingCountdownComplete(roundNumber);
        return;
      }

      state = current.copyWith(countdown: current.countdown - 1);
    });
  }

  /// 撮影カウントダウン完了（撮影→アップロード）
  Future<void> _onShootingCountdownComplete(int roundNumber) async {
    final currentState = state;

    // 撮影時刻を記録
    final shootingAt = DateTime.now();
    await matchRepository.updateRound(
      matchId: currentState.matchId,
      roundNumber: roundNumber,
      roundData: {'shootingAt': shootingAt},
    );

    // 準備中フェーズへ
    final preparingPhase = roundNumber == 1
        ? GamePhase.round1Preparing
        : GamePhase.round2Preparing;
    state = currentState.copyWith(
      phase: preparingPhase,
      preparingTimeoutRemaining: 10,
    );

    await matchRepository.updateMatchStatus(
      currentState.matchId,
      'round${roundNumber}_preparing',
    );

    // 撮影した画像を取得してアップロード
    await _uploadCapturedImage(roundNumber);

    // 準備完了タイムアウトタイマー開始（10秒）
    _startPreparingTimeoutTimer(roundNumber);
  }

  /// 撮影画像をアップロード
  Future<void> _uploadCapturedImage(int roundNumber) async {
    final currentState = state;

    try {
      // ネイティブから撮影画像のパスを取得
      final imagePath = await cameraService.getCapturedImagePath();
      if (imagePath == null) {
        throw Exception('撮影画像が取得できませんでした');
      }

      final imageFile = File(imagePath);
      final playerNumber = currentState.isPlayer1(currentUserId) ? 1 : 2;

      // Firebase Storageにアップロード
      final uploadStartTime = DateTime.now();
      final imageUrl = await storageService.uploadMatchImage(
        matchId: currentState.matchId,
        roundNumber: roundNumber,
        playerNumber: playerNumber,
        imageFile: imageFile,
      );

      final uploadTime =
          DateTime.now().difference(uploadStartTime).inMilliseconds / 1000.0;

      // Firestoreに画像URLと準備完了フラグを更新
      await matchRepository.updateImageUpload(
        matchId: currentState.matchId,
        roundNumber: roundNumber,
        playerId: currentUserId,
        imageUrl: imageUrl,
      );

      // アップロード時間を記録
      final isPlayer1 = currentState.isPlayer1(currentUserId);
      await matchRepository.updateRound(
        matchId: currentState.matchId,
        roundNumber: roundNumber,
        roundData: {
          '${isPlayer1 ? 'player1' : 'player2'}UploadTime': uploadTime,
        },
      );
    } catch (e) {
      state = currentState.copyWith(
        error: '画像のアップロードに失敗: $e',
      );

      // タイムアウト負け処理
      await _handlePreparingTimeout(roundNumber, timeoutDraw: false);
    }
  }

  /// 準備完了タイムアウトタイマー開始
  void _startPreparingTimeoutTimer(int roundNumber) {
    _preparingTimeoutTimer?.cancel();
    _preparingTimeoutTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final current = state;

        if (current.preparingTimeoutRemaining <= 0) {
          timer.cancel();
          _handlePreparingTimeout(roundNumber, timeoutDraw: false);
          return;
        }

        state = current.copyWith(
          preparingTimeoutRemaining: current.preparingTimeoutRemaining - 1,
        );
      },
    );
  }

  /// 準備完了タイムアウト処理
  Future<void> _handlePreparingTimeout(
    int roundNumber, {
    required bool timeoutDraw,
  }) async {
    final currentState = state;

    _preparingTimeoutTimer?.cancel();

    final roundData = currentState.currentRoundData;
    if (roundData == null) return;

    String winner;
    if (timeoutDraw) {
      // 両者タイムアウト → 引き分け
      winner = 'timeout_draw';
    } else {
      // 片方のみタイムアウト → その人の負け
      final isPlayer1 = currentState.isPlayer1(currentUserId);
      if (roundData.player1ImageReady && !roundData.player2ImageReady) {
        winner = 'timeout_player2';
      } else if (!roundData.player1ImageReady && roundData.player2ImageReady) {
        winner = 'timeout_player1';
      } else {
        winner = 'timeout_draw';
      }
    }

    // ラウンド勝者を設定
    await matchRepository.updateRound(
      matchId: currentState.matchId,
      roundNumber: roundNumber,
      roundData: {
        'winner': winner,
        'roundEndedAt': DateTime.now(),
      },
    );

    // 結果画面へ
    await _finishGame(winner);
  }

  /// 画像表示前の3秒カウントダウン開始
  Future<void> _startDisplayCountdown(GamePhase phase) async {
    final currentState = state;

    state = currentState.copyWith(
      phase: phase,
      displayCountdown: 3,
    );

    final roundNumber = currentState.currentRound;
    await matchRepository.updateMatchStatus(
      currentState.matchId,
      'round${roundNumber}_countdown_to_display',
    );

    // 相手の画像URLを取得
    final roundData = currentState.currentRoundData;
    if (roundData != null) {
      final isPlayer1 = currentState.isPlayer1(currentUserId);
      final opponentImageUrl = isPlayer1
          ? roundData.player2ImageUrl
          : roundData.player1ImageUrl;
      state = currentState.copyWith(opponentImageUrl: opponentImageUrl);
    }

    // 3秒カウントダウン
    _displayCountdownTimer?.cancel();
    _displayCountdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final current = state;

        if (current.displayCountdown <= 0) {
          timer.cancel();
          _startPlaying(roundNumber);
          return;
        }

        state = current.copyWith(
          displayCountdown: current.displayCountdown - 1,
        );
      },
    );
  }

  /// にらめっこ対戦開始
  Future<void> _startPlaying(int roundNumber) async {
    final currentState = state;

    // 対戦中フェーズへ
    final playingPhase = roundNumber == 1
        ? GamePhase.round1Playing
        : GamePhase.round2Playing;
    state = currentState.copyWith(
      phase: playingPhase,
      playingTimeRemaining: 10,
    );

    await matchRepository.updateMatchStatus(
      currentState.matchId,
      'round${roundNumber}_playing',
    );

    // 画像表示時刻を記録
    await matchRepository.updateRound(
      matchId: currentState.matchId,
      roundNumber: roundNumber,
      roundData: {'imagesDisplayedAt': DateTime.now()},
    );

    // 笑顔判定開始
    await cameraService.startSmileDetection();

    // 笑顔判定結果を監視
    _smileSubscription?.cancel();
    _smileSubscription = cameraService.smileDetectionStream.listen(
      (result) {
        final current = state;

        state = current.copyWith(isPlayerSmiling: result.isSmiling);

        // 笑顔を検知したら負け
        if (result.isSmiling) {
          _onPlayerSmiled(roundNumber);
        }
      },
    );

    // 対戦タイマー（10秒）
    _playingTimer?.cancel();
    _playingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = state;

      if (current.playingTimeRemaining <= 0) {
        timer.cancel();
        _onPlayingTimeout(roundNumber);
        return;
      }

      state = current.copyWith(
        playingTimeRemaining: current.playingTimeRemaining - 1,
      );
    });
  }

  /// プレイヤーが笑った時の処理
  Future<void> _onPlayerSmiled(int roundNumber) async {
    final currentState = state;

    _playingTimer?.cancel();
    _smileSubscription?.cancel();
    await cameraService.stopSmileDetection();

    // 笑顔検知時刻を記録
    await matchRepository.updateSmileDetected(
      matchId: currentState.matchId,
      roundNumber: roundNumber,
      playerId: currentUserId,
    );

    // 反応時間を計算
    final roundData = currentState.currentRoundData;
    if (roundData?.imagesDisplayedAt != null) {
      final reactionTime =
          DateTime.now()
              .difference(roundData!.imagesDisplayedAt!)
              .inMilliseconds /
          1000.0;

      final isPlayer1 = currentState.isPlayer1(currentUserId);
      await matchRepository.updateRound(
        matchId: currentState.matchId,
        roundNumber: roundNumber,
        roundData: {
          '${isPlayer1 ? 'player1' : 'player2'}ReactionTime': reactionTime,
        },
      );
    }

    // 勝者を決定（笑った方の負け）
    final isPlayer1 = currentState.isPlayer1(currentUserId);
    final winner = isPlayer1 ? 'player2' : 'player1';

    await matchRepository.updateRound(
      matchId: currentState.matchId,
      roundNumber: roundNumber,
      roundData: {
        'winner': winner,
        'roundEndedAt': DateTime.now(),
      },
    );

    // ラウンド1で決着 → 終了
    if (roundNumber == 1) {
      await _finishGame(winner);
    } else {
      // ラウンド2で決着 → 終了
      await _finishGame(winner);
    }
  }

  /// 対戦タイムアウト（10秒経過）
  Future<void> _onPlayingTimeout(int roundNumber) async {
    final currentState = state;

    _smileSubscription?.cancel();
    await cameraService.stopSmileDetection();

    // ラウンド1でタイムアウト → ラウンド2へ
    if (roundNumber == 1) {
      await matchRepository.updateRound(
        matchId: currentState.matchId,
        roundNumber: 1,
        roundData: {
          'winner': 'none',
          'roundEndedAt': DateTime.now(),
        },
      );

      await matchRepository.proceedToNextRound(currentState.matchId);

      // ラウンド2開始
      state = currentState.copyWith(
        phase: GamePhase.round2Countdown,
        countdown: 5,
      );

      await _startShootingCountdown(2);
    } else {
      // ラウンド2でタイムアウト → 引き分け
      await matchRepository.updateRound(
        matchId: currentState.matchId,
        roundNumber: 2,
        roundData: {
          'winner': 'none',
          'roundEndedAt': DateTime.now(),
        },
      );

      await _finishGame('draw');
    }
  }

  /// ゲーム終了
  Future<void> _finishGame(String finalWinner) async {
    final currentState = state;

    state = currentState.copyWith(phase: GamePhase.finished);

    await matchRepository.finishMatch(
      matchId: currentState.matchId,
      winnerId: finalWinner,
    );

    // タイマー全停止
    _countdownTimer?.cancel();
    _displayCountdownTimer?.cancel();
    _playingTimer?.cancel();
    _preparingTimeoutTimer?.cancel();
    _smileSubscription?.cancel();

    await cameraService.stopCamera();
  }

  /// 手動でゲームを終了
  Future<void> quitGame() async {
    await _finishGame('draw');
  }
}
