import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hackathon_app/feature/ranking/service/ranking_provider.dart';

class RankingPage extends ConsumerStatefulWidget {
  const RankingPage({super.key});

  static const routeName = '/ranking';

  @override
  ConsumerState<RankingPage> createState() => RankingPageState();
}

class RankingPageState extends ConsumerState<RankingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ランキング'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '勝率順'),
            Tab(text: '勝利数順'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRankingList(RankingType.winRate),
          _buildRankingList(RankingType.wins),
        ],
      ),
    );
  }

  Widget _buildRankingList(RankingType type) {
    final rankingAsync = type == RankingType.winRate
        ? ref.watch(rankingListByWinRateProvider)
        : ref.watch(rankingListByWinsProvider);

    return rankingAsync.when(
      data: (rankings) {
        if (rankings.isEmpty) {
          return const Center(
            child: Text(
              'まだランキングデータがありません',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: rankings.length,
          itemBuilder: (context, index) {
            final ranking = rankings[index];
            final rank = index + 1;

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: _buildRankBadge(rank),
                title: Text(
                  ranking.nickname,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '対戦数: ${ranking.totalMatches}試合 | 勝利: ${ranking.wins}勝',
                  style: const TextStyle(fontSize: 14),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      type == RankingType.winRate
                          ? '${(ranking.winRate * 100).toStringAsFixed(1)}%'
                          : '${ranking.wins}勝',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      type == RankingType.winRate ? '勝率' : '勝利数',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'ランキングの読み込みに失敗しました',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    Color badgeColor;
    IconData? icon;

    switch (rank) {
      case 1:
        badgeColor = Colors.amber;
        icon = Icons.emoji_events;
      case 2:
        badgeColor = Colors.grey[400]!;
        icon = Icons.emoji_events;
      case 3:
        badgeColor = Colors.brown[300]!;
        icon = Icons.emoji_events;
      default:
        badgeColor = Colors.blue[100]!;
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, color: Colors.white, size: 24)
            : Text(
                '$rank',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
