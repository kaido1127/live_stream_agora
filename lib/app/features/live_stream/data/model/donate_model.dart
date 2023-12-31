import 'package:json_annotation/json_annotation.dart';

part 'donate_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DonateModel {
  final String name;
  final int coin;
  final String giverId;
  final String giverName;
  final int donateAt;
  final int valueLevel;

  DonateModel(
      {required this.name,
      required this.coin,
      required this.giverId,
      required this.giverName,
      required this.donateAt,
      required this.valueLevel});

  factory DonateModel.fromJson(Map<String, dynamic> json) =>
      _$DonateModelFromJson(json);

  Map<String, dynamic> toJson() => _$DonateModelToJson(this);
}
