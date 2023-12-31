import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/live_stream/domain/blocked_user_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/controller/blacklist_controller.dart';
import 'package:test_agora/app/shared/enum/block_type.dart';


class BlockedUserCard extends ConsumerWidget {
  final BlockedUserEntity blockedUserEntity;
  final String channelName;

  const BlockedUserCard(
      {super.key, required this.channelName, required this.blockedUserEntity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(blockedUserEntity.userName),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(blockedTextByType(blockedUserEntity.blockType!)),
        IconButton(
            onPressed: () => _showBlockUserOption(context: context, ref: ref),
            icon: const Icon(Icons.more_vert))
      ]),
    );
  }

  void _showBlockUserOption(
      {required BuildContext context, required WidgetRef ref}) {
    // void blockUser()) {
    //   ref
    //       .read(listUserControllerProvider(channelName).notifier)
    //       .blockUserFromChannel(blockedUserEntity: blockedUserEntity);
    //   context.pop();
    // }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Block option with ${blockedUserEntity.userName}"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: deviceSize.height * 0.1,
                child: Column(
                  children: [
                    // InkWell(
                    //   onTap: () => blockUser(
                    //       blockType: BlockType.blockCommentFromChannel),
                    //   child: const ListTile(
                    //     title: Text("Block comment"),
                    //     subtitle: Text("This user will not be able to comment"),
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () =>
                    //       blockUser(blockType: BlockType.blockFromChannel),
                    //   child: const ListTile(
                    //     title: Text("Block from livestream"),
                    //     subtitle: Text(
                    //         "This user will be kicked and cannot rejoin this livestream"),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        ref
                            .read(blacklistControllerProvider(channelName)
                                .notifier)
                            .unblockUser(blockedUserEntity: blockedUserEntity);
                        context.pop();
                      },
                      child: const ListTile(
                        title: Text("Unblock"),
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

String blockedTextByType(BlockType blockType) {
  switch (blockType) {
    case BlockType.forever:
      return "Forever";
    case BlockType.blockFromChannel:
      return "Block Join";
    case BlockType.blockCommentFromChannel:
      return "Block Comment";
  }
}
