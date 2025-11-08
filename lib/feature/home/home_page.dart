import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/feature/auth/model/user_model.dart';
import 'package:hackathon_app/feature/auth/service/auth_provider.dart';
import 'package:hackathon_app/feature/auth/service/user_repository.dart';

import '../matching/matching_page.dart';
import '../ranking/ranking_page.dart';
import '../settings/settings_page.dart';

/// 現在のユーザー情報を取得するプロバイダー
final FutureProvider<UserModel?> currentUserProvider =
    FutureProvider.autoDispose<UserModel?>((ref) {
      final currentUser = ref.watch(authStateChangesProvider).value;
      final userId = currentUser?.uid ?? '';

      if (userId.isEmpty) {
        return Future.value();
      }

      final userRepository = ref.watch(userRepositoryProvider);
      return userRepository.getUser(userId);
    });

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  HomePageState createConsumerState() => HomePageState();

  static const routeName = '/home';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(currentUserProvider);

    return userAsync.when(
      data: (user) => _buildHome(context, user),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text('エラー: $error'),
        ),
      ),
    );
  }

  Widget _buildHome(BuildContext context, UserModel? user) {
    final totalMatches = user?.totalMatches ?? 0;
    final wins = user?.wins ?? 0;
    final winRate = user?.winRate ?? 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('にらめっこ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              context.push(SettingsPage.routeName);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // タイトル
              const Text(
                'にらめっこ対戦',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // ユーザー統計情報カード
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        'あなたの成績',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('対戦数', totalMatches.toString()),
                          _buildStatItem('勝利数', wins.toString()),
                          _buildStatItem(
                            '勝率',
                            '${(winRate * 100).toStringAsFixed(1)}%',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // マッチング開始ボタン
              ElevatedButton(
                onPressed: () {
                  context.push(MatchingPage.routeName);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('マッチング開始'),
              ),
              const SizedBox(height: 16),

              // ランキング表示ボタン
              OutlinedButton(
                onPressed: () {
                  context.push(RankingPage.routeName);
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('ランキングを見る'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
