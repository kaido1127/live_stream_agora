import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/live_stream/domain/gift_item.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/controller/list_user_controller.dart';

class GiftButtonWidget extends ConsumerWidget {
  final String channelName;
  final GiftItem giftItemEntity;
  final UserLiveStreamEntity localUser;
  const GiftButtonWidget(
      {super.key,
      required this.giftItemEntity,
      required this.channelName,
      required this.localUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: ElevatedButton(
          onPressed: () => ref
              .read(listUserControllerProvider(channelName).notifier)
              .sendGift(giver: localUser, giftItemEntity: giftItemEntity),
          child: SizedBox(
            height: deviceSize.width * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(giftItemEntity.name),
                Text(giftItemEntity.coin.toString())
              ],
            ),
          )),
    );
  }
}
