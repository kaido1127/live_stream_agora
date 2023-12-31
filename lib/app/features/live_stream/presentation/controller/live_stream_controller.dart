// ignore_for_file: use_build_context_synchronously

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_agora/app/features/auth/domain/user_entity.dart';
import 'package:test_agora/app/features/live_stream/data/repository/live_stream_repository_provider.dart';
import 'package:test_agora/app/features/live_stream/domain/blocked_user_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/call_button_state_controller.dart';
import 'package:test_agora/app/shared/enum/block_type.dart';
import 'package:test_agora/app/shared/enum/call_button_type.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';
import 'package:test_agora/app/shared/model/invitation.dart';

import 'local_user_in_channel_controller.dart';

part 'live_stream_controller.g.dart';

const String appId = "01c3f88275ac4c69b6d950a200c43e2e";

const String tempToken =
    "007eJxTYLj1wPPqfbfTLje0Lc/Ozfz4x81Ib8bhqKDQi48m/Ymd/KFbgcHAMNk4zcLCyNw0Mdkk2cwyySzF0tQg0cjAINnEONUodZlCX2pDICNDftk9FkYGCATxORjySsriS1KLSxgYANCXJCY=";

@riverpod
class LiveStreamController extends _$LiveStreamController {
  @override
  Future<RtcEngine> build() async {
    late RtcEngine agoraEngine;

    agoraEngine = createAgoraRtcEngine();

    print("[Live Stream] create agoraEngine");
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    await agoraEngine.enableVideo();

    agoraEngine.registerEventHandler(RtcEngineEventHandler(
      onUserMuteVideo: (RtcConnection connection, int remoteUid, bool muted) {
        ref
            .watch(callButtonStateControllerProvider(
                (remoteUid, CallButtonType.toggleCamera)).notifier)
            .state = !muted;
      },

      onUserMuteAudio: (RtcConnection connection, int remoteUid, bool muted) {
        ref
            .watch(callButtonStateControllerProvider(
                (remoteUid, CallButtonType.toggleMic)).notifier)
            .state = !muted;
      },
      //onRemoteAudioStats: ,
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        ref
            .read(callButtonStateControllerProvider(
                (remoteUid, CallButtonType.toggleCamera)).notifier)
            .state = !(state.value() == 0);
      },
      onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid,
          RemoteAudioState state, RemoteAudioStateReason reason, int elapsed) {
        ref
            .read(callButtonStateControllerProvider(
                (remoteUid, CallButtonType.toggleMic)).notifier)
            .state = !(state.value() == 0);
      },
    ));

    ref.onDispose(() async {
      await state.value!.stopPreview();
      await state.value!.leaveChannel();
      state.value!.release();
    });

    return agoraEngine;
  }

  Future<void> join(
      {required BuildContext context,
      required LiveStreamRoleType roleType,
      required UserEntity localUser,
      required String channelName}) async {
    print("[StreamController] join with role $roleType");
    late ChannelMediaOptions options;

    //Determine the role of the user who wants to enter the channel
    if (roleType == LiveStreamRoleType.host) {
      options = const ChannelMediaOptions(
        //If user role is host,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
      //ref.read(yourIdProvider.notifier).state = 0;

      //request permission user microphone and camera of user's device
      await [Permission.microphone, Permission.camera].request();

      await state.value!.startPreview();

      //create live stream channel in database
    } else {
      options = const ChannelMediaOptions(
        //set audience role if user isn't host
        clientRoleType: ClientRoleType.clientRoleAudience,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
      //add database with new audience
    }

    int joinTime = DateTime.now().millisecondsSinceEpoch;
    int liveId = joinTime - 1702000000000;

    final BlockedUserEntity? blockedUserEntity = await ref
        .read(liveStreamRepositoryProvider)
        .blockedUserEntityByChannel(
            channelName: channelName, blockedUserId: localUser.id);
    if (blockedUserEntity == null ||
        blockedUserEntity.blockType == BlockType.blockCommentFromChannel) {
          print("[LiveStreamController] Canjoin") ;
      await state.value!.joinChannel(
          token: tempToken,
          channelId: channelName,
          uid: liveId,
          options: options);
      await ref.read(liveStreamRepositoryProvider).joinStream(
            channelName: channelName,
            userLiveStreamEntity: UserLiveStreamEntity(
                email: localUser.email,
                liveId: liveId,
                joinTime: joinTime,
                id: localUser.id,
                image: localUser.image,
                name: localUser.name,
                roleType: roleType),
          );
      context.push("/live_stream", extra: channelName);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Text("You was blocked by host of this livestream"),
            );
          });
    }
  }

  Future<void> leave({required String channelName}) async {
    if (state.hasValue) {
      print("[LeaveStream]");
      await state.value!.stopPreview();
      await state.value!.leaveChannel();
      state.value!.release();
      await ref.read(liveStreamRepositoryProvider).leaveStream(
          channelName: channelName,
          user: ref
              .read(localUserInChannelControllerProvider(channelName))
              .value!);
    }
  }

  Future<void> setNewRole(
      {required LiveStreamRoleType newRole,
      InvitationType? invitationType,
      required String channelName}) async {
    final ClientRoleType newClientRoleType =
        (newRole == LiveStreamRoleType.audience)
            ? ClientRoleType.clientRoleAudience
            : ClientRoleType.clientRoleBroadcaster;
    await state.value!.setClientRole(role: newClientRoleType);
    print("[LiveStreamController] newRole $newClientRoleType");
    print("[LiveStreamController InviteType $invitationType]");
    final UserLiveStreamEntity? localUser =
        ref.read(localUserInChannelControllerProvider(channelName)).value;
    if (newRole == LiveStreamRoleType.broadcaster &&
        invitationType != null &&
        localUser != null) {
      switch (invitationType) {
        case InvitationType.onMic:
          // onMic only allows users to use the mic so we'll disable their camera from the channel and change state of their camera is off
          await state.value!.muteLocalVideoStream(true);
          ref
              .watch(callButtonStateControllerProvider(
                  (localUser.liveId, CallButtonType.toggleCamera)).notifier)
              .state = false;
          // Request microphone access from device
          await [Permission.microphone].request();
        case InvitationType.onCamera:
          // onCamera only allows users to use the camera so we'll disable their microphone from the channel and change state of their microphone is off
          await state.value!.muteLocalAudioStream(true);
          ref
              .watch(callButtonStateControllerProvider(
                  (localUser.liveId, CallButtonType.toggleMic)).notifier)
              .state = false;
          // Request camera access from device
          await [Permission.camera].request();
        case InvitationType.onCameraAndMic:
          // onCamera allows users to use both the camera and microphone
          await [Permission.microphone, Permission.camera].request();
      }
    } else if (newRole == LiveStreamRoleType.audience) {
      // if role is audience, mute both the video and the audio of user
      await state.value!.muteLocalVideoStream(true);
      await state.value!.muteLocalAudioStream(true);
    }
  }
}
