import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon_app/feature/auth/service/auth_provider.dart';
import 'package:hackathon_app/feature/auth/service/user_repository.dart';
import 'package:hackathon_app/feature/game/model/match_model.dart';
import 'package:hackathon_app/feature/game/service/match_repository.dart';
import 'package:hackathon_app/feature/game/service/native_camera_service.dart';
import 'package:hackathon_app/feature/game/service/storage_service.dart';
import 'package:hackathon_app/feature/ranking/service/ranking_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_state_provider.g.dart';

/// ゲームフェーズ（要件定義のステータスに対応）
enum GamePhase {
  waiting, // 待機
  countdown, // カウントダウン
  preparing, // 準備中（アップロード待ち、5秒自動待機）
  playing, // 対戦中
  waitingForResult, // 結果待機中（両者の準備完了を待つ）
  finished, // 終了
}

/// ゲーム状態
class GameState {
  const GameState({
    required this.matchId,
    required this.match,
    required this.phase,
    this.countdown = 5,
    this.playingTimeRemaining = 20,
    this.isPlayerSmiling = false,
    this.opponentImageUrl,
    this.preparingTimeRemaining = 5,
    this.resultWaitingTimeRemaining = 10,
    this.error,
    this.isUploading = false,
  });

  final String matchId;
  final MatchModel match;
  final GamePhase phase;
  final int countdown; // 撮影前のカウントダウン（5秒）
  final int playingTimeRemaining; // 対戦中の残り時間（20秒）
  final bool isPlayerSmiling; // プレイヤーが笑顔かどうか
  final String? opponentImageUrl; // 相手の画像URL
  final int preparingTimeRemaining; // 準備中の残り時間（5秒自動待機）
  final int resultWaitingTimeRemaining; // 結果待機の残り時間（10秒）
  final String? error;
  final bool isUploading; // 画像アップロード中かどうか

  GameState copyWith({
    String? matchId,
    MatchModel? match,
    GamePhase? phase,
    int? countdown,
    int? playingTimeRemaining,
    bool? isPlayerSmiling,
    String? opponentImageUrl,
    int? preparingTimeRemaining,
    int? resultWaitingTimeRemaining,
    String? error,
    bool? isUploading,
  }) {
    return GameState(
      matchId: matchId ?? this.matchId,
      match: match ?? this.match,
      phase: phase ?? this.phase,
      countdown: countdown ?? this.countdown,
      playingTimeRemaining: playingTimeRemaining ?? this.playingTimeRemaining,
      isPlayerSmiling: isPlayerSmiling ?? this.isPlayerSmiling,
      opponentImageUrl: opponentImageUrl ?? this.opponentImageUrl,
      preparingTimeRemaining:
          preparingTimeRemaining ?? this.preparingTimeRemaining,
      resultWaitingTimeRemaining:
          resultWaitingTimeRemaining ?? this.resultWaitingTimeRemaining,
      error: error ?? this.error,
      isUploading: isUploading ?? this.isUploading,
    );
  }

  /// 自分がplayer1かどうか
  bool isPlayer1(String userId) => match.player1 == userId;
}

/// ゲーム状態管理プロバイダー
@riverpod
class GameStateNotifier extends _$GameStateNotifier {
  MatchRepository? _matchRepository;
  StorageService? _storageService;
  NativeCameraService? _cameraService;
  UserRepository? _userRepository;
  RankingRepository? _rankingRepository;
  String? _currentUserId;
  bool _initialized = false;

  StreamSubscription<MatchModel?>? _matchSubscription;
  Timer? _countdownTimer;
  Timer? _displayCountdownTimer;
  Timer? _playingTimer;
  Timer? _preparingTimeoutTimer;
  Timer? _resultWaitingTimer;
  StreamSubscription<SmileDetectionResult>? _smileSubscription;

