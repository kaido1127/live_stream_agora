import 'package:json_annotation/json_annotation.dart';
import 'package:test_agora/app/features/live_stream/domain/action_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/gift_item.dart';

part 'action_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ActionModel {
  final String userName;
  final String userId;
  final ActionType type;
  final String description;
  final int createdAt;
  GiftItem? giftItem;

  ActionModel(
      {required this.userName,
      required this.userId,
      required this.type,
      required this.description,
      required this.createdAt,
      this.giftItem});

  factory ActionModel.fromJson(Map<String, dynamic> json) =>
      _$ActionModelFromJson(json);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_name': userName,
        'user_id': userId,
        'type': _$ActionTypeEnumMap[type]!,
        'description': description,
        'created_at': createdAt,
        'gift_item': (giftItem == null) ? null : giftItem?.toJson(),
      };
}
