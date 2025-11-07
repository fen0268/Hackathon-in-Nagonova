// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matchmaking_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// マッチメイキングプロバイダー

@ProviderFor(MatchmakingController)
const matchmakingControllerProvider = MatchmakingControllerProvider._();

/// マッチメイキングプロバイダー
final class MatchmakingControllerProvider
    extends $NotifierProvider<MatchmakingController, MatchmakingState> {
  /// マッチメイキングプロバイダー
  const MatchmakingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'matchmakingControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$matchmakingControllerHash();

  @$internal
  @override
  MatchmakingController create() => MatchmakingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MatchmakingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MatchmakingState>(value),
    );
  }
}

String _$matchmakingControllerHash() =>
    r'3d1ddf6bcfec7b9c0febc7e6e3b80240744574ab';

/// マッチメイキングプロバイダー

abstract class _$MatchmakingController extends $Notifier<MatchmakingState> {
  MatchmakingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MatchmakingState, MatchmakingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MatchmakingState, MatchmakingState>,
              MatchmakingState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
