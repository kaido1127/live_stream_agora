part of 'live_stream_repository.dart';

class _LiveStreamRepositoryImpl implements LiveStreamRepository {
  final LiveStreamDataSource _dataSource;

  _LiveStreamRepositoryImpl({required LiveStreamDataSource dataSource})
      : _dataSource = dataSource;

  @override
  Future<void> joinStream(
      {required UserLiveStreamEntity userLiveStreamEntity,
      required String channelName}) async {
    _dataSource.joinStream(
        userLiveStreamModel: userLiveStreamEntity.toModel(),
        channelName: "ntv_test");
  }

  @override
  Future<void> leaveStream(
      {required UserLiveStreamEntity user, required String channelName}) async {
    _dataSource.leaveStream(user: user.toModel(), channelName: channelName);
  }

  @override
  Stream<List<UserLiveStreamEntity>> getListUser(
      {required String channelName}) {
    return _dataSource.getListUser(channelName: channelName).map((event) =>
        event
            .map((userModel) => UserLiveStreamEntity.fromModel(userModel))
            .toList());
  }

  @override
  Future<void> changeRemoteUserRole(
      {required UserLiveStreamEntity userLiveStreamEntity,
      required LiveStreamRoleType newRole,
      required String channelName}) async {
    _dataSource.changeRemoteUserRole(
        userLiveStreamModel: userLiveStreamEntity.toModel(),
        newRole: newRole,
        channelName: channelName);
  }

  @override
  Future<void> replyInvitation(
      {required UserLiveStreamEntity userInvited,
      required String channelName,
      required Invitation reply}) async {
    _dataSource.replyInvitation(
        userInvited: userInvited.toModel(),
        channelName: channelName,
        reply: reply);
  }

  @override
  Future<void> sendInvitation(
      {required UserLiveStreamEntity userInvited,
      required String channelName,
      required Invitation? invitation}) async {
    _dataSource.sendInvitation(
        userInvited: userInvited.toModel(),
        channelName: channelName,
        invitation: invitation);
  }

  @override
  Stream<UserLiveStreamEntity?> getLocalUser(
      {required String localUserId, required String channelName}) {
    return _dataSource
        .getLocalUser(localUserId: localUserId, channelName: channelName)
        .map((event) =>
            event == null ? null : UserLiveStreamEntity.fromModel(event));
  }

  @override
  Future<void> sendGift(
      {required String channelName, required DonateEntity donateEntity}) async {
    await _dataSource.sendGift(
        channelName: channelName,
        donateModel: DonateModel(
            name: donateEntity.giftItem.name,
            coin: donateEntity.giftItem.coin,
            giverId: donateEntity.giverId,
            giverName: donateEntity.giverName,
            donateAt: DateTime.now().microsecondsSinceEpoch,
            valueLevel: donateEntity.giftItem.valueLevel));
  }

  @override
  Future<void> blockUser(
      {required String blockerId,
      required BlockedUserEntity blockedUserEntity}) async {
    try {
      await _dataSource.blockUser(
        blockerId: blockerId,
        blockedUser: blockedUserEntity.toModel(),
      );
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> blockUserFromChannel(
      {required String channelName,
      required BlockedUserEntity blockedUser}) async {
    try {
      await _dataSource.blockUserFromChannel(
          channelName: channelName, blockedUser: blockedUser.toModel());
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<BlockedUserEntity?> blockedUserEntityByChannel(
      {required String channelName, required String blockedUserId}) async {
    try {
      final BlockedUserModel? blockedUserModel =
          await _dataSource.blockedUserModelByChannel(
              channelName: channelName, blockedUserId: blockedUserId);
      if (blockedUserModel == null) {
        return null;
      } else {
        return BlockedUserEntity.fromModel(blockedUserModel);
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  @override
  Stream<List<DonateEntity>> getListDonateOrderByCoin(
      {required String channelName}) {
    return _dataSource.getListDonateOrderByCoin(channelName: channelName).map(
        (list) => list
            .map((donateModel) => DonateEntity(
                giftItem: GiftItem(
                    name: donateModel.name,
                    coin: donateModel.coin,
                    valueLevel: donateModel.valueLevel),
                giverName: donateModel.giverName,
                giverId: donateModel.giverId))
            .toList());
  }

  @override
  Stream<List<BaseActionEntity>> getTailOfListAction(
      {required String channelName, required int range}) {
    return _dataSource
        .getTailOfListAction(channelName: channelName, range: range)
        .map((listActionModel) => listActionModel
            .map((actionModel) => BaseActionEntity.fromActionModel(actionModel))
            .toList());
  }

  @override
  Stream<List<BlockedUserEntity>> getBlacklistUserOnLiveStream(
      {required String channelName}) {
    return _dataSource
        .getBlacklistUserOnLiveStream(channelName: channelName)
        .map((blackList) => blackList
            .map((blockedUser) => BlockedUserEntity.fromModel(blockedUser))
            .toList());
  }

  @override
  Future<void> unblockUser(
      {required String blockerId, required String blockedUserId}) async {
    _dataSource.unblockUser(blockerId: blockerId, blockedUserId: blockedUserId);
  }

  @override
  Future<void> unblockUserFromChannel(
      {required String blockedUserId, required String channelName}) async {
    _dataSource.unblockUserFromChannel(
        blockedUserId: blockedUserId, channelName: channelName);
  }
}
