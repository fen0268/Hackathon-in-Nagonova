import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_app/feature/auth/service/user_repository.dart';
import 'package:hackathon_app/feature/ranking/model/ranking_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_repository.g.dart';

class RankingRepository {
  RankingRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _rankingsCollection =>
      _firestore.collection('rankings');

  /// ランキング情報を更新
  Future<void> updateRanking({
    required String userId,
    required String nickname,
    required int totalMatches,
    required int wins,
    required double winRate,
  }) async {
    await _rankingsCollection.doc(userId).set(
          RankingModel(
            userId: userId,
            nickname: nickname,
            totalMatches: totalMatches,
            wins: wins,
            winRate: winRate,
            updatedAt: DateTime.now(),
          ).toJson(),
          SetOptions(merge: true),
        );
  }

  /// トップランキングを取得（勝率順）
  Future<List<RankingModel>> getTopRankingsByWinRate({int limit = 20}) async {
    final snapshot = await _rankingsCollection
        .where('totalMatches', isGreaterThanOrEqualTo: 3)
        .orderBy('totalMatches')
        .orderBy('winRate', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => RankingModel.fromJson(doc.data()))
        .toList();
  }

  /// トップランキングを取得（勝利数順）
  Future<List<RankingModel>> getTopRankingsByWins({int limit = 20}) async {
    final snapshot = await _rankingsCollection
        .orderBy('wins', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((doc) => RankingModel.fromJson(doc.data()))
        .toList();
  }

  /// 特定ユーザーのランキング情報を取得
  Future<RankingModel?> getUserRanking(String userId) async {
    final doc = await _rankingsCollection.doc(userId).get();
    if (!doc.exists) {
      return null;
    }
    return RankingModel.fromJson(doc.data()!);
  }

  /// ランキング情報をストリームで取得（勝率順）
  Stream<List<RankingModel>> watchTopRankingsByWinRate({int limit = 20}) {
    return _rankingsCollection
        .where('totalMatches', isGreaterThanOrEqualTo: 3)
        .orderBy('totalMatches')
        .orderBy('winRate', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RankingModel.fromJson(doc.data()))
              .toList(),
        );
  }

  /// ランキング情報をストリームで取得（勝利数順）
  Stream<List<RankingModel>> watchTopRankingsByWins({int limit = 20}) {
    return _rankingsCollection
        .orderBy('wins', descending: true)
        .limit(limit)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => RankingModel.fromJson(doc.data()))
              .toList(),
        );
  }
}

@riverpod
RankingRepository rankingRepository(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return RankingRepository(firestore);
}
