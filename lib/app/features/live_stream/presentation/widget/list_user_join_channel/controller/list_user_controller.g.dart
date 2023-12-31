// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listUserControllerHash() =>
    r'dfb0c1fae8840173c9da660fe46995a8968b4800';

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

abstract class _$ListUserController
    extends BuildlessAutoDisposeStreamNotifier<List<UserLiveStreamEntity>> {
  late final String channelName;

  Stream<List<UserLiveStreamEntity>> build(
    String channelName,
  );
}

/// See also [ListUserController].
@ProviderFor(ListUserController)
const listUserControllerProvider = ListUserControllerFamily();

/// See also [ListUserController].
class ListUserControllerFamily
    extends Family<AsyncValue<List<UserLiveStreamEntity>>> {
  /// See also [ListUserController].
  const ListUserControllerFamily();

  /// See also [ListUserController].
  ListUserControllerProvider call(
    String channelName,
  ) {
    return ListUserControllerProvider(
      channelName,
    );
  }

  @override
  ListUserControllerProvider getProviderOverride(
    covariant ListUserControllerProvider provider,
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
  String? get name => r'listUserControllerProvider';
}

/// See also [ListUserController].
class ListUserControllerProvider extends AutoDisposeStreamNotifierProviderImpl<
    ListUserController, List<UserLiveStreamEntity>> {
  /// See also [ListUserController].
  ListUserControllerProvider(
    String channelName,
  ) : this._internal(
          () => ListUserController()..channelName = channelName,
          from: listUserControllerProvider,
          name: r'listUserControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listUserControllerHash,
          dependencies: ListUserControllerFamily._dependencies,
          allTransitiveDependencies:
              ListUserControllerFamily._allTransitiveDependencies,
          channelName: channelName,
        );

  ListUserControllerProvider._internal(
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
  Stream<List<UserLiveStreamEntity>> runNotifierBuild(
    covariant ListUserController notifier,
  ) {
    return notifier.build(
      channelName,
    );
  }

  @override
  Override overrideWith(ListUserController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListUserControllerProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<ListUserController,
      List<UserLiveStreamEntity>> createElement() {
    return _ListUserControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListUserControllerProvider &&
        other.channelName == channelName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListUserControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<UserLiveStreamEntity>> {
  /// The parameter `channelName` of this provider.
  String get channelName;
}

class _ListUserControllerProviderElement
    extends AutoDisposeStreamNotifierProviderElement<ListUserController,
        List<UserLiveStreamEntity>> with ListUserControllerRef {
  _ListUserControllerProviderElement(super.provider);

  @override
  String get channelName => (origin as ListUserControllerProvider).channelName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
