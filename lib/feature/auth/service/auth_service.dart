import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 匿名認証を実行
  Future<User?> signInAnonymously() async {
    final credential = await _auth.signInAnonymously();
    return credential.user;
  }

  /// 現在のユーザーを取得
  User? get currentUser => _auth.currentUser;

  /// ユーザー認証状態のStream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// ニックネームを登録してFirestoreにユーザー情報を作成
  Future<void> registerNickname(String nickname) async {
    final user = currentUser;
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    await _firestore.collection('users').doc(user.uid).set({
      'userId': user.uid,
      'nickname': nickname,
      'totalMatches': 0,
      'wins': 0,
      'winRate': 0.0,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// ニックネームが登録済みかどうかをチェック
  Future<bool> hasNickname() async {
    final user = currentUser;
    if (user == null) {
      return false;
    }

    final doc = await _firestore.collection('users').doc(user.uid).get();
    return doc.exists && doc.data()?['nickname'] != null;
  }
}
