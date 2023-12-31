import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_agora/app/features/live_stream/data/repository/live_stream_repository_provider.dart';
import 'package:test_agora/app/features/live_stream/domain/blocked_user_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/local_user_in_channel_controller.dart';
import 'package:test_agora/app/shared/enum/block_type.dart';

part 'blacklist_controller.g.dart';

@riverpod
class BlacklistController extends _$BlacklistController {
  @override
  Stream<List<BlockedUserEntity>> build(String channelName) {
    return ref
        .watch(liveStreamRepositoryProvider)
        .getBlacklistUserOnLiveStream(channelName: channelName);
  }

  Future<void> unblockUser(
      {required BlockedUserEntity blockedUserEntity}) async {
    ref.read(liveStreamRepositoryProvider).unblockUserFromChannel(
        channelName: channelName, blockedUserId: blockedUserEntity.id);
    if (blockedUserEntity.blockType == BlockType.forever) {
      final String hostId =
          ref.read(LocalUserInChannelControllerProvider(channelName)).value!.id;
      ref
          .read(liveStreamRepositoryProvider)
          .unblockUser(blockerId: hostId, blockedUserId: blockedUserEntity.id);
    }
  }
}
