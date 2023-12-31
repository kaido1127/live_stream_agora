import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/live_stream/domain/blocked_user_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/controller/list_user_controller.dart';
import 'package:test_agora/app/shared/enum/block_type.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';
import 'package:test_agora/app/shared/model/invitation.dart';

import '../../controller/local_user_in_channel_controller.dart';

class ViewerCard extends ConsumerWidget {
  final UserLiveStreamEntity user;
  final String channelName;

  const ViewerCard({super.key, required this.channelName, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LiveStreamRoleType localUserRoleType = ref
            .watch(localUserInChannelControllerProvider(channelName))
            .value!
            .roleType ??
        LiveStreamRoleType.audience;
    return ListTile(
      leading: CircleAvatar(
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: user.image ??
              "https://cdn.icon-icons.com/icons2/1161/PNG/512/1487716859-user-comment_81638.png",
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.person),
        ),
      ),
      title: Text(user.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          trailingWidgetFromUserRole(
              roleType: user.roleType ?? LiveStreamRoleType.audience,
              localUserRoleType: localUserRoleType,
              ref: ref,
              context: context),
          if (localUserRoleType == LiveStreamRoleType.host &&
              user.roleType != LiveStreamRoleType.host) ...[
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () => _showBlockUserOption(
                    context: context, ref: ref, user: user),
                icon: const Icon(
                  Icons.block,
                ))
          ]
        ],
      ),
    );
  }

  Widget trailingWidgetFromUserRole(
      {required LiveStreamRoleType roleType,
      required LiveStreamRoleType localUserRoleType,
      required WidgetRef ref,
      required BuildContext context}) {
    //final bool isLocalUser =
    //  (user.id == ref.watch(localUserInChannelControllerProvider(channelName)).value!.id);

    switch (roleType) {
      case LiveStreamRoleType.host:
        return const Text("Room owner");
      case LiveStreamRoleType.broadcaster:
        if (localUserRoleType != LiveStreamRoleType.host) {
          return const Text("Broadcaster");
        } else {
          return TextButton(
              onPressed: () {
                ref
                    .read(listUserControllerProvider(channelName).notifier)
                    .sendInvitation(userInvited: user, invitation: null);
              },
              child: const Text("Stop this broadcaster"));
        }
      case LiveStreamRoleType.audience:
        if (localUserRoleType != LiveStreamRoleType.host) {
          return const Text("");
        } else {
          // if you are host
          if (user.invitation == null) {
            // if this user don't have invitation
            return TextButton(
                onPressed: () => _showSelectBroadcasterPermission(
                    context: context, ref: ref),
                child: const Text("Invite"));
          } else {
            if (user.invitation!.isAccept == null) {
              return TextButton(
                  onPressed: () => _showSelectBroadcasterPermission(
                      context: context, ref: ref),
                  child: const Text("Invited, invite again"));
            } else {
              return TextButton(
                  onPressed: () => _showSelectBroadcasterPermission(
                      context: context, ref: ref),
                  child: const Text("Rejected, invite again"));
            }
          }
        }
    }
  }

  void _showSelectBroadcasterPermission(
      {required BuildContext context, required WidgetRef ref}) {
    void sendInvitationWithType({required InvitationType type}) {
      ref.read(listUserControllerProvider(channelName).notifier).sendInvitation(
          userInvited: user,
          invitation: Invitation(type: type, isAccept: null));
      context.pop();
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Permission for ${user.name}"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: deviceSize.height * 0.3,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () =>
                          sendInvitationWithType(type: InvitationType.onMic),
                      child: const ListTile(
                        title: Text("Microphone"),
                        subtitle: Text("Only Microphone use is allowed"),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          sendInvitationWithType(type: InvitationType.onCamera),
                      child: const ListTile(
                        title: Text("Camera"),
                        subtitle: Text("Only camera use is allowed"),
                      ),
                    ),
                    InkWell(
                      onTap: () => sendInvitationWithType(
                          type: InvitationType.onCameraAndMic),
                      child: const ListTile(
                        title: Text("Both microphone and camera"),
                        subtitle:
                            Text("Permission to use microphone and camera"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => context.pop(), child: const Text('Close'))
            ],
          );
        });
  }

  void _showBlockUserOption(
      {required BuildContext context,
      required WidgetRef ref,
      required UserLiveStreamEntity user}) {
    void blockUser(
        {required BlockType blockType, required UserLiveStreamEntity user}) {
      ref
          .read(listUserControllerProvider(channelName).notifier)
          .blockUserFromChannel(
            blockedUserEntity: BlockedUserEntity(
                id: user.id,
                userName: user.name,
                blockTime: DateTime.now().millisecondsSinceEpoch,
                blockType: blockType),
          );
      context.pop();
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text("Do you want to block ${user.name} from the livestream?"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: deviceSize.height * 0.3,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => blockUser(
                          blockType: BlockType.blockCommentFromChannel,
                          user: user),
                      child: const ListTile(
                        title: Text("Block comment"),
                        subtitle: Text("This user will not be able to comment"),
                      ),
                    ),
                    InkWell(
                      onTap: () => blockUser(
                          blockType: BlockType.blockFromChannel, user: user),
                      child: const ListTile(
                        title: Text("Block from livestream"),
                        subtitle: Text(
                            "This user will be kicked and cannot rejoin this livestream"),
                      ),
                    ),
                    InkWell(
                      onTap: () =>
                          blockUser(blockType: BlockType.forever, user: user),
                      child: const ListTile(
                        title: Text("Block permanently"),
                        subtitle:
                            Text("You and this user will never see each other"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => context.pop(), child: const Text('Close'))
            ],
          );
        });
  }
}
