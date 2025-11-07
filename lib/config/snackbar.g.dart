// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snackbar.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// SnackBarService provider

@ProviderFor(snackBarService)
const snackBarServiceProvider = SnackBarServiceProvider._();

/// SnackBarService provider

final class SnackBarServiceProvider
    extends
        $FunctionalProvider<SnackBarService, SnackBarService, SnackBarService>
    with $Provider<SnackBarService> {
  /// SnackBarService provider
  const SnackBarServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'snackBarServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$snackBarServiceHash();

  @$internal
  @override
  $ProviderElement<SnackBarService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SnackBarService create(Ref ref) {
    return snackBarService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SnackBarService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SnackBarService>(value),
    );
  }
}

String _$snackBarServiceHash() => r'18ed92896486d58b915b984f9bda74343086e900';
