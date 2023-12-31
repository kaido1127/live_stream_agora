// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActionModel _$ActionModelFromJson(Map<String, dynamic> json) => ActionModel(
      userName: json['user_name'] as String,
      userId: json['user_id'] as String,
      type: $enumDecode(_$ActionTypeEnumMap, json['type']),
      description: json['description'] as String,
      createdAt: json['created_at'] as int,
      giftItem: json['gift_item'] == null
          ? null
          : GiftItem.fromJson(json['gift_item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActionModelToJson(ActionModel instance) =>
    <String, dynamic>{
      'user_name': instance.userName,
      'user_id': instance.userId,
      'type': _$ActionTypeEnumMap[instance.type]!,
      'description': instance.description,
      'created_at': instance.createdAt,
      'gift_item': instance.giftItem,
    };

const _$ActionTypeEnumMap = {
  ActionType.donate: 'donate',
  ActionType.join: 'join',
  ActionType.left: 'left',
};
