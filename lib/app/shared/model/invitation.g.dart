// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invitation _$InvitationFromJson(Map<String, dynamic> json) => Invitation(
      type: $enumDecode(_$InvitationTypeEnumMap, json['type']),
      isAccept: json['is_accept'] as bool?,
    );

Map<String, dynamic> _$InvitationToJson(Invitation instance) =>
    <String, dynamic>{
      'type': _$InvitationTypeEnumMap[instance.type]!,
      'is_accept': instance.isAccept,
    };

const _$InvitationTypeEnumMap = {
  InvitationType.onCamera: 'onCamera',
  InvitationType.onMic: 'onMic',
  InvitationType.onCameraAndMic: 'onCameraAndMic',
};
