import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/call_button_state_controller.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/live_stream_controller.dart';
import 'package:test_agora/app/shared/enum/call_button_type.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';
import 'package:test_agora/app/shared/model/invitation.dart';
import 'package:test_agora/app/shared/widget/base/base_call_button.dart';

class ListCallButtonWidget extends ConsumerStatefulWidget {
  final UserLiveStreamEntity localUser;
  final String channelName;

  const ListCallButtonWidget(
      {super.key, required this.channelName, required this.localUser});

  @override
  ConsumerState<ListCallButtonWidget> createState() =>
      _ListCallButtonWidgetState();
}

class _ListCallButtonWidgetState extends ConsumerState<ListCallButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return _listCallButtonByRole(roleType: widget.localUser.roleType);
  }

  Widget _listCallButtonByRole({required LiveStreamRoleType? roleType}) {
    switch (roleType) {
      case LiveStreamRoleType.audience:
        return _listCallButtonWidget(listButton: [CallButtonType.callEnd]);
      case LiveStreamRoleType.broadcaster:
        final InvitationType? invitationType =
            (widget.localUser.invitation == null)
                ? null
                : (widget.localUser.invitation?.type);
        return _listCallButtonBroadcasterByInvitationType(invitationType);
      case LiveStreamRoleType.host:
        return _listCallButtonWidget(listButton: CallButtonType.values);
      case null:
        return _listCallButtonWidget(listButton: [CallButtonType.callEnd]);
    }
  }

  Widget _listCallButtonWidget({required List<CallButtonType> listButton}) {
    return (listButton.isNotEmpty)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listButton
                .map((buttonType) =>
                    _callButtonWidget(buttonType, widget.channelName))
                .toList())
        : _callButtonWidget(CallButtonType.callEnd, widget.channelName);
  }

  Widget _listCallButtonBroadcasterByInvitationType(InvitationType? type) {
    switch (type) {
      case InvitationType.onMic:
        return _listCallButtonWidget(
            listButton: [CallButtonType.callEnd, CallButtonType.toggleMic]);
      case InvitationType.onCamera:
        return _listCallButtonWidget(listButton: [
          CallButtonType.switchCamera,
          CallButtonType.callEnd,
          CallButtonType.toggleCamera
        ]);
      case InvitationType.onCameraAndMic:
        return _listCallButtonWidget(listButton: CallButtonType.values);
      case null:
        return _listCallButtonWidget(listButton: [CallButtonType.callEnd]);
    }
  }

  Widget _callButtonWidget(CallButtonType buttonType, String channelName) {
    final LiveStreamRoleType roleType =
        widget.localUser.roleType ?? LiveStreamRoleType.audience;
    final int localUserJoinId = widget.localUser.liveId;
    final bool isOn = ref.watch(
        callButtonStateControllerProvider((localUserJoinId, buttonType)));
    final RtcEngine agoraEngine =
        ref.watch(liveStreamControllerProvider).value ?? createAgoraRtcEngine();
    switch (buttonType) {
      case CallButtonType.callEnd:
        return IconButton(
            onPressed: () => ref
                .read(callButtonStateControllerProvider(
                    (localUserJoinId, buttonType)).notifier)
                .callButtonFunctionFromType(
                    agoraEngine: agoraEngine,
                    context: context,
                    roleType: roleType,
                    channelName: channelName),
            icon: CircleAvatar(
              backgroundColor: Colors.red,
              radius: deviceSize.width * 0.1,
              child: const Icon(
                Icons.call_end,
                size: 40,
                color: Colors.white,
              ),
            ));
      case CallButtonType.switchCamera:
        return BaseCallIconButton(
            function: () => ref
                .read(callButtonStateControllerProvider(
                    (localUserJoinId, buttonType)).notifier)
                .callButtonFunctionFromType(
                    agoraEngine: agoraEngine,
                    context: context,
                    roleType: roleType,
                    channelName: channelName),
            icon: Icons.switch_camera,
            isOn: isOn);
      case CallButtonType.toggleCamera:
        return BaseCallIconButton(
            function: () => ref
                .read(callButtonStateControllerProvider(
                    (localUserJoinId, buttonType)).notifier)
                .callButtonFunctionFromType(
                    agoraEngine: agoraEngine,
                    context: context,
                    roleType: roleType,
                    channelName: channelName),
            icon: ref.watch(callButtonStateControllerProvider(
                    (localUserJoinId, buttonType)))
                ? Icons.videocam
                : Icons.videocam_off,
            isOn: isOn);
      case CallButtonType.toggleMic:
        return BaseCallIconButton(
            function: () => ref
                .read(callButtonStateControllerProvider(
                    (localUserJoinId, buttonType)).notifier)
                .callButtonFunctionFromType(
                    agoraEngine: agoraEngine,
                    context: context,
                    roleType: roleType,
                    channelName: channelName),
            icon: ref.watch(callButtonStateControllerProvider(
                    (localUserJoinId, buttonType)))
                ? Icons.mic
                : Icons.mic_off,
            isOn: isOn);
    }
  }
}
