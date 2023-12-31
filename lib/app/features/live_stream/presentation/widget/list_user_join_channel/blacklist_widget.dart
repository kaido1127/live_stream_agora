import 'package:flutter/material.dart';
import 'package:test_agora/app/features/live_stream/domain/blocked_user_entity.dart';

import 'blocked_user_card.dart';

class BlacklistWidget extends StatelessWidget {
  final String channelName;
  final List<BlockedUserEntity> blacklist;
  const BlacklistWidget(
      {super.key, required this.channelName, required this.blacklist});

  @override
  Widget build(BuildContext context) {
    return blacklist.isEmpty
        ? const Center(
            child: Text("Blacklist is empty"),
          )
        : ListView.builder(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            itemBuilder: (context, index) {
              final BlockedUserEntity blockedUserEntity = blacklist[index];
              return BlockedUserCard(
                  channelName: channelName,
                  blockedUserEntity: blockedUserEntity);
            },
            itemCount: blacklist.length,
          );
  }
}
