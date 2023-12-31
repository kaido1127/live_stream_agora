// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user_in_channel_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$localUserInChannelControllerHash() =>
    r'bfbb3112d376d3871971f8b7d6d19b8bd9a9f5d2';

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

abstract class _$LocalUserInChannelController
    extends BuildlessAutoDisposeStreamNotifier<UserLiveStreamEntity?> {
  late final String channelName;

  Stream<UserLiveStreamEntity?> build(
    String channelName,
  );
}

/// See also [LocalUserInChannelController].
@ProviderFor(LocalUserInChannelController)
const localUserInChannelControllerProvider =
    LocalUserInChannelControllerFamily();

/// See also [LocalUserInChannelController].
class LocalUserInChannelControllerFamily
    extends Family<AsyncValue<UserLiveStreamEntity?>> {
  /// See also [LocalUserInChannelController].
  const LocalUserInChannelControllerFamily();

  /// See also [LocalUserInChannelController].
  LocalUserInChannelControllerProvider call(
    String channelName,
  ) {
    return LocalUserInChannelControllerProvider(
      channelName,
    );
  }

  @override
  LocalUserInChannelControllerProvider getProviderOverride(
    covariant LocalUserInChannelControllerProvider provider,
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
  String? get name => r'localUserInChannelControllerProvider';
}

/// See also [LocalUserInChannelController].
class LocalUserInChannelControllerProvider
    extends AutoDisposeStreamNotifierProviderImpl<LocalUserInChannelController,
        UserLiveStreamEntity?> {
  /// See also [LocalUserInChannelController].
  LocalUserInChannelControllerProvider(
    String channelName,
  ) : this._internal(
          () => LocalUserInChannelController()..channelName = channelName,
          from: localUserInChannelControllerProvider,
          name: r'localUserInChannelControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$localUserInChannelControllerHash,
          dependencies: LocalUserInChannelControllerFamily._dependencies,
          allTransitiveDependencies:
              LocalUserInChannelControllerFamily._allTransitiveDependencies,
          channelName: channelName,
        );

  LocalUserInChannelControllerProvider._internal(
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
  Stream<UserLiveStreamEntity?> runNotifierBuild(
    covariant LocalUserInChannelController notifier,
  ) {
    return notifier.build(
      channelName,
    );
  }

  @override
  Override overrideWith(LocalUserInChannelController Function() create) {
    return ProviderOverride(
      origin: this,
      override: LocalUserInChannelControllerProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<LocalUserInChannelController,
      UserLiveStreamEntity?> createElement() {
    return _LocalUserInChannelControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocalUserInChannelControllerProvider &&
        other.channelName == channelName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LocalUserInChannelControllerRef
    on AutoDisposeStreamNotifierProviderRef<UserLiveStreamEntity?> {
  /// The parameter `channelName` of this provider.
  String get channelName;
}

class _LocalUserInChannelControllerProviderElement
    extends AutoDisposeStreamNotifierProviderElement<
        LocalUserInChannelController,
        UserLiveStreamEntity?> with LocalUserInChannelControllerRef {
  _LocalUserInChannelControllerProviderElement(super.provider);

  @override
  String get channelName =>
      (origin as LocalUserInChannelControllerProvider).channelName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
