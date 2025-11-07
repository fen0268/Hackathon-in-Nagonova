import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../home/home_page.dart';
import 'nickname_registration_page.dart';
import 'service/auth_provider.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  static const routeName = '/auth';

  @override
  ConsumerState<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends ConsumerState<AuthPage> {
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // ページ表示時に自動的に匿名認証を実行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndNavigate();
    });
  }

  Future<void> _checkAuthAndNavigate() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final authService = ref.read(authServiceProvider);
      final currentUser = authService.currentUser;

      // すでに認証済みの場合
      if (currentUser != null) {
        final hasNickname = await authService.hasNickname();
        if (mounted) {
          if (hasNickname) {
            context.go(HomePage.routeName);
          } else {
            context.go(NicknameRegistrationPage.routeName);
          }
        }
        return;
      }

      // 未認証の場合は匿名認証を実行
      await authService.signInAnonymously();

      // 認証成功後、ニックネーム登録ページへ
      if (mounted) {
        context.go(NicknameRegistrationPage.routeName);
      }
    } on Exception catch (e) {
      setState(() {
        _errorMessage = '認証に失敗しました: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('認証中...'),
                ],
              )
            : _errorMessage != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _checkAuthAndNavigate,
                    child: const Text('再試行'),
                  ),
                ],
              )
            : const Text('読み込み中...'),
      ),
    );
  }
}
