// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_donate_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listDonateControllerHash() =>
    r'0939d624961f5b599fd119a32795721c07a42bd6';

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

abstract class _$ListDonateController
    extends BuildlessAutoDisposeStreamNotifier<List<DonateEntity>> {
  late final String channelName;

  Stream<List<DonateEntity>> build(
    String channelName,
  );
}

/// See also [ListDonateController].
@ProviderFor(ListDonateController)
const listDonateControllerProvider = ListDonateControllerFamily();

/// See also [ListDonateController].
class ListDonateControllerFamily
    extends Family<AsyncValue<List<DonateEntity>>> {
  /// See also [ListDonateController].
  const ListDonateControllerFamily();

  /// See also [ListDonateController].
  ListDonateControllerProvider call(
    String channelName,
  ) {
    return ListDonateControllerProvider(
      channelName,
    );
  }

  @override
  ListDonateControllerProvider getProviderOverride(
    covariant ListDonateControllerProvider provider,
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
  String? get name => r'listDonateControllerProvider';
}

/// See also [ListDonateController].
class ListDonateControllerProvider
    extends AutoDisposeStreamNotifierProviderImpl<ListDonateController,
        List<DonateEntity>> {
  /// See also [ListDonateController].
  ListDonateControllerProvider(
    String channelName,
  ) : this._internal(
          () => ListDonateController()..channelName = channelName,
          from: listDonateControllerProvider,
          name: r'listDonateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listDonateControllerHash,
          dependencies: ListDonateControllerFamily._dependencies,
          allTransitiveDependencies:
              ListDonateControllerFamily._allTransitiveDependencies,
          channelName: channelName,
        );

  ListDonateControllerProvider._internal(
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
  Stream<List<DonateEntity>> runNotifierBuild(
    covariant ListDonateController notifier,
  ) {
    return notifier.build(
      channelName,
    );
  }

  @override
  Override overrideWith(ListDonateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ListDonateControllerProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<ListDonateController,
      List<DonateEntity>> createElement() {
    return _ListDonateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListDonateControllerProvider &&
        other.channelName == channelName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, channelName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListDonateControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<DonateEntity>> {
  /// The parameter `channelName` of this provider.
  String get channelName;
}

class _ListDonateControllerProviderElement
    extends AutoDisposeStreamNotifierProviderElement<ListDonateController,
        List<DonateEntity>> with ListDonateControllerRef {
  _ListDonateControllerProviderElement(super.provider);

  @override
  String get channelName =>
      (origin as ListDonateControllerProvider).channelName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
