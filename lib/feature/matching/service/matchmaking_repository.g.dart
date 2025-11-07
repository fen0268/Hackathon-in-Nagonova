// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchmaking_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(matchmakingRepository)
const matchmakingRepositoryProvider = MatchmakingRepositoryProvider._();

final class MatchmakingRepositoryProvider
    extends
        $FunctionalProvider<
          MatchmakingRepository,
          MatchmakingRepository,
          MatchmakingRepository
        >
    with $Provider<MatchmakingRepository> {
  const MatchmakingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'matchmakingRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$matchmakingRepositoryHash();

  @$internal
  @override
  $ProviderElement<MatchmakingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MatchmakingRepository create(Ref ref) {
    return matchmakingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MatchmakingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MatchmakingRepository>(value),
    );
  }
}

String _$matchmakingRepositoryHash() =>
    r'8664c5aeb4c5e5e2bf6de180441bddb10fc9039b';
