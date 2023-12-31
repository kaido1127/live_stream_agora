// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GiftItem _$GiftItemFromJson(Map<String, dynamic> json) => GiftItem(
      name: json['name'] as String,
      coin: json['coin'] as int,
      valueLevel: json['value_level'] as int,
    );

Map<String, dynamic> _$GiftItemToJson(GiftItem instance) => <String, dynamic>{
      'name': instance.name,
      'coin': instance.coin,
      'value_level': instance.valueLevel,
    };
