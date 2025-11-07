import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_app/feature/auth/service/user_repository.dart';
import 'package:hackathon_app/feature/matching/model/matchmaking_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'matchmaking_repository.g.dart';

class MatchmakingRepository {
  MatchmakingRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _matchmakingCollection =>
      _firestore.collection('matchmaking');

  /// マッチメイキングキューに参加
  Future<void> joinQueue(String userId) async {
    await _matchmakingCollection
        .doc(userId)
        .set(
          MatchmakingModel(
            userId: userId,
            createdAt: DateTime.now(),
          ).toJson(),
        );
  }

  /// マッチメイキングキューから退出
  Future<void> leaveQueue(String userId) async {
    await _matchmakingCollection.doc(userId).delete();
  }

  /// 待機中のユーザーを取得
  Future<MatchmakingModel?> findWaitingOpponent(String myUserId) async {
    final snapshot = await _matchmakingCollection
        .where('status', isEqualTo: 'waiting')
        .where(FieldPath.documentId, isNotEqualTo: myUserId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return MatchmakingModel.fromJson(snapshot.docs.first.data());
  }

  /// マッチング状態を更新
  Future<void> updateMatchmakingStatus({
    required String userId,
    required String status,
    String? matchedWith,
    String? matchId,
  }) async {
    final data = <String, dynamic>{
      'status': status,
    };

    if (matchedWith != null) {
      data['matchedWith'] = matchedWith;
    }
    if (matchId != null) {
      data['matchId'] = matchId;
    }

    await _matchmakingCollection.doc(userId).update(data);
  }

  /// マッチメイキング情報をストリームで取得
  Stream<MatchmakingModel?> watchMatchmaking(String userId) {
    return _matchmakingCollection.doc(userId).snapshots().map((doc) {
      if (!doc.exists) {
        return null;
      }
      return MatchmakingModel.fromJson(doc.data()!);
    });
  }

  /// 古いマッチメイキング情報を削除（30秒以上前）
  Future<void> cleanupOldEntries() async {
    final cutoffTime = DateTime.now().subtract(const Duration(seconds: 30));
    final snapshot = await _matchmakingCollection
        .where('createdAt', isLessThan: Timestamp.fromDate(cutoffTime))
        .get();

    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}

@riverpod
MatchmakingRepository matchmakingRepository(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return MatchmakingRepository(firestore);
}
