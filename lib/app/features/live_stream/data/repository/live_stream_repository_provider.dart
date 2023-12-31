import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/features/live_stream/data/data_source/live_stream_data_source_provider.dart';
import 'package:test_agora/app/features/live_stream/data/repository/live_stream_repository.dart';

final liveStreamRepositoryProvider = Provider.autoDispose<LiveStreamRepository>(
    (ref) => LiveStreamRepository.create(dataSource: ref.watch(liveStreamDataSourceProvider)));
