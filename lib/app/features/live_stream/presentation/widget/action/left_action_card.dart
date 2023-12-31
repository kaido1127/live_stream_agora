import 'package:flutter/material.dart';
import 'package:test_agora/app/features/live_stream/domain/action_entity.dart';
import 'package:test_agora/app/shared/helper/time_convert.dart';

class LeftActionCard extends StatelessWidget {
  final LeftActionEntity leftAction;
  const LeftActionCard({super.key, required this.leftAction});

  @override
  Widget build(BuildContext context) {
    final DateTime time =
        DateTime.fromMillisecondsSinceEpoch(leftAction.createdAt);
    return ListTile(
      title: Row(
        children: [
          Text(
            TimeConvert.hoursMinutesFromMillisecondsSinceEpoch(leftAction.createdAt),
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          Text(
            leftAction.description,
            style: const TextStyle(
                color: Colors.white70, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
