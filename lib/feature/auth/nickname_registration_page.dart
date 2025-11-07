import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../home/home_page.dart';
import 'service/auth_provider.dart';

class NicknameRegistrationPage extends ConsumerStatefulWidget {
  const NicknameRegistrationPage({super.key});

  static const routeName = '/nickname-registration';

  @override
  ConsumerState<NicknameRegistrationPage> createState() =>
      _NicknameRegistrationPageState();
}

class _NicknameRegistrationPageState
    extends ConsumerState<NicknameRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _registerNickname() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = ref.read(authServiceProvider);
      await authService.registerNickname(_nicknameController.text.trim());

      if (mounted) {
        context.go(HomePage.routeName);
      }
    } on Exception catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ニックネームの登録に失敗しました: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'ニックネームを\n設定してください',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'このニックネームは対戦相手に表示されます',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _nicknameController,
                  decoration: const InputDecoration(
                    labelText: 'ニックネーム',
                    hintText: '例: Player123',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  maxLength: 20,
                  enabled: !_isLoading,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'ニックネームを入力してください';
                    }
                    if (value.trim().length < 2) {
                      return 'ニックネームは2文字以上で入力してください';
                    }
                    if (value.trim().length > 20) {
                      return 'ニックネームは20文字以内で入力してください';
                    }
                    return null;
                  },
                  onFieldSubmitted: (_) => _registerNickname(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _registerNickname,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('登録'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
