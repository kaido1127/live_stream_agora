import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/blacklist_widget.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/controller/blacklist_controller.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/list_viewer_widget.dart';

class ListUserJoinedChannelWidget extends ConsumerStatefulWidget {
  final String channelName;
  final List<UserLiveStreamEntity> listViewer;
  final bool isHost;

  const ListUserJoinedChannelWidget(
      {super.key,
      required this.channelName,
      required this.listViewer,
      required this.isHost});

  @override
  ConsumerState<ListUserJoinedChannelWidget> createState() =>
      _ListUserJoinedChannelWidgetState();
}

class _ListUserJoinedChannelWidgetState
    extends ConsumerState<ListUserJoinedChannelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Colors.white),
        width: deviceSize.width,
        height: deviceSize.height * 0.6,
        child: DefaultTabController(
          length: widget.isHost ? 2 : 1,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(tabs: [
                const Tab(
                  text: "Viewer",
                  icon: Icon(Icons.remove_red_eye),
                ),
                if (widget.isHost)
                  const Tab(
                    text: "Blocked",
                    icon: Icon(Icons.block),
                  )
              ]),
              Expanded(
                flex: 2,
                child: TabBarView(children: [
                  ListViewerWidget(
                      channelName: widget.channelName,
                      listViewer: widget.listViewer),
                  if (widget.isHost)
                    ref
                        .watch(blacklistControllerProvider(widget.channelName))
                        .when(
                            data: (blacklist) {
                              return BlacklistWidget(
                                  channelName: widget.channelName,
                                  blacklist: blacklist);
                            },
                            error: (e, st) => Center(
                                  child: Text(e.toString()),
                                ),
                            loading: () => const Center(
                                  child: CircularProgressIndicator(),
                                ))
                ]),
              )
            ],
          ),
        ));
  }
}
