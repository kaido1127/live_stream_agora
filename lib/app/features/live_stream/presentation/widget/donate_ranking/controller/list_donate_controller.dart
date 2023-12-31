import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_agora/app/features/live_stream/data/repository/live_stream_repository_provider.dart';
import 'package:test_agora/app/features/live_stream/domain/donate_entity.dart';

part 'list_donate_controller.g.dart';

@riverpod
class ListDonateController extends _$ListDonateController {
  @override
  Stream<List<DonateEntity>> build(String channelName) {
    return ref
        .watch(liveStreamRepositoryProvider)
        .getListDonateOrderByCoin(channelName: channelName);
  }
}
