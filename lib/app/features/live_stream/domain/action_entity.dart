import 'package:test_agora/app/features/live_stream/data/model/action_model.dart';
import 'package:test_agora/app/features/live_stream/domain/gift_item.dart';

enum ActionType { donate, join, left }

sealed class BaseActionEntity {
  final String userName;
  final String userId;
  final String description;
  final int createdAt;

  BaseActionEntity(
      {required this.userName,
      required this.userId,
      required this.description,
      required this.createdAt});

  factory BaseActionEntity.fromActionModel(ActionModel actionModel) {
    switch (actionModel.type) {
      case ActionType.donate:
        return DonateActionEntity.fromActionModel(actionModel);
      case ActionType.join:
        return JoinActionEntity.fromActionModel(actionModel);
      case ActionType.left:
        return LeftActionEntity.fromActionModel(actionModel);
    }
  }
}

class DonateActionEntity extends BaseActionEntity {
  final GiftItem giftItem;

  DonateActionEntity(
      {required super.userName,
      required super.userId,
      required super.description,
      required super.createdAt,
      required this.giftItem});

  factory DonateActionEntity.fromActionModel(ActionModel actionModel) =>
      DonateActionEntity(
          userName: actionModel.userName,
          userId: actionModel.userId,
          description: actionModel.description,
          createdAt: actionModel.createdAt,
          giftItem: actionModel.giftItem!);
}

class JoinActionEntity extends BaseActionEntity {
  JoinActionEntity(
      {required super.userName,
      required super.userId,
      required super.description,
      required super.createdAt});

  factory JoinActionEntity.fromActionModel(ActionModel actionModel) =>
      JoinActionEntity(
          userName: actionModel.userName,
          userId: actionModel.userId,
          description: actionModel.description,
          createdAt: actionModel.createdAt);
}

class LeftActionEntity extends BaseActionEntity {
  LeftActionEntity(
      {required super.userName,
      required super.userId,
      required super.description,
      required super.createdAt});

  factory LeftActionEntity.fromActionModel(ActionModel actionModel) =>
      LeftActionEntity(
          userName: actionModel.userName,
          userId: actionModel.userId,
          description: actionModel.description,
          createdAt: actionModel.createdAt);
}
