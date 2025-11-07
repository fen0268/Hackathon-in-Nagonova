import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_service.dart';

part 'auth_provider.g.dart';

/// AuthServiceのProvider
@riverpod
AuthService authService(Ref ref) {
  return AuthService();
}

/// 認証状態を監視するProvider
@riverpod
Stream<User?> authStateChanges(Ref ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
}

/// ユーザーが認証済みかどうかを返すProvider
@riverpod
bool authState(Ref ref) {
  final authStateStream = ref.watch(authStateChangesProvider);
  return authStateStream.when(
    data: (user) => user != null,
    loading: () => false,
    error: (_, __) => false,
  );
}

/// ニックネームが登録済みかどうかを返すProvider
@riverpod
Future<bool> hasNickname(Ref ref) async {
  final authService = ref.watch(authServiceProvider);
  return authService.hasNickname();
}
