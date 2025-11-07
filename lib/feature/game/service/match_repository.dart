import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_app/feature/auth/service/user_repository.dart';
import 'package:hackathon_app/feature/game/model/match_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'match_repository.g.dart';

class MatchRepository {
  MatchRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _matchesCollection =>
      _firestore.collection('matches');

  /// マッチを作成
  Future<String> createMatch({
    required String player1,
    required String player2,
  }) async {
    final docRef = _matchesCollection.doc();
    final match = MatchModel(
      matchId: docRef.id,
      player1: player1,
      player2: player2,
      startedAt: DateTime.now(),
      createdAt: DateTime.now(),
    );

    await docRef.set(match.toJson());
    return docRef.id;
  }

  /// マッチ情報を取得
  Future<MatchModel?> getMatch(String matchId) async {
    final doc = await _matchesCollection.doc(matchId).get();
    if (!doc.exists) {
      return null;
    }
    return MatchModel.fromJson(doc.data()!);
  }

  /// マッチ情報をストリームで取得
  Stream<MatchModel?> watchMatch(String matchId) {
    return _matchesCollection.doc(matchId).snapshots().map((doc) {
      if (!doc.exists) {
        return null;
      }
      return MatchModel.fromJson(doc.data()!);
    });
  }

  /// マッチステータスを更新
  Future<void> updateMatchStatus(String matchId, String status) async {
    await _matchesCollection.doc(matchId).update({'status': status});
  }

  /// ラウンド情報を更新
  Future<void> updateRound({
    required String matchId,
    required int roundNumber,
    required Map<String, dynamic> roundData,
  }) async {
    await _matchesCollection.doc(matchId).update({
      'round$roundNumber': roundData,
    });
  }

  /// 画像アップロード情報を更新
  Future<void> updateImageUpload({
    required String matchId,
    required int roundNumber,
    required String playerId,
    required String imageUrl,
  }) async {
    final match = await getMatch(matchId);
    if (match == null) {
      throw Exception('Match not found');
    }

    final isPlayer1 = match.player1 == playerId;
    final fieldPrefix = 'round$roundNumber';

    await _matchesCollection.doc(matchId).update({
      '$fieldPrefix.${isPlayer1 ? 'player1' : 'player2'}ImageUrl': imageUrl,
      '$fieldPrefix.${isPlayer1 ? 'player1' : 'player2'}ImageReady': true,
      '$fieldPrefix.${isPlayer1 ? 'player1' : 'player2'}UploadedAt':
          Timestamp.now(),
    });
  }

  /// スマイル検出時刻を更新
  Future<void> updateSmileDetected({
    required String matchId,
    required int roundNumber,
    required String playerId,
  }) async {
    final match = await getMatch(matchId);
    if (match == null) {
      throw Exception('Match not found');
    }

    final isPlayer1 = match.player1 == playerId;
    final fieldPrefix = 'round$roundNumber';

    await _matchesCollection.doc(matchId).update({
      '$fieldPrefix.${isPlayer1 ? 'player1' : 'player2'}SmileDetectedAt':
          Timestamp.now(),
    });
  }

  /// ラウンド勝者を設定
  Future<void> setRoundWinner({
    required String matchId,
    required int roundNumber,
    required String winnerId,
  }) async {
    await _matchesCollection.doc(matchId).update({
      'round$roundNumber.winner': winnerId,
      'round$roundNumber.roundEndedAt': Timestamp.now(),
    });
  }

  /// 次のラウンドに進む
  Future<void> proceedToNextRound(String matchId) async {
    await _matchesCollection.doc(matchId).update({
      'currentRound': FieldValue.increment(1),
    });
  }

  /// マッチを終了し、最終勝者を設定
  Future<void> finishMatch({
    required String matchId,
    required String winnerId,
  }) async {
    await _matchesCollection.doc(matchId).update({
      'status': 'finished',
      'finalWinner': winnerId,
      'finishedAt': Timestamp.now(),
    });
  }

  /// ユーザーの最近のマッチ一覧を取得
  Future<List<MatchModel>> getUserMatches(
    String userId, {
    int limit = 10,
  }) async {
    final snapshot = await _matchesCollection
        .where('status', isEqualTo: 'finished')
        .where(
          Filter.or(
            Filter('player1', isEqualTo: userId),
            Filter('player2', isEqualTo: userId),
          ),
        )
        .orderBy('finishedAt', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs.map((doc) => MatchModel.fromJson(doc.data())).toList();
  }
}

@riverpod
MatchRepository matchRepository(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return MatchRepository(firestore);
}
