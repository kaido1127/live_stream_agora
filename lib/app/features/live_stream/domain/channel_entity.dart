import 'package:test_agora/app/features/live_stream/data/model/channel_model.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';

//@JsonSerializable(fieldRename: FieldRename.snake)
class ChannelEntity {
  final String name;
  UserLiveStreamEntity host;
  final int createdAt;

  ChannelEntity(
      {required this.name, required this.host, required this.createdAt});

  ChannelEntity copyWith(
      {UserLiveStreamEntity? host, List<UserLiveStreamEntity>? listUser}) {
    return ChannelEntity(
        name: name, host: host ?? this.host, createdAt: createdAt);
  }

  factory ChannelEntity.fromModel(ChannelModel channelModel) => ChannelEntity(
      name: channelModel.name,
      host: channelModel.host.toEntity(),
      createdAt: channelModel.createdAt);
}
