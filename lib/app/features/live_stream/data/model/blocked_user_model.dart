import 'package:json_annotation/json_annotation.dart';
import 'package:test_agora/app/shared/enum/block_type.dart';

part 'blocked_user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BlockedUserModel {
  final String id;
  final String userName;
  final int blockTime;
  BlockType? blockType;

  BlockedUserModel(
      {required this.id,
      required this.userName,
      required this.blockTime,
      this.blockType});


  factory BlockedUserModel.fromJson(Map<String, dynamic> json) =>
      _$BlockedUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$BlockedUserModelToJson(this);
}
