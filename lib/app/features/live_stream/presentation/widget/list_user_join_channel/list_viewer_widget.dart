import 'package:flutter/material.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/viewer_card.dart';

class ListViewerWidget extends StatelessWidget {
  final String channelName;
  final List<UserLiveStreamEntity> listViewer;
  const ListViewerWidget(
      {super.key, required this.channelName, required this.listViewer});

  @override
  Widget build(BuildContext context) {
    return listViewer.isEmpty
        ? const Center(
            child: Text("List viewer is empty"),
          )
        : ListView.builder(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            itemBuilder: (context, index) {
              final UserLiveStreamEntity user = listViewer[index];
              return ViewerCard(channelName: channelName, user: user);
            },
            itemCount: listViewer.length,
          );
  }
}
