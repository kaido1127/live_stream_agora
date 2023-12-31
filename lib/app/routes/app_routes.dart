import 'package:go_router/go_router.dart';
import 'package:test_agora/app/features/auth/presentation/login_page.dart';
import 'package:test_agora/app/features/home/presentation/home_page.dart';
import 'package:test_agora/app/features/live_stream/presentation/join_with_code_page.dart';
import 'package:test_agora/app/features/live_stream/presentation/live_stream.dart';
import 'package:test_agora/app/features/live_stream/presentation/new_live_stream_page.dart';

final routes = [
  GoRoute(
      path: "/login_page",
      name: "login_page",
      builder: (context, state) => const LoginPage()),
  GoRoute(
      path: "/live_stream",
      name: "live_stream",
      builder: (context, state) => LiveStream(
            channelName: state.extra as String,
          )),
  GoRoute(
      path: "/home_page",
      name: "home_page",
      builder: (context, state) => const HomePage()),
  GoRoute(
      path: "/new_meeting_page",
      name: "new_meeting_page",
      builder: (context, state) => const NewLiveStreamPage()),
  GoRoute(
      path: "/join_with_code_page",
      name: "join_with_code_page",
      builder: (context, state) => const JoinWithCodePage())
];
