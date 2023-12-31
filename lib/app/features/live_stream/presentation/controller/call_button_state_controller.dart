import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/live_stream_controller.dart';
import 'package:test_agora/app/shared/enum/call_button_type.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';

part 'call_button_state_controller.g.dart';

@riverpod
class CallButtonStateController extends _$CallButtonStateController {
  //Return the button status of each broadcaster
  //true is on state and false is off state
  @override
  bool build((int, CallButtonType) userIdAndButtonType) {
    return true;
  }

  Future<void> callButtonFunctionFromType(
      {required RtcEngine agoraEngine,
      required BuildContext context,
      required LiveStreamRoleType roleType,
      required String channelName}) async {
    switch (userIdAndButtonType.$2) {
      case CallButtonType.callEnd:
        ref
            .read(liveStreamControllerProvider.notifier)
            .leave(channelName: channelName);
        context.go('/home_page');
      case CallButtonType.switchCamera:
        await agoraEngine.switchCamera();
      case CallButtonType.toggleCamera:
        await agoraEngine.muteLocalVideoStream(state);
      case CallButtonType.toggleMic:
        await agoraEngine.muteLocalAudioStream(state);
    }
    state = !state;
  }
}
