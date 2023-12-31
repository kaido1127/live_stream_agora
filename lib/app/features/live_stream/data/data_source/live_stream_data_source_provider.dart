import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/features/live_stream/data/data_source/live_stream_data_source.dart';

final liveStreamDataSourceProvider = Provider.autoDispose<LiveStreamDataSource>(
    (ref) => LiveStreamDataSource.create(firestore: FirebaseFirestore.instance));
