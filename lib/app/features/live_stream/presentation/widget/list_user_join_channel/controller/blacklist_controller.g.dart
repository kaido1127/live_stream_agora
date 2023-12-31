// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blacklist_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$blacklistControllerHash() =>
    r'cd1f75c392f74f5511a91af790a536855d9eb506';

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

abstract class _$BlacklistController
    extends BuildlessAutoDisposeStreamNotifier<List<BlockedUserEntity>> {
  late final String channelName;

  Stream<List<BlockedUserEntity>> build(
    String channelName,
  );
}

/// See also [BlacklistController].
@ProviderFor(BlacklistController)
const blacklistControllerProvider = BlacklistControllerFamily();

/// See also [BlacklistController].
class BlacklistControllerFamily
    extends Family<AsyncValue<List<BlockedUserEntity>>> {
  /// See also [BlacklistController].
  const BlacklistControllerFamily();

  /// See also [BlacklistController].
  BlacklistControllerProvider call(
    String channelName,
  ) {
    return BlacklistControllerProvider(
      channelName,
    );
  }

  @override
  BlacklistControllerProvider getProviderOverride(
    covariant BlacklistControllerProvider provider,
  ) {
    return call(
      provider.channelName,
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
  String? get name => r'blacklistControllerProvider';
}

/// See also [BlacklistController].
class BlacklistControllerProvider extends AutoDisposeStreamNotifierProviderImpl<
    BlacklistController, List<BlockedUserEntity>> {
  /// See also [BlacklistController].
  BlacklistControllerProvider(
    String channelName,
  ) : this._internal(
          () => BlacklistController()..channelName = channelName,
          from: blacklistControllerProvider,
          name: r'blacklistControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$blacklistControllerHash,
          dependencies: BlacklistControllerFamily._dependencies,
          allTransitiveDependencies:
              BlacklistControllerFamily._allTransitiveDependencies,
          channelName: channelName,
        );

  BlacklistControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channelName,
  }) : super.internal();

  final String channelName;

  @override
  Stream<List<BlockedUserEntity>> runNotifierBuild(
    covariant BlacklistController notifier,
  ) {
    return notifier.build(
      channelName,
    );
  }

  @override
  Override overrideWith(BlacklistController Function() create) {
    return ProviderOverride(
      origin: this,
      override: BlacklistControllerProvider._internal(
        () => create()..channelName = channelName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channelName: channelName,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<BlacklistController,
      List<BlockedUserEntity>> createElement() {
    return _BlacklistControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BlacklistControllerProvider &&
        other.channelName == channelName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BlacklistControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<BlockedUserEntity>> {
  /// The parameter `channelName` of this provider.
  String get channelName;
}

class _BlacklistControllerProviderElement
    extends AutoDisposeStreamNotifierProviderElement<BlacklistController,
        List<BlockedUserEntity>> with BlacklistControllerRef {
  _BlacklistControllerProviderElement(super.provider);

  @override
  String get channelName => (origin as BlacklistControllerProvider).channelName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
