import 'package:flutter/material.dart';
import 'package:test_agora/app/features/live_stream/domain/action_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/action/join_action_card.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/action/left_action_card.dart';

import 'donate_action_card.dart';

class ListActionWidget extends StatefulWidget {
  final List<BaseActionEntity> listAction;
  const ListActionWidget({super.key, required this.listAction});

  @override
  State<StatefulWidget> createState() => _ListActionWidgetState();
}

class _ListActionWidgetState extends State<ListActionWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.listAction.length,
        itemBuilder: (context, index) {
          final BaseActionEntity actionEntity = widget.listAction[index];
          return switch (actionEntity) {
            DonateActionEntity() =>
              DonateActionCard(donateAction: actionEntity),
            JoinActionEntity() => JoinActionCard(joinAction: actionEntity),
            LeftActionEntity() => LeftActionCard(leftAction: actionEntity),
          };
        });
  }
}
