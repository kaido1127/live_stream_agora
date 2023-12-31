// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonateModel _$DonateModelFromJson(Map<String, dynamic> json) => DonateModel(
      name: json['name'] as String,
      coin: json['coin'] as int,
      giverId: json['giver_id'] as String,
      giverName: json['giver_name'] as String,
      donateAt: json['donate_at'] as int,
      valueLevel: json['value_level'] as int,
    );

Map<String, dynamic> _$DonateModelToJson(DonateModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'coin': instance.coin,
      'giver_id': instance.giverId,
      'giver_name': instance.giverName,
      'donate_at': instance.donateAt,
      'value_level': instance.valueLevel,
    };
