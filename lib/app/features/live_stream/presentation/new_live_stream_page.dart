import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/auth/presentation/controller/auth_controller.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/live_stream_controller.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';

class NewLiveStreamPage extends ConsumerStatefulWidget {
  const NewLiveStreamPage({super.key});

  @override
  ConsumerState<NewLiveStreamPage> createState() => _NewMeetingPageState();
}

class _NewMeetingPageState extends ConsumerState<NewLiveStreamPage> {
  final String channelName = 'ntv_test';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Meeting"),
      ),
      body: ref.watch(liveStreamControllerProvider).when(
          data: (agoraEngine) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
                child: Center(
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
                          "Your meeting is ready",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          leading: const Icon(Icons.attach_file),
                          title: Text(channelName),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.copy),
                          ),
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
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Share invite",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
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
                                              roleType: LiveStreamRoleType.host,
                                              localUser: localUser,
                                              channelName: channelName);
                                    },
                                    icon: const Icon(Icons.video_call),
                                    label: const Text("Start call"));
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
