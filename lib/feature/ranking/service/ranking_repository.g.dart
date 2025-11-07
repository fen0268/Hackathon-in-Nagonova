// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rankingRepository)
const rankingRepositoryProvider = RankingRepositoryProvider._();

final class RankingRepositoryProvider
    extends
        $FunctionalProvider<
          RankingRepository,
          RankingRepository,
          RankingRepository
        >
    with $Provider<RankingRepository> {
  const RankingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rankingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rankingRepositoryHash();

  @$internal
  @override
  $ProviderElement<RankingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RankingRepository create(Ref ref) {
    return rankingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RankingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RankingRepository>(value),
    );
  }
}

String _$rankingRepositoryHash() => r'b39cc6b31326f5b12baa313baa960678be008cd1';
