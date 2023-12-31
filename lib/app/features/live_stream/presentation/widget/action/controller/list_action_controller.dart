import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_agora/app/features/live_stream/data/repository/live_stream_repository_provider.dart';
import 'package:test_agora/app/features/live_stream/domain/action_entity.dart';

part 'list_action_controller.g.dart';

@riverpod
class ListActionController extends _$ListActionController {
  @override
  Stream<List<BaseActionEntity>> build(String channelName, int range) {
    return ref
        .watch(liveStreamRepositoryProvider)
        .getTailOfListAction(channelName: channelName, range: range);
  }
}
