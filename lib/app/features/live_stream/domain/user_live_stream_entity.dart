import 'package:json_annotation/json_annotation.dart';
import 'package:test_agora/app/features/live_stream/data/model/user_live_stream_model.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';
import 'package:test_agora/app/shared/model/invitation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserLiveStreamEntity {
  final String id;
  final int liveId;
  final String email;
  String? image;
  final String name;
  final int joinTime;
  final LiveStreamRoleType? roleType;
  final Invitation? invitation;

  UserLiveStreamEntity(
      {required this.email,
      required this.id,
      required this.liveId,
      required this.image,
      required this.name,
      required this.roleType,
      required this.joinTime,
      this.invitation});

  UserLiveStreamEntity copyWith({
    String? id,
    String? email,
    String? image,
    String? name,
    int? liveId,
    int? joinTime,
    LiveStreamRoleType? roleType,
    Invitation? invitation,
  }) {
    return UserLiveStreamEntity(
      email: email ?? this.email,
      id: id ?? this.id,
      liveId: liveId ?? this.liveId,
      joinTime: joinTime ?? this.joinTime,
      image: image ?? this.image,
      name: name ?? this.name,
      roleType: roleType ?? this.roleType,
      invitation: invitation,
    );
  }

  factory UserLiveStreamEntity.fromModel(
          UserLiveStreamModel userLiveStreamModel) =>
      UserLiveStreamEntity(
          email: userLiveStreamModel.email,
          id: userLiveStreamModel.id,
          liveId: userLiveStreamModel.liveId,
          image: userLiveStreamModel.image,
          name: userLiveStreamModel.name,
          joinTime: userLiveStreamModel.joinTime,
          roleType: userLiveStreamModel.roleType,
          invitation: userLiveStreamModel.invitation);

  UserLiveStreamModel toModel() => UserLiveStreamModel(
      email: email,
      id: id,
      liveId: liveId,
      image: image,
      name: name,
      joinTime: joinTime,
      roleType: roleType,
      invitation: invitation);
}
