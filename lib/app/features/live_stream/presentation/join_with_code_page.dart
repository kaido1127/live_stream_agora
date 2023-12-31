import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/auth/presentation/controller/auth_controller.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/live_stream_controller.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';

class JoinWithCodePage extends ConsumerStatefulWidget {
  const JoinWithCodePage({super.key});

  @override
  ConsumerState<JoinWithCodePage> createState() => _JoinWithCodePageState();
}

class _JoinWithCodePageState extends ConsumerState<JoinWithCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Meeting With Code"),
      ),
      body: ref.watch(liveStreamControllerProvider).when(
          data: (agoraEngine) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: deviceSize.width * 0.2,
                      child: const Icon(
                        Icons.meeting_room_outlined,
                        color: Colors.white70,
                        size: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        "Enter your code",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      onChanged: (value) {},
                      decoration: const InputDecoration(
                        labelText: 'Your Code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey[350],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    ref.watch(authControllerProvider).when(
                        data: (localUser) {
                          return (localUser == null)
                              ? const SizedBox()
                              : ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.deepPurple, width: 1),
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(liveStreamControllerProvider
                                            .notifier)
                                        .join(
                                            context: context,
                                            roleType:
                                                LiveStreamRoleType.audience,
                                            localUser: localUser,
                                            channelName: 'ntv_test');
                                  },
                                  icon: const Icon(Icons.video_call),
                                  label: const Text("Join call"));
                        },
                        error: (e, st) => Center(
                              child: Text(e.toString()),
                            ),
                        loading: () => const Center(
                              child: CircularProgressIndicator(),
                            )),
                  ],
                ),
              ),
            );
          },
          error: (e, st) => Center(
                child: Text(e.toString()),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
