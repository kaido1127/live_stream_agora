import 'package:flutter/material.dart';
import 'package:test_agora/app/features/live_stream/domain/action_entity.dart';
import 'package:test_agora/app/shared/helper/time_convert.dart';

class JoinActionCard extends StatelessWidget {
  final JoinActionEntity joinAction;
  const JoinActionCard({super.key, required this.joinAction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Text(
            TimeConvert.hoursMinutesFromMillisecondsSinceEpoch(
                joinAction.createdAt),
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
          Text(
            joinAction.description,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
