// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_button_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$callButtonStateControllerHash() =>
    r'41d22f0dcf4acb3a5138acf78b1a8c3ee0987ace';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CallButtonStateController
    extends BuildlessAutoDisposeNotifier<bool> {
  late final (int, CallButtonType) userIdAndButtonType;

  bool build(
    (int, CallButtonType) userIdAndButtonType,
  );
}

/// See also [CallButtonStateController].
@ProviderFor(CallButtonStateController)
const callButtonStateControllerProvider = CallButtonStateControllerFamily();

/// See also [CallButtonStateController].
class CallButtonStateControllerFamily extends Family<bool> {
  /// See also [CallButtonStateController].
  const CallButtonStateControllerFamily();

  /// See also [CallButtonStateController].
  CallButtonStateControllerProvider call(
    (int, CallButtonType) userIdAndButtonType,
  ) {
    return CallButtonStateControllerProvider(
      userIdAndButtonType,
    );
  }

  @override
  CallButtonStateControllerProvider getProviderOverride(
    covariant CallButtonStateControllerProvider provider,
  ) {
    return call(
      provider.userIdAndButtonType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'callButtonStateControllerProvider';
}

/// See also [CallButtonStateController].
class CallButtonStateControllerProvider
    extends AutoDisposeNotifierProviderImpl<CallButtonStateController, bool> {
  /// See also [CallButtonStateController].
  CallButtonStateControllerProvider(
    (int, CallButtonType) userIdAndButtonType,
  ) : this._internal(
          () => CallButtonStateController()
            ..userIdAndButtonType = userIdAndButtonType,
          from: callButtonStateControllerProvider,
          name: r'callButtonStateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$callButtonStateControllerHash,
          dependencies: CallButtonStateControllerFamily._dependencies,
          allTransitiveDependencies:
              CallButtonStateControllerFamily._allTransitiveDependencies,
          userIdAndButtonType: userIdAndButtonType,
        );

  CallButtonStateControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userIdAndButtonType,
  }) : super.internal();

  final (int, CallButtonType) userIdAndButtonType;

  @override
  bool runNotifierBuild(
    covariant CallButtonStateController notifier,
  ) {
    return notifier.build(
      userIdAndButtonType,
    );
  }

  @override
  Override overrideWith(CallButtonStateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CallButtonStateControllerProvider._internal(
        () => create()..userIdAndButtonType = userIdAndButtonType,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userIdAndButtonType: userIdAndButtonType,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CallButtonStateController, bool>
      createElement() {
    return _CallButtonStateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CallButtonStateControllerProvider &&
        other.userIdAndButtonType == userIdAndButtonType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userIdAndButtonType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CallButtonStateControllerRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `userIdAndButtonType` of this provider.
  (int, CallButtonType) get userIdAndButtonType;
}

class _CallButtonStateControllerProviderElement
    extends AutoDisposeNotifierProviderElement<CallButtonStateController, bool>
    with CallButtonStateControllerRef {
  _CallButtonStateControllerProviderElement(super.provider);

  @override
  (int, CallButtonType) get userIdAndButtonType =>
      (origin as CallButtonStateControllerProvider).userIdAndButtonType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
