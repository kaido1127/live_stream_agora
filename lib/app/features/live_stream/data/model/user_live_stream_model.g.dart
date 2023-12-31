// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_live_stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLiveStreamModel _$UserLiveStreamModelFromJson(Map<String, dynamic> json) =>
    UserLiveStreamModel(
      email: json['email'] as String,
      id: json['id'] as String,
      liveId: json['live_id'] as int,
      image: json['image'] as String?,
      name: json['name'] as String,
      roleType:
          $enumDecodeNullable(_$LiveStreamRoleTypeEnumMap, json['role_type']),
      joinTime: json['join_time'] as int,
      invitation: json['invitation'] == null
          ? null
          : Invitation.fromJson(json['invitation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserLiveStreamModelToJson(
        UserLiveStreamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'live_id': instance.liveId,
      'email': instance.email,
      'image': instance.image,
      'name': instance.name,
      'join_time': instance.joinTime,
      'role_type': _$LiveStreamRoleTypeEnumMap[instance.roleType],
      'invitation': instance.invitation,
    };

const _$LiveStreamRoleTypeEnumMap = {
  LiveStreamRoleType.host: 'host',
  LiveStreamRoleType.broadcaster: 'broadcaster',
  LiveStreamRoleType.audience: 'audience',
};
