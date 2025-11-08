// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ランキングリストを取得するプロバイダー（勝率順）

@ProviderFor(rankingListByWinRate)
const rankingListByWinRateProvider = RankingListByWinRateProvider._();

/// ランキングリストを取得するプロバイダー（勝率順）

final class RankingListByWinRateProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RankingModel>>,
          List<RankingModel>,
          Stream<List<RankingModel>>
        >
    with
        $FutureModifier<List<RankingModel>>,
        $StreamProvider<List<RankingModel>> {
  /// ランキングリストを取得するプロバイダー（勝率順）
  const RankingListByWinRateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rankingListByWinRateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rankingListByWinRateHash();

  @$internal
  @override
  $StreamProviderElement<List<RankingModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<RankingModel>> create(Ref ref) {
    return rankingListByWinRate(ref);
  }
}

String _$rankingListByWinRateHash() =>
    r'0264fcdf8793f0c03330f7b35242595fbbfebaa0';

/// ランキングリストを取得するプロバイダー（勝利数順）

@ProviderFor(rankingListByWins)
const rankingListByWinsProvider = RankingListByWinsProvider._();

/// ランキングリストを取得するプロバイダー（勝利数順）

final class RankingListByWinsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RankingModel>>,
          List<RankingModel>,
          Stream<List<RankingModel>>
        >
    with
        $FutureModifier<List<RankingModel>>,
        $StreamProvider<List<RankingModel>> {
  /// ランキングリストを取得するプロバイダー（勝利数順）
  const RankingListByWinsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rankingListByWinsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rankingListByWinsHash();

  @$internal
  @override
  $StreamProviderElement<List<RankingModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<RankingModel>> create(Ref ref) {
    return rankingListByWins(ref);
  }
}

String _$rankingListByWinsHash() => r'5ce3fb7bfaf791723456b48004df2aa046587b71';
