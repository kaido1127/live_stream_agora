import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/live_stream/domain/action_entity.dart';
import 'package:test_agora/app/features/live_stream/domain/gift_item.dart';
import 'package:test_agora/app/features/live_stream/domain/user_live_stream_entity.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/action/controller/list_action_controller.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/donate_ranking/controller/list_donate_controller.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/controller/list_user_controller.dart';
import 'package:test_agora/app/features/live_stream/presentation/controller/local_user_in_channel_controller.dart';
import 'package:test_agora/app/features/live_stream/presentation/live_stream_view.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/action/list_action_widget.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/donate_ranking/donate_ranking_widget.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/gift_button_widget.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_call_button_widget.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/list_user_join_channel/list_user_joined_channel_widget.dart';
import 'package:test_agora/app/features/live_stream/presentation/widget/invation_widget.dart';
import 'package:test_agora/app/shared/enum/live_stream_role_type.dart';

final showListUser = StateProvider.autoDispose<bool>((ref) => false);
final showDonateRanking = StateProvider.autoDispose<bool>((ref) => false);

class LiveStream extends ConsumerStatefulWidget {
  final String channelName;

  const LiveStream({super.key, required this.channelName});

  @override
  ConsumerState<LiveStream> createState() => _LiveStreamState();
}

class _LiveStreamState extends ConsumerState<LiveStream> {
  //final String channelName = "ntv_test";

  @override
  Widget build(BuildContext context) {
    ref.listen(listActionControllerProvider(widget.channelName, 10),
        (previues, next) {
      final UserLiveStreamEntity? localUser = ref
          .read(localUserInChannelControllerProvider(widget.channelName))
          .value;
      if (localUser != null) {
        int joinTime = localUser.joinTime;
        if (next.value != null && next.value!.isNotEmpty) {
          final BaseActionEntity lastAction = next.value!.first;
          final scaffoldMessenger = switch (lastAction) {
            DonateActionEntity() =>
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.white.withOpacity(0.3),
                content: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cảm ơn ${lastAction.userName} đã donate!',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(lastAction.description),
                      ],
                    ),
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                    bottom: deviceSize.height * 0.7, left: 20, right: 20),
              )),
            JoinActionEntity() => null,
            LeftActionEntity() => null,
          };
          if (joinTime < lastAction.createdAt) {
            scaffoldMessenger;
          }
          // return switch(lastAction){
          //   DonateActionEntity() =>
          // }
        }
      }
    });
    print("[Live Stream] build widget");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
        actions: [
          ref.watch(listUserControllerProvider(widget.channelName)).when(
              data: (listUser) {
                return InkWell(
                  onTap: () {
                    ref.read(showDonateRanking.notifier).state = false;
                    ref.read(showListUser.notifier).state =
                        !ref.read(showListUser);
                  },
                  child: Row(
                    children: [
                      Text(listUser.length.toString()),
                      const Icon(Icons.remove_red_eye),
                    ],
                  ),
                );
              },
              error: (e, st) => const SizedBox(),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  )),
          const SizedBox(
            width: 10,
          ),
          IconButton(
              onPressed: () {
                ref.read(showListUser.notifier).state = false;
                ref.read(showDonateRanking.notifier).state =
                    !ref.read(showDonateRanking);
              },
              icon: const Icon(Icons.star))
        ],
      ),
      body: ref.watch(listUserControllerProvider(widget.channelName)).when(
          data: (listUser) {
            final List<UserLiveStreamEntity> listBroadcaster = listUser
                .where((user) => (user.roleType == LiveStreamRoleType.host ||
                    user.roleType == LiveStreamRoleType.broadcaster))
                .toList();
            if (listBroadcaster.isNotEmpty) {
              return Stack(
                children: [
                  ref
                      .watch(localUserInChannelControllerProvider(
                          widget.channelName))
                      .when(
                          data: (localUser) {
                            return (localUser == null)
                                ? const Center(
                                    child: Text("Can't join"),
                                  )
                                : Stack(
                                    children: [
                                      Center(
                                        child: LiveStreamView(
                                            listBroadcaster: listBroadcaster,
                                            channelName: widget.channelName,
                                            localUser: localUser),
                                      ),
                                      Positioned(
                                          child: Container(
                                        alignment: Alignment.bottomCenter,
                                        padding:
                                            const EdgeInsets.only(bottom: 0),
                                        child: SizedBox(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: SizedBox(
                                              child: Row(
                                                children: [
                                                  ListCallButtonWidget(
                                                    channelName:
                                                        widget.channelName,
                                                    localUser: localUser,
                                                  ),
                                                  if (localUser.roleType ==
                                                      LiveStreamRoleType
                                                          .audience)
                                                    ...listGiftDefault
                                                        .map((gift) =>
                                                            GiftButtonWidget(
                                                              giftItemEntity:
                                                                  gift,
                                                              localUser:
                                                                  localUser,
                                                              channelName: widget
                                                                  .channelName,
                                                            ))
                                                        .toList()
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                      ref
                                          .watch(listActionControllerProvider(
                                              widget.channelName, 10))
                                          .when(
                                              data: (listAction) {
                                                return Positioned(
                                                  bottom: 110,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    height:
                                                        deviceSize.height * 0.4,
                                                    width: deviceSize.width,
                                                    child: ListActionWidget(
                                                        listAction: listAction),
                                                  ),
                                                );
                                              },
                                              error: (e, st) =>
                                                  const SizedBox(),
                                              loading: () => const SizedBox()),
                                      if (ref.watch(showListUser))
                                        Positioned(
                                          bottom: 0,
                                          child: ListUserJoinedChannelWidget(
                                            channelName: widget.channelName,
                                            listViewer: listUser,
                                            isHost: localUser.roleType ==
                                                LiveStreamRoleType.host,
                                          ),
                                        ),
                                      Center(
                                        child: InvitationWidget(
                                          channelName: widget.channelName,
                                          localUser: localUser,
                                        ),
                                      ),
                                    ],
                                  );
                          },
                          error: (e, st) => const SizedBox(),
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              )),
                  if (ref.watch(showDonateRanking))
                    ref
                        .watch(listDonateControllerProvider(widget.channelName))
                        .when(
                            data: (listDonate) {
                              return Positioned(
                                  bottom: 0,
                                  child: DonateRankingWidget(
                                      listDonate: listDonate));
                            },
                            error: (e, st) => const SizedBox(),
                            loading: () => const SizedBox()),
                ],
              );
            } else {
              return const Center(
                child: Text("Live stream don't exist"),
              );
            }
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