  // Getterで非nullアクセスを保証
  MatchRepository get matchRepository => _matchRepository!;
  StorageService get storageService => _storageService!;
  NativeCameraService get cameraService => _cameraService!;
  UserRepository get userRepository => _userRepository!;
  RankingRepository get rankingRepository => _rankingRepository!;
  String get currentUserId => _currentUserId!;

  @override
  GameState build(String matchId) {
    // 初回のみ初期化
    if (!_initialized) {
      _initialized = true;
      _matchRepository = ref.watch(matchRepositoryProvider);
      _storageService = ref.watch(storageServiceProvider);
      _cameraService = NativeCameraService();
      _userRepository = ref.watch(userRepositoryProvider);
      _rankingRepository = ref.watch(rankingRepositoryProvider);
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
    // 準備中フェーズでは何もしない（5秒後に自動的に画像表示へ）
  }

  /// ゲーム開始（カウントダウン開始）
  Future<void> startGame() async {
    final currentState = state;

    // カウントダウンフェーズへ
    state = currentState.copyWith(
      phase: GamePhase.countdown,
      countdown: 5,
    );

    // Firestoreのステータス更新
    await matchRepository.updateMatchStatus(
      currentState.matchId,
      'countdown',
    );

    // カウントダウン開始
    await _startShootingCountdown();
  }

  /// 撮影前のカウントダウン開始（5→4→3→2→1→0）
  /// ネイティブ側でカウントダウンと撮影を実行し、撮影完了まで待機
  Future<void> _startShootingCountdown() async {
    final currentState = state;

    try {
      print('[GameState] カメラ起動開始');

      // ネイティブカメラを起動（カウントダウンは5秒に設定）
      // ネイティブ側でカウントダウンUIを表示し、自動で撮影まで行う
      // awaitで撮影完了まで待機（ネイティブ側から通知が来るまでブロック）
      await cameraService.startCameraWithCountdown();

      print('[GameState] 撮影完了通知を受信');

      // 撮影完了後に次のフェーズへ
      await _onShootingCountdownComplete();
    } on Exception catch (e, stackTrace) {
      print('[GameState] カメラ起動エラー: $e');
      print('[GameState] スタックトレース: $stackTrace');
      state = currentState.copyWith(error: 'カメラの起動に失敗: $e');
    }
  }

  /// 撮影カウントダウン完了（撮影→アップロード）
  Future<void> _onShootingCountdownComplete() async {
    final currentState = state;

    print('[GameState] 撮影完了処理開始');

    // ローディング表示を開始
    state = currentState.copyWith(isUploading: true);

    // 撮影時刻を記録
    final shootingAt = DateTime.now();
    print('[GameState] Firestoreに撮影時刻を記録中...');
    await matchRepository.updateMatchData(
      matchId: currentState.matchId,
      data: {'shootingAt': shootingAt},
    );
    print('[GameState] 撮影時刻記録完了');

    // 撮影した画像を取得してアップロード
    await _uploadCapturedImage();

    // カメラを停止（準備画面ではカメラプレビューを表示しない）
    print('[GameState] カメラ停止中...');
    await cameraService.stopCamera();
    print('[GameState] カメラ停止完了');

    // ローディング表示を終了して準備中フェーズへ
    state = state.copyWith(
      phase: GamePhase.preparing,
      preparingTimeRemaining: 5,
      isUploading: false,
    );

    print('[GameState] Firestoreにステータス更新中: preparing');
    await matchRepository.updateMatchStatus(
      currentState.matchId,
      'preparing',
    );
    print('[GameState] ステータス更新完了');

    // 5秒後に自動的に画像表示フェーズへ
    _startPreparingTimer();
    print('[GameState] 5秒タイマー開始');
  }

  /// 撮影画像をアップロード
  Future<void> _uploadCapturedImage() async {
    final currentState = state;

    try {
      print('[GameState] 画像アップロード開始');

      // ネイティブから撮影画像のパスを取得
      final imagePath = await cameraService.getCapturedImagePath();
      print('[GameState] 撮影画像パス: $imagePath');

      if (imagePath == null) {
        throw Exception('撮影画像が取得できませんでした');
      }

      final imageFile = File(imagePath);

      // ファイルが存在するか確認
      if (!await imageFile.exists()) {
        throw Exception('画像ファイルが存在しません: $imagePath');
      }

      final fileSize = await imageFile.length();
      print('[GameState] 画像ファイルサイズ: ${fileSize} bytes');

      final playerNumber = currentState.isPlayer1(currentUserId) ? 1 : 2;
      print('[GameState] プレイヤー番号: $playerNumber');

      // Firebase認証状態を確認
      final currentAuthUser = FirebaseAuth.instance.currentUser;
      final authStatus = currentAuthUser != null
          ? '認証済み (UID: ${currentAuthUser.uid})'
          : '未認証';
      print('[GameState] Firebase認証状態: $authStatus');
      if (currentAuthUser == null) {
        throw Exception('Firebase認証が必要です');
      }

      // Firebase Storageにアップロード
      print('[GameState] Firebase Storageへアップロード開始...');
      final uploadStartTime = DateTime.now();
      final imageUrl = await storageService.uploadMatchImage(
        matchId: currentState.matchId,
        playerNumber: playerNumber,
        imageFile: imageFile,
      );

      final uploadTime =
          DateTime.now().difference(uploadStartTime).inMilliseconds / 1000.0;
      print('[GameState] アップロード完了: ${uploadTime}秒, URL: $imageUrl');

      // Firestoreに画像URLを更新
      print('[GameState] Firestoreに画像URL更新中...');
      await matchRepository.updateImageUpload(
        matchId: currentState.matchId,
        playerId: currentUserId,
        imageUrl: imageUrl,
      );
      print('[GameState] Firestore更新完了');

      // アップロード時間を記録
      final isPlayer1 = currentState.isPlayer1(currentUserId);
      await matchRepository.updateMatchData(
        matchId: currentState.matchId,
        data: {
          '${isPlayer1 ? 'player1' : 'player2'}UploadTime': uploadTime,
        },
      );
      print('[GameState] アップロード時間記録完了');
    } catch (e, stackTrace) {
      print('[GameState] 画像アップロードエラー: $e');
      print('[GameState] スタックトレース: $stackTrace');

      state = currentState.copyWith(
        error: '画像のアップロードに失敗: $e',
      );
    }
  }

  /// 準備タイマー開始（5秒後に自動的に画像表示）
  void _startPreparingTimer() {
    _preparingTimeoutTimer?.cancel();
    _preparingTimeoutTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final current = state;

        if (current.preparingTimeRemaining <= 0) {
          timer.cancel();
          _onPreparingComplete();
          return;
        }

        state = current.copyWith(
          preparingTimeRemaining: current.preparingTimeRemaining - 1,
        );
      },
    );
  }

  /// 準備完了（5秒経過後、URL判定して画像表示または終了）
  Future<void> _onPreparingComplete() async {
    final currentState = state;
    _preparingTimeoutTimer?.cancel();

    // 最新のマッチデータを取得
    final match = await matchRepository.getMatch(currentState.matchId);
    if (match == null) {
      state = currentState.copyWith(error: 'マッチが見つかりません');
      return;
    }

    // URL判定
    final hasPlayer1Image = match.player1ImageUrl != null;
    final hasPlayer2Image = match.player2ImageUrl != null;

    if (!hasPlayer1Image && !hasPlayer2Image) {
      // 両者URLなし → 引き分け
      await _finishGame('draw');
      return;
    } else if (!hasPlayer1Image) {
      // player1のURLなし → player2が勝ち
      await _finishGame('player2');
      return;
    } else if (!hasPlayer2Image) {
      // player2のURLなし → player1が勝ち
      await _finishGame('player1');
      return;
    }

    // 両者URLあり → 対戦開始
    final isPlayer1 = currentState.isPlayer1(currentUserId);
    final opponentImageUrl = isPlayer1
        ? match.player2ImageUrl
        : match.player1ImageUrl;

    state = currentState.copyWith(
      match: match,
      opponentImageUrl: opponentImageUrl,
    );

    await _startPlaying();
  }

  /// にらめっこ対戦開始
  Future<void> _startPlaying() async {
    final currentState = state;

    // 対戦中フェーズへ
    state = currentState.copyWith(
      phase: GamePhase.playing,
      playingTimeRemaining: 20,
    );

    await matchRepository.updateMatchStatus(
      currentState.matchId,
      'playing',
    );

    // 画像表示時刻を記録
    await matchRepository.updateMatchData(
      matchId: currentState.matchId,
      data: {'imagesDisplayedAt': DateTime.now()},
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
          _onPlayerSmiled();
        }
      },
    );

    // 対戦タイマー（20秒）
    _playingTimer?.cancel();
    _playingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = state;

      if (current.playingTimeRemaining <= 0) {
        timer.cancel();
        _onPlayingTimeout();
        return;
      }

      state = current.copyWith(
        playingTimeRemaining: current.playingTimeRemaining - 1,
      );
    });
  }

  /// プレイヤーが笑った時の処理
  Future<void> _onPlayerSmiled() async {
    final currentState = state;

    _playingTimer?.cancel();
    _smileSubscription?.cancel();
    await cameraService.stopSmileDetection();

    // 笑顔検知時刻を記録
    await matchRepository.updateSmileDetected(
      matchId: currentState.matchId,
      playerId: currentUserId,
    );

    // 反応時間を計算
    if (currentState.match.imagesDisplayedAt != null) {
      final reactionTime =
          DateTime.now()
              .difference(currentState.match.imagesDisplayedAt!)
              .inMilliseconds /
          1000.0;

      final isPlayer1 = currentState.isPlayer1(currentUserId);
      await matchRepository.updateMatchData(
        matchId: currentState.matchId,
        data: {
          '${isPlayer1 ? 'player1' : 'player2'}ReactionTime': reactionTime,
        },
      );
    }

    // 勝者を決定（笑った方の負け）
    final isPlayer1 = currentState.isPlayer1(currentUserId);
    final winner = isPlayer1 ? 'player2' : 'player1';

    await _finishGame(winner);
  }

  /// 対戦タイムアウト（20秒経過 → 引き分け）
  Future<void> _onPlayingTimeout() async {
    _smileSubscription?.cancel();
    await cameraService.stopSmileDetection();

    // 20秒経過しても笑わず → 引き分け
    await _finishGame('draw');
  }

  /// ゲーム終了
  Future<void> _finishGame(String finalWinner) async {
    final currentState = state;

    // マッチ結果を確定
    await matchRepository.finishMatch(
      matchId: currentState.matchId,
      winnerId: finalWinner,
    );

    // タイマー全停止
    _countdownTimer?.cancel();
    _playingTimer?.cancel();
    _preparingTimeoutTimer?.cancel();
    _smileSubscription?.cancel();

    await cameraService.stopCamera();

    // 対戦成績を更新
    await _updateMatchStats(currentState.match, finalWinner);

    // 自分が結果準備完了をマーク
    await matchRepository.markPlayerReadyForResult(
      matchId: currentState.matchId,
      playerId: currentUserId,
    );

    // 結果待機フェーズに移行
    state = currentState.copyWith(
      phase: GamePhase.waitingForResult,
      resultWaitingTimeRemaining: 10,
    );

    // 両者準備完了を監視 & 10秒タイムアウト
    _startResultWaitingTimer();
  }

  /// 対戦成績とランキングを更新
  Future<void> _updateMatchStats(MatchModel match, String winner) async {
    try {
      final player1Id = match.player1;
      final player2Id = match.player2;

      // 引き分けでない場合のみ勝者を判定
      final isPlayer1Winner = winner == 'player1';
      final isPlayer2Winner = winner == 'player2';

      // player1の成績を更新
      await userRepository.updateMatchStats(
        userId: player1Id,
        won: isPlayer1Winner,
      );

      // player2の成績を更新
      await userRepository.updateMatchStats(
        userId: player2Id,
        won: isPlayer2Winner,
      );

      // ランキング情報を更新（両プレイヤー）
      await _updateRankingForUser(player1Id);
      await _updateRankingForUser(player2Id);
    } catch (e) {
      print('[GameState] 対戦成績の更新エラー: $e');
      // エラーが発生しても続行（ゲーム結果は保存済み）
    }
  }

  /// 特定ユーザーのランキング情報を更新
  Future<void> _updateRankingForUser(String userId) async {
    final user = await userRepository.getUser(userId);
    if (user == null) {
      print('[GameState] ユーザー情報が見つかりません: $userId');
      return;
    }

    await rankingRepository.updateRanking(
      userId: user.userId,
      nickname: user.nickname,
      totalMatches: user.totalMatches,
      wins: user.wins,
      winRate: user.winRate,
    );
  }

  /// 結果待機タイマー開始（10秒タイムアウト & 両者準備完了監視）
  void _startResultWaitingTimer() {
    _resultWaitingTimer?.cancel();

    // マッチ監視開始（すでに監視中だが、状態変化を検知）
    _matchSubscription?.cancel();
    _matchSubscription = matchRepository
        .watchMatch(state.matchId)
        .listen((match) {
      if (match == null) {
        return;
      }

      // 最新のマッチデータで状態を更新
      state = state.copyWith(match: match);

      // 両者が結果準備完了か確認
      if (match.player1ReadyForResult && match.player2ReadyForResult) {
        _resultWaitingTimer?.cancel();
        unawaited(_matchSubscription?.cancel());

        // 結果画面へ遷移
        state = state.copyWith(phase: GamePhase.finished);
        return;
      }
    });

    // 10秒タイムアウトタイマー
    _resultWaitingTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final current = state;

        if (current.resultWaitingTimeRemaining <= 0) {
          timer.cancel();
          unawaited(_matchSubscription?.cancel());

          // タイムアウト処理
          unawaited(_onResultWaitingTimeout());
          return;
        }

        state = current.copyWith(
          resultWaitingTimeRemaining: current.resultWaitingTimeRemaining - 1,
        );
      },
    );
  }

  /// 結果待機タイムアウト（10秒経過 → 待機側の勝利）
  Future<void> _onResultWaitingTimeout() async {
    final currentState = state;
    final match = currentState.match;

    // 相手が準備完了していない場合、自分の勝利に変更
    final isPlayer1 = currentState.isPlayer1(currentUserId);
    final opponentReady = isPlayer1
        ? match.player2ReadyForResult
        : match.player1ReadyForResult;

    if (!opponentReady) {
      // 相手がタイムアウト → 自分の勝利に変更
      final newWinner = isPlayer1 ? 'player1' : 'player2';

      await matchRepository.finishMatch(
        matchId: currentState.matchId,
        winnerId: newWinner,
      );

      // 成績を再更新
      await _updateMatchStats(match, newWinner);
    }

    // 結果画面へ遷移
    state = currentState.copyWith(phase: GamePhase.finished);
  }

  /// 手動でゲームを終了
  Future<void> quitGame() async {
    // タイマーを全て停止
    _countdownTimer?.cancel();
    _playingTimer?.cancel();
    _preparingTimeoutTimer?.cancel();
    _resultWaitingTimer?.cancel();
    unawaited(_smileSubscription?.cancel());

    // カメラを停止
    try {
      await cameraService.stopCamera();
    } on Exception catch (_) {
      // エラーは無視
    }

    // ゲームを終了
    await _finishGame('draw');
  }
}
