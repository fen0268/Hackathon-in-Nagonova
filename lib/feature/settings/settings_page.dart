import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/snackbar.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            _buildSection(
              title: 'アカウント',
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('ニックネーム変更'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    final snackBar = ref.read(snackBarServiceProvider);
                    snackBar.showInfo(context, '実装予定');
                  },
                ),
              ],
            ),
            const Divider(height: 32),
            _buildSection(
              title: 'アプリ情報',
              children: [
                const ListTile(
                  leading: Icon(Icons.info),
                  title: Text('バージョン'),
                  trailing: Text('1.0.0'),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('利用規約'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ref.read(snackBarServiceProvider).showInfo(context, '実装予定');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('プライバシーポリシー'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ref.read(snackBarServiceProvider).showInfo(context, '実装予定');
                  },
                ),
              ],
            ),
            const Divider(height: 32),
            _buildSection(
              title: 'その他',
              children: [
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'ログアウト',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: _showLogoutDialog,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ログアウト'),
        content: const Text('ログアウトしますか？\n次回起動時に新しいアカウントが作成されます。'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(snackBarServiceProvider).showInfo(context, '実装予定');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('ログアウト'),
          ),
        ],
      ),
    );
  }
}
