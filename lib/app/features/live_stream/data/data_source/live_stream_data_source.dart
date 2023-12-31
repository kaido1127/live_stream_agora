import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_agora/app/features/live_stream/data/model/action_model.dart';
import 'package:test_agora/app/features/live_stream/data/model/blocked_user_model.dart';
import 'package:test_agora/app/features/live_stream/data/model/channel_model.dart';
import 'package:test_agora/app/features/live_stream/data/model/donate_model.dart';
import 'package:test_agora/app/features/live_stream/data/model/user_live_stream_model.dart';
import 'package:test_agora/app/features/live_stream/domain/action_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/gift_item.dart';
import 'package:test_agora/app/shared/enum/block_type.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';
import 'package:test_agora/app/shared/model/invitation.dart';

part 'live_stream_data_source_impl.dart';

abstract interface class LiveStreamDataSource {
  Future<void> leaveStream(
      {required UserLiveStreamModel user, required String channelName});

  Future<void> joinStream(
      {required UserLiveStreamModel userLiveStreamModel,
      required String channelName});

  Future<void> changeRemoteUserRole(
      {required UserLiveStreamModel userLiveStreamModel,
      required LiveStreamRoleType newRole,
      required String channelName});

  Future<void> replyInvitation(
      {required UserLiveStreamModel userInvited,
      required String channelName,
      required Invitation reply});

  Future<void> sendInvitation(
      {required UserLiveStreamModel userInvited,
      required String channelName,
      required Invitation? invitation});

  Future<void> blockUser(
      {required String blockerId, required BlockedUserModel blockedUser});

  Future<void> blockUserFromChannel(
      {required String channelName, required BlockedUserModel blockedUser});

  Future<BlockedUserModel?> blockedUserModelByChannel(
      {required String channelName, required String blockedUserId});

  Future<void> unblockUser(
      {required String blockerId, required String blockedUserId});
  Future<void> unblockUserFromChannel(
      {required String blockedUserId, required String channelName});

  Stream<List<UserLiveStreamModel>> getListUser({required String channelName});
  Stream<UserLiveStreamModel?> getLocalUser(
      {required String localUserId, required String channelName});
  Future<void> sendGift(
      {required String channelName, required DonateModel donateModel});
  Stream<List<DonateModel>> getListDonateOrderByCoin(
      {required String channelName});
  Stream<List<ActionModel>> getTailOfListAction(
      {required String channelName, required int range});
  Stream<List<BlockedUserModel>> getBlacklistUserOnLiveStream(
      {required String channelName});

  factory LiveStreamDataSource.create({required FirebaseFirestore firestore}) =>
      _LiveStreamDataSourceImpl(firestore: firestore);
}
