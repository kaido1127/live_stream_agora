// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_action_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listActionControllerHash() =>
    r'7d5a3802be3fdb0293a737d5f45240f97a0fa943';

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

abstract class _$ListActionController
    extends BuildlessAutoDisposeStreamNotifier<List<BaseActionEntity>> {
  late final String channelName;
  late final int range;

  Stream<List<BaseActionEntity>> build(
    String channelName,
    int range,
  );
}

/// See also [ListActionController].
@ProviderFor(ListActionController)
const listActionControllerProvider = ListActionControllerFamily();

/// See also [ListActionController].
class ListActionControllerFamily
    extends Family<AsyncValue<List<BaseActionEntity>>> {
  /// See also [ListActionController].
  const ListActionControllerFamily();

  /// See also [ListActionController].
  ListActionControllerProvider call(
    String channelName,
    int range,
  ) {
    return ListActionControllerProvider(
      channelName,
      range,
    );
  }

  @override
  ListActionControllerProvider getProviderOverride(
    covariant ListActionControllerProvider provider,
  ) {
    return call(
      provider.channelName,
      provider.range,
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
  String? get name => r'listActionControllerProvider';
}

/// See also [ListActionController].
class ListActionControllerProvider
    extends AutoDisposeStreamNotifierProviderImpl<ListActionController,
        List<BaseActionEntity>> {
  /// See also [ListActionController].
  ListActionControllerProvider(
    String channelName,
    int range,
  ) : this._internal(
          () => ListActionController()
            ..channelName = channelName
            ..range = range,
          from: listActionControllerProvider,
          name: r'listActionControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listActionControllerHash,
          dependencies: ListActionControllerFamily._dependencies,
          allTransitiveDependencies:
              ListActionControllerFamily._allTransitiveDependencies,
          channelName: channelName,
          range: range,
        );

  ListActionControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.channelName,
    required this.range,
  }) : super.internal();

  final String channelName;
  final int range;

  @override
  Stream<List<BaseActionEntity>> runNotifierBuild(
    covariant ListActionController notifier,
  ) {
    return notifier.build(
      channelName,
      range,
    );
  }

  @override
  Override overrideWith(ListActionController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListActionControllerProvider._internal(
        () => create()
          ..channelName = channelName
          ..range = range,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        channelName: channelName,
        range: range,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<ListActionController,
      List<BaseActionEntity>> createElement() {
    return _ListActionControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListActionControllerProvider &&
        other.channelName == channelName &&
        other.range == range;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelName.hashCode);
    hash = _SystemHash.combine(hash, range.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListActionControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<BaseActionEntity>> {
  /// The parameter `channelName` of this provider.
  String get channelName;

  /// The parameter `range` of this provider.
  int get range;
}

class _ListActionControllerProviderElement
    extends AutoDisposeStreamNotifierProviderElement<ListActionController,
        List<BaseActionEntity>> with ListActionControllerRef {
  _ListActionControllerProviderElement(super.provider);

  @override
  String get channelName =>
      (origin as ListActionControllerProvider).channelName;
  @override
  int get range => (origin as ListActionControllerProvider).range;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
