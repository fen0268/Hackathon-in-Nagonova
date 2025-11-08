import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon_app/feature/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

class UserRepository {
  UserRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  /// ユーザーを作成
  Future<void> createUser(UserModel user) async {
    await _usersCollection.doc(user.userId).set(user.toJson());
  }

  /// ユーザー情報を取得
  Future<UserModel?> getUser(String userId) async {
    final doc = await _usersCollection.doc(userId).get();
    if (!doc.exists) {
      return null;
    }
    return UserModel.fromJson(doc.data()!);
  }

  /// ユーザー情報を更新
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    await _usersCollection.doc(userId).update(data);
  }

  /// 試合統計を更新
  Future<void> updateMatchStats({
    required String userId,
    required bool won,
  }) async {
    final userDoc = _usersCollection.doc(userId);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDoc);
      if (!snapshot.exists) {
        throw Exception('User does not exist');
      }

      final data = snapshot.data()!;
      final totalMatches = (data['totalMatches'] as int? ?? 0) + 1;
      final wins = (data['wins'] as int? ?? 0) + (won ? 1 : 0);
      final winRate = totalMatches > 0 ? wins / totalMatches : 0.0;

      transaction.update(userDoc, {
        'totalMatches': totalMatches,
        'wins': wins,
        'winRate': winRate,
      });
    });
  }

  /// ニックネームを更新
  Future<void> updateNickname(String userId, String nickname) async {
    await updateUser(userId, {'nickname': nickname});
  }
}

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
UserRepository userRepository(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return UserRepository(firestore);
}
