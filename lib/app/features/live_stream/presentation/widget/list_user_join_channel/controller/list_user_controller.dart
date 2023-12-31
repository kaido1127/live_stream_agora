import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_agora/app/features/live_stream/data/repository/live_stream_repository_provider.dart';
import 'package:test_agora/app/features/live_stream/domain/blocked_user_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/donate_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/live_stream_controller.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/local_user_in_channel_controller.dart';
import 'package:test_agora/app/shared/enum/block_type.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';
import 'package:test_agora/app/shared/model/invitation.dart';

part 'list_user_controller.g.dart';

@riverpod
class ListUserController extends _$ListUserController {
  // return stream channelEntity object by channelName from repository
  @override
  Stream<List<UserLiveStreamEntity>> build(String channelName) {
    return ref
        .watch(liveStreamRepositoryProvider)
        .getListUser(channelName: channelName);
  }

  Future<void> sendInvitation(
      {required UserLiveStreamEntity userInvited,
      required Invitation? invitation}) async {
    await ref.read(liveStreamRepositoryProvider).sendInvitation(
        userInvited: userInvited,
        channelName: channelName,
        invitation: invitation);
  }

  /* replyInvitation
  * If user agrees to the invitation, set their role to broadcaster
  * Response invitation with function of repository
   */
  Future<void> replyInvitation(
      {required UserLiveStreamEntity userInvited,
      required Invitation invitation}) async {
    if (invitation.isAccept == true) {
      ref.read(liveStreamControllerProvider.notifier).setNewRole(
          newRole: LiveStreamRoleType.broadcaster,
          invitationType: invitation.type,
          channelName: channelName);
    }
    await ref.read(liveStreamRepositoryProvider).replyInvitation(
        userInvited: userInvited, channelName: channelName, reply: invitation);
  }

  //Permission for only host, host will changeRole of user of channel and update it in database
  Future<void> changeRole(
      {required UserLiveStreamEntity user,
      required LiveStreamRoleType newRole}) async {
    ref.read(liveStreamRepositoryProvider).changeRemoteUserRole(
        userLiveStreamEntity: user, newRole: newRole, channelName: channelName);
  }

  Future<void> sendGift(
      {required UserLiveStreamEntity giver, required giftItemEntity}) async {
    ref.read(liveStreamRepositoryProvider).sendGift(
        channelName: channelName,
        donateEntity: DonateEntity(
            giftItem: giftItemEntity,
            giverName: giver.name,
            giverId: giver.id));
  }

  Future<void> blockUserFromChannel(
      {required BlockedUserEntity blockedUserEntity}) async {
    ref.read(liveStreamRepositoryProvider).blockUserFromChannel(
        channelName: channelName, blockedUser: blockedUserEntity);
    if (blockedUserEntity.blockType == BlockType.forever) {
      final String localUserId =
          ref.read(localUserInChannelControllerProvider(channelName)).value!.id;
      ref.read(liveStreamRepositoryProvider).blockUser(
          blockerId: localUserId, blockedUserEntity: blockedUserEntity);
    }
  }
}
