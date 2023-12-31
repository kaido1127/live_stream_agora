import 'package:json_annotation/json_annotation.dart';
import 'package:test_agora/app/features/live_stream/data/model/donate_model.dart';

part 'gift_item.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GiftItem {
  final String name;
  final int coin;
  final int valueLevel;

  GiftItem({required this.name, required this.coin, required this.valueLevel});

  factory GiftItem.fromDonateModel(DonateModel donateModel) => GiftItem(
      name: donateModel.name,
      coin: donateModel.coin,
      valueLevel: donateModel.valueLevel);

  factory GiftItem.fromJson(Map<String, dynamic> json) =>
      _$GiftItemFromJson(json);

  Map<String, dynamic> toJson() => _$GiftItemToJson(this);
}

final List<GiftItem> listGiftDefault = [
  GiftItem(name: "Gift 1", coin: 1, valueLevel: 1),
  GiftItem(name: "Gift 2", coin: 2, valueLevel: 2),
  GiftItem(name: "Gift 3", coin: 3, valueLevel: 3),
  GiftItem(name: "Gift 4", coin: 4, valueLevel: 4),
  GiftItem(name: "Gift 5", coin: 5, valueLevel: 5),
];
