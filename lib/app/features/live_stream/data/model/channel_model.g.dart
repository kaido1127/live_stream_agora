// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) => ChannelModel(
      name: json['name'] as String,
      host: UserLiveStreamModel.fromJson(json['host'] as Map<String, dynamic>),
      createdAt: json['created_at'] as int,
    );

Map<String, dynamic> _$ChannelModelToJson(ChannelModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'host': instance.host,
      'created_at': instance.createdAt,
    };
