import 'package:test_agora/app/features/live_stream/domain/gift_item.dart';

//@JsonSerializable(fieldRename: FieldRename.snake)
class DonateEntity {
  final GiftItem giftItem;
  final String giverName;
  final String giverId;

  DonateEntity(
      {required this.giftItem, required this.giverName, required this.giverId});
}
