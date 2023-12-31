import 'package:flutter/material.dart';
import 'package:test_agora/app/features/live_stream/domain/action_entity.dart';
import 'package:test_agora/app/shared/helper/time_convert.dart';

class DonateActionCard extends StatelessWidget {
  final DonateActionEntity donateAction;
  const DonateActionCard({super.key, required this.donateAction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            TimeConvert.hoursMinutesFromMillisecondsSinceEpoch(donateAction.createdAt),
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          Text(
            donateAction.userName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: Text(donateAction.description,
          style: const TextStyle(color: Colors.white70)),
    );
  }
}
