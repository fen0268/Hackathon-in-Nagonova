import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthState extends _$AuthState {
  @override
  bool build() {
    // TODO: Firebase Authentication の実装後、実際の認証状態を返す
    // 現在は仮実装として false を返す
    return false;
  }

  // 認証状態を更新するメソッド（実装時に使用）
  void setAuthenticated(bool isAuthenticated) {
    state = isAuthenticated;
  }
}
