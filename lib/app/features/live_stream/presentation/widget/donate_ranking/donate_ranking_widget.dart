import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/live_stream/domain/donate_entity.dart';

class DonateRankingWidget extends ConsumerStatefulWidget {
  final List<DonateEntity> listDonate;

  const DonateRankingWidget({super.key, required this.listDonate});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DonateRankingWidgetState();
}

class _DonateRankingWidgetState extends ConsumerState<DonateRankingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: Colors.white),
        width: deviceSize.width,
        height: deviceSize.height * 0.4,
        child: (widget.listDonate.isNotEmpty)
            ? ListView.builder(
                itemCount: widget.listDonate.length,
                itemBuilder: (context, index) {
                  final DonateEntity donate = widget.listDonate[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text((index + 1).toString())),
                    title: Text(donate.giverName),
                    trailing: Text(
                      donate.giftItem.coin.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  );
                })
            : const Center(
                child: Text("No one has donated yet"),
              ));
  }
}
