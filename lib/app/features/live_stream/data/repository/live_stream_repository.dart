import 'package:test_agora/app/features/live_stream/data/data_source/live_stream_data_source.dart';
import 'package:test_agora/app/features/live_stream/data/model/blocked_user_model.dart';
import 'package:test_agora/app/features/live_stream/data/model/donate_model.dart';
import 'package:test_agora/app/features/live_stream/domain/action_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/blocked_user_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/donate_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/gift_item.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/shared/enum/block_type.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';
import 'package:test_agora/app/shared/model/invitation.dart';

part 'live_stream_repository_impl.dart';

abstract interface class LiveStreamRepository {
  Future<void> leaveStream(
      {required UserLiveStreamEntity user, required String channelName});

  Future<void> joinStream(
      {required UserLiveStreamEntity userLiveStreamEntity,
      required String channelName});

  Future<void> changeRemoteUserRole(
      {required UserLiveStreamEntity userLiveStreamEntity,
      required LiveStreamRoleType newRole,
      required String channelName});

  Future<void> sendInvitation(
      {required UserLiveStreamEntity userInvited,
      required String channelName,
      required Invitation? invitation});

  Future<void> replyInvitation(
      {required UserLiveStreamEntity userInvited,
      required String channelName,
      required Invitation reply});

  Future<void> sendGift(
      {required String channelName, required DonateEntity donateEntity});

  Future<void> blockUser(
      {required String blockerId,
      required BlockedUserEntity blockedUserEntity});

  Future<void> blockUserFromChannel(
      {required String channelName, required BlockedUserEntity blockedUser});
  Future<BlockedUserEntity?> blockedUserEntityByChannel(
      {required String channelName, required String blockedUserId});

  Future<void> unblockUser(
      {required String blockerId, required String blockedUserId});
  Future<void> unblockUserFromChannel(
      {required String blockedUserId, required String channelName});

  Stream<List<UserLiveStreamEntity>> getListUser({required String channelName});

  Stream<UserLiveStreamEntity?> getLocalUser(
      {required String localUserId, required String channelName});

  Stream<List<DonateEntity>> getListDonateOrderByCoin(
      {required String channelName});

  Stream<List<BaseActionEntity>> getTailOfListAction(
      {required String channelName, required int range});

  Stream<List<BlockedUserEntity>> getBlacklistUserOnLiveStream(
      {required String channelName});

  factory LiveStreamRepository.create(
          {required LiveStreamDataSource dataSource}) =>
      _LiveStreamRepositoryImpl(dataSource: dataSource);
}
