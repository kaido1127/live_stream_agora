import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/live_stream_controller.dart';
import 'package:test_agora/app/shared/enum/call_button_type.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';

import '../../controller/call_button_state_controller.dart';
import 'broadcaster_audio_turn_off_widget.dart';
import 'broadcaster_video_turn_off_widget.dart';

class BroadcasterViewWidget extends ConsumerStatefulWidget {
  final UserLiveStreamEntity user;
  final UserLiveStreamEntity localUser;
  final String channelName;

  const BroadcasterViewWidget(
      {super.key,
      required this.user,
      required this.channelName,
      required this.localUser});

  @override
  ConsumerState<BroadcasterViewWidget> createState() =>
      _BroadcasterViewWidgetState();
}

class _BroadcasterViewWidgetState extends ConsumerState<BroadcasterViewWidget> {
  @override
  Widget build(BuildContext context) {
    print("[LiveScreenOfUser] UID ${widget.user.id}");
    final bool isTurnOnCamera = ref.watch(callButtonStateControllerProvider(
        (widget.user.liveId, CallButtonType.toggleCamera)));
    final bool isTurnOnMic = ref.watch(callButtonStateControllerProvider(
        (widget.user.liveId, CallButtonType.toggleMic)));
    final bool isMe = (widget.localUser.id == widget.user.id);
    print(
        '[LiveStreamView] build local screen ${(((widget.user.roleType == LiveStreamRoleType.broadcaster) || (widget.user.roleType == LiveStreamRoleType.host)) && isMe)} and turn on camera $isTurnOnCamera');
    return ref.watch(liveStreamControllerProvider).when(
        data: (agoraEngine) {
          return (((widget.user.roleType == LiveStreamRoleType.broadcaster) ||
                      (widget.user.roleType == LiveStreamRoleType.host)) &&
                  isMe)
              ? Stack(
                  children: [
                    if (isTurnOnCamera)
                      AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: agoraEngine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    else
                      const BroadcasterVideoTurnOffWidget(isMe: true),
                    if (!isTurnOnMic)
                      const BroadcasterAudioTurnOffWidget(isMe: true),
                    Positioned(
                        top: 10,
                        left: 10,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(children: [
                                const Icon(Icons.person),
                                Text(widget.user.name),
                              ]),
                            ),
                          ),
                        )),
                  ],
                )
              : Stack(
                  children: [
                    //AgoraVideoViewer(client: client)
                    if (isTurnOnCamera)
                      AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: agoraEngine,
                          canvas: VideoCanvas(uid: widget.user.liveId),
                          connection:
                              RtcConnection(channelId: widget.channelName),
                        ),
                      )
                    else
                      const BroadcasterVideoTurnOffWidget(
                        isMe: false,
                      ),
                    if (!isTurnOnMic)
                      const BroadcasterAudioTurnOffWidget(isMe: false),
                    Positioned(
                        top: 10,
                        left: 10,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(children: [
                                const Icon(Icons.person),
                                Text(widget.user.name),
                              ]),
                            ),
                          ),
                        )),
                  ],
                );
        },
        error: (e, st) => Center(
              child: Text(e.toString()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
