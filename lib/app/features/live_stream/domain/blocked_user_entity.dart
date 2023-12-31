import 'package:test_agora/app/features/live_stream/data/model/blocked_user_model.dart';
import 'package:test_agora/app/shared/enum/block_type.dart';

class BlockedUserEntity {
  final String id;
  final String userName;
  final int blockTime;
  BlockType? blockType;

  BlockedUserEntity(
      {required this.id,
      required this.userName,
      required this.blockTime,
      this.blockType});

  factory BlockedUserEntity.fromModel(BlockedUserModel blockedUserModel) =>
      BlockedUserEntity(
          id: blockedUserModel.id,
          userName: blockedUserModel.userName,
          blockTime: blockedUserModel.blockTime,
          blockType: blockedUserModel.blockType);
  BlockedUserModel toModel() => BlockedUserModel(
      id: id, userName: userName, blockTime: blockTime, blockType: blockType);
}
