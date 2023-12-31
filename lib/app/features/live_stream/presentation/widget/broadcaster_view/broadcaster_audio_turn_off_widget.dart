import 'package:flutter/material.dart';

class BroadcasterAudioTurnOffWidget extends StatelessWidget {
  final bool isMe;

  const BroadcasterAudioTurnOffWidget({super.key, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        right: 10,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                children: [
                  const Icon(
                    Icons.mic_off,
                    color: Colors.black54,
                  ),
                  if (isMe) ...[
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      ("You turned off the mic"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ));
  }
}
