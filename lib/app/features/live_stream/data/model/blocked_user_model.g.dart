// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockedUserModel _$BlockedUserModelFromJson(Map<String, dynamic> json) =>
    BlockedUserModel(
      id: json['id'] as String,
      userName: json['user_name'] as String,
      blockTime: json['block_time'] as int,
      blockType: $enumDecodeNullable(_$BlockTypeEnumMap, json['block_type']),
    );

Map<String, dynamic> _$BlockedUserModelToJson(BlockedUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_name': instance.userName,
      'block_time': instance.blockTime,
      'block_type': _$BlockTypeEnumMap[instance.blockType],
    };

const _$BlockTypeEnumMap = {
  BlockType.forever: 'forever',
  BlockType.blockFromChannel: 'blockFromChannel',
  BlockType.blockCommentFromChannel: 'blockCommentFromChannel',
};
