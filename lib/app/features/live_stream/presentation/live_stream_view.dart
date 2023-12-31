import 'package:flutter/material.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';

import 'widget/broadcaster_view/broadcaster_view_widget.dart';

class LiveStreamView extends StatefulWidget {
  final String channelName;
  final UserLiveStreamEntity localUser;
  final List<UserLiveStreamEntity> listBroadcaster;

  const LiveStreamView(
      {super.key,
      required this.listBroadcaster,
      required this.localUser,
      required this.channelName});

  @override
  State<LiveStreamView> createState() => _LiveStreamViewState();
}

class _LiveStreamViewState extends State<LiveStreamView> {
  @override
  Widget build(BuildContext context) {
    print("[LiveStreamView] ${widget.listBroadcaster.first.id}");
    if (widget.listBroadcaster.isEmpty) {
      return const Text(
        'Waiting for a host to join',
        textAlign: TextAlign.center,
      );
    } else {
      if (widget.listBroadcaster.length == 1) {
        print(
            "[LiveStreamUI] ListView length 1 ${widget.listBroadcaster.length}");
        return BroadcasterViewWidget(
          user: widget.listBroadcaster.first,
          channelName: widget.channelName,
          localUser: widget.localUser,
        );
      } else if (widget.listBroadcaster.length == 2) {
        print("[LiveStreamUI] ListView ${widget.listBroadcaster.length}");
        return Column(
          children: [
            //AgoraVideoViewer(client: client)
            _singleHostViewWidget(1),
            _singleHostViewWidget(0),
          ],
        );
      } else if (widget.listBroadcaster.length > 2 &&
          widget.listBroadcaster.length % 2 == 0) {
        return Column(
          children: [
            for (int i = 0; i < widget.listBroadcaster.length; i += 2)
              _rowHostViewWidget(i)
          ],
        );
      } else {
        return Column(
          children: [
            for (int i = 1; i < widget.listBroadcaster.length; i += 2)
              _rowHostViewWidget(i),
            _singleHostViewWidget(0),
          ],
        );
      }
    }
  }

  Widget _rowHostViewWidget(int i) {
    return Expanded(
        child: Row(
      children: [
        //AgoraVideoViewer(client: client)
        Expanded(
          child: BroadcasterViewWidget(
            user: widget.listBroadcaster[i],
            channelName: widget.channelName,
            localUser: widget.localUser,
          ),
        ),
        Expanded(
          child: BroadcasterViewWidget(
            user: widget.listBroadcaster[i + 1],
            channelName: widget.channelName,
            localUser: widget.localUser,
          ),
        )
      ],
    ));
  }

  Widget _singleHostViewWidget(int i) {
    return Expanded(
      child: BroadcasterViewWidget(
        user: widget.listBroadcaster[i],
        channelName: widget.channelName,
        localUser: widget.localUser,
      ),
    );
  }
}
