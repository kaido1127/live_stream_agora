
import 'package:json_annotation/json_annotation.dart';

part 'invitation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Invitation {
  final InvitationType type;
  final bool? isAccept;

  Invitation({required this.type, required this.isAccept});
  factory Invitation.fromJson(Map<String, dynamic> json) =>
      _$InvitationFromJson(json);

  Map<String, dynamic> toJson() => _$InvitationToJson(this);
}

enum InvitationType { onCamera, onMic, onCameraAndMic }

String broadcasterPermission({required InvitationType invitationType}) {
  switch (invitationType) {
    case InvitationType.onCamera:
      return 'camera';
    case InvitationType.onMic:
      return 'microphone';
    case InvitationType.onCameraAndMic:
      return 'both microphone and camera';
  }
}

