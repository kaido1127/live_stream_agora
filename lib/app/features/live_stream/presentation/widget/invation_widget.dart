import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/controller/list_user_controller.dart';
import 'package:test_agora/app/shared/model/invitation.dart';

class InvitationWidget extends ConsumerWidget {
  final UserLiveStreamEntity localUser;
  final String channelName;

  const InvitationWidget(
      {super.key, required this.channelName, required this.localUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return (localUser.invitation == null ||
            (localUser.invitation != null &&
                localUser.invitation?.isAccept != null))
        ? const SizedBox()
        : AlertDialog(
            title: Text('Join livestream $channelName as a broadcaster now'),
            content: Text(
                'The host allows you to turn on ${broadcasterPermission(invitationType: localUser.invitation!.type)}'),
            actions: [
              TextButton(
                  onPressed: () {
                    ref
                        .read(listUserControllerProvider(channelName).notifier)
                        .replyInvitation(
                            userInvited: localUser,
                            invitation: Invitation(
                                type: (localUser.invitation == null)
                                    ? InvitationType.onMic
                                    : localUser.invitation!.type,
                                isAccept: false));
                  },
                  child: const Text("Rejected")),
              TextButton(
                  onPressed: () {
                    ref
                        .read(listUserControllerProvider(channelName).notifier)
                        .replyInvitation(
                            userInvited: localUser,
                            invitation: Invitation(
                                type: (localUser.invitation == null)
                                    ? InvitationType.onMic
                                    : localUser.invitation!.type,
                                isAccept: true));
                  },
                  child: const Text("Accept")),
            ],
          );
  }
}
