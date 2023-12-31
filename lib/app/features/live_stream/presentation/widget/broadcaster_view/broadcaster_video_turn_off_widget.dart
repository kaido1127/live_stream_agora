import 'package:flutter/material.dart';

class BroadcasterVideoTurnOffWidget extends StatelessWidget {
  final bool isMe;

  const BroadcasterVideoTurnOffWidget({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.videocam_off,
              color: Colors.black54,
              size: 70,
            ),
            if (isMe) ...[
              const SizedBox(
                height: 15,
              ),
              const Text(
                ("You turned off the camera"),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
