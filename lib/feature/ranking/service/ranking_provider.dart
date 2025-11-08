import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app/feature/ranking/model/ranking_model.dart';
import 'package:hackathon_app/feature/ranking/service/ranking_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranking_provider.g.dart';

/// ランキングの表示タイプ
enum RankingType {
  winRate, // 勝率順
  wins, // 勝利数順
}

/// ランキングリストを取得するプロバイダー（勝率順）
@riverpod
Stream<List<RankingModel>> rankingListByWinRate(Ref ref) {
  final repository = ref.watch(rankingRepositoryProvider);
  return repository.watchTopRankingsByWinRate(limit: 50);
}

/// ランキングリストを取得するプロバイダー（勝率順・スナップショット）
final FutureProvider<List<RankingModel>> rankingListByWinRateSnapshotProvider =
    FutureProvider.autoDispose<List<RankingModel>>((ref) {
      return ref.watch(rankingListByWinRateProvider.future);
    });

/// ランキングリストを取得するプロバイダー（勝利数順）
@riverpod
Stream<List<RankingModel>> rankingListByWins(Ref ref) {
  final repository = ref.watch(rankingRepositoryProvider);
  return repository.watchTopRankingsByWins(limit: 50);
}
