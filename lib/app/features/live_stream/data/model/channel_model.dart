import 'package:json_annotation/json_annotation.dart';
import 'package:test_agora/app/features/live_stream/data/model/user_live_stream_model.dart';

part 'channel_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChannelModel {
  final String name;
  UserLiveStreamModel host;
  final int createdAt;

  ChannelModel(
      {required this.name, required this.host, required this.createdAt});

  ChannelModel copyWith(
      {UserLiveStreamModel? host, List<UserLiveStreamModel>? listUser}) {
    return ChannelModel(
        name: name, host: host ?? this.host, createdAt: createdAt);
  }

  factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
        name: json['name'] as String,
        host:
            UserLiveStreamModel.fromJson(json['host'] as Map<String, dynamic>),
        createdAt: json['created_at'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'host': host.toJson(),
        'created_at': createdAt,
      };
}
