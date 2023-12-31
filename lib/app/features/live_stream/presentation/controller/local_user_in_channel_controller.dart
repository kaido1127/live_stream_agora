import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_agora/app/features/auth/domain/user_entity.dart';
import 'package:test_agora/app/features/auth/presentation/controller/auth_controller.dart';
import 'package:test_agora/app/features/live_stream/data/repository/live_stream_repository_provider.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/live_stream_controller.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';

part 'local_user_in_channel_controller.g.dart';

@riverpod
class LocalUserInChannelController extends _$LocalUserInChannelController {
  // return stream user information, their role, and status in the channel if user joins channel success
  @override
  Stream<UserLiveStreamEntity?> build(String channelName) {
    //check local user
    final UserEntity? localUser = ref.read(authControllerProvider).value;
    if (localUser == null) {
      //return value null if don't look up local user
      return Stream.value(null);
    } else {
      // get id of local user
      final String localUserId = localUser.id;
      print('[LocalUserChannel] build');

      //return stream local user in channel
      return ref
          .watch(liveStreamRepositoryProvider)
          .getLocalUser(localUserId: localUserId, channelName: channelName);
    }
  }
}
