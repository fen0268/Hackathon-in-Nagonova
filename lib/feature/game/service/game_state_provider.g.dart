// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ゲーム状態管理プロバイダー

@ProviderFor(GameStateNotifier)
const gameStateProvider = GameStateNotifierFamily._();

/// ゲーム状態管理プロバイダー
final class GameStateNotifierProvider
    extends $NotifierProvider<GameStateNotifier, GameState> {
  /// ゲーム状態管理プロバイダー
  const GameStateNotifierProvider._({
    required GameStateNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'gameStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$gameStateNotifierHash();

  @override
  String toString() {
    return r'gameStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  GameStateNotifier create() => GameStateNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GameState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GameState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is GameStateNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$gameStateNotifierHash() => r'137d55dd6457029f5bf6907de55f7ba2073c70e7';

/// ゲーム状態管理プロバイダー

final class GameStateNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          GameStateNotifier,
          GameState,
          GameState,
          GameState,
          String
        > {
  const GameStateNotifierFamily._()
    : super(
        retry: null,
        name: r'gameStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// ゲーム状態管理プロバイダー

  GameStateNotifierProvider call(String matchId) =>
      GameStateNotifierProvider._(argument: matchId, from: this);

  @override
  String toString() => r'gameStateProvider';
}

/// ゲーム状態管理プロバイダー

abstract class _$GameStateNotifier extends $Notifier<GameState> {
  late final _$args = ref.$arg as String;
  String get matchId => _$args;

  GameState build(String matchId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<GameState, GameState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<GameState, GameState>,
              GameState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
