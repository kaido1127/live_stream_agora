import 'package:json_annotation/json_annotation.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';
import 'package:test_agora/app/shared/model/invitation.dart';

part 'user_live_stream_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserLiveStreamModel {
  final String id;
  final int liveId;
  final String email;
  String? image;
  final String name;
  final int joinTime;
  final LiveStreamRoleType? roleType;
  final Invitation? invitation;

  UserLiveStreamModel(
      {required this.email,
      required this.id,
      required this.liveId,
      required this.image,
      required this.name,
      required this.roleType,
      required this.joinTime,
      this.invitation});

  UserLiveStreamModel copyWith({
    String? id,
    int? liveId,
    String? email,
    String? image,
    String? name,
    LiveStreamRoleType? roleType,
    int? joinTime,
    Invitation? invitation,
  }) {
    return UserLiveStreamModel(
        email: email ?? this.email,
        liveId: liveId ?? this.liveId,
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        roleType: roleType ?? this.roleType,
        joinTime: joinTime ?? this.joinTime,
        invitation: invitation);
  }

  factory UserLiveStreamModel.fromEntity(
          UserLiveStreamEntity userLiveStreamEntity) =>
      UserLiveStreamModel(
          email: userLiveStreamEntity.email,
          id: userLiveStreamEntity.id,
          liveId: userLiveStreamEntity.liveId,
          image: userLiveStreamEntity.image,
          name: userLiveStreamEntity.name,
          roleType: userLiveStreamEntity.roleType,
          joinTime: userLiveStreamEntity.joinTime,
          invitation: userLiveStreamEntity.invitation);

  UserLiveStreamEntity toEntity() => UserLiveStreamEntity(
      email: email,
      id: id,
      liveId: liveId,
      image: image,
      name: name,
      roleType: roleType,
      joinTime: joinTime,
      invitation: invitation);

  factory UserLiveStreamModel.fromJson(Map<String, dynamic> json) =>
      _$UserLiveStreamModelFromJson(json);

  Map<String, dynamic> toJson() => {
        'live_id': liveId,
        'id': id,
        'email': email,
        'image': image,
        'name': name,
        'join_time': joinTime,
        'role_type': _$LiveStreamRoleTypeEnumMap[roleType],
        'invitation': invitation == null ? null : invitation!.toJson(),
      };
}
