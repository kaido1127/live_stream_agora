import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_agora/app/app.dart';
import 'package:test_agora/app/features/auth/presentation/controller/auth_controller.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agora Test"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).logout();
                context.go('/login_page');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
                onPressed: () => context.push('/new_meeting_page'),
                icon: const Icon(Icons.add),
                label: const Text("New Meeting")),
            // ElevatedButton.icon(
            //     onPressed: () => context.push('/live_stream'),
            //     icon: const Icon(Icons.live_tv_sharp),
            //     label: const Text("Live stream")),
            ElevatedButton.icon(
                onPressed: () => context.push('/join_with_code_page'),
                icon: const Icon(Icons.margin),
                label: const Text("Join with a code"))
          ],
        ),
      ),
    );
  }

// void _joinWithCodeBottomSheet(BuildContext context, WidgetRef ref) {
//   String meetingCode = '';
//   String name = '';
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text(
//           "Join a meeting with a code",
//           style: TextStyle(
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: TextField(
//           onChanged: (value) {
//             meetingCode = value;
//           },
//           decoration: const InputDecoration(
//             labelText: 'Enter your Code',
//             border: OutlineInputBorder(),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => context.pop(),
//             child: const Text('Cancel'),
//           ),
//           ref.watch(agoraEngineControllerProvider).when(
//               data: (data) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     if (meetingCode.isNotEmpty) {
//                       context.pop();
//                       context.push('/live_stream', extra: (meetingCode, false, data));
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please enter a meeting code'),
//                         ),
//                       );
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                   ),
//                   child: const Text(
//                     'Join',
//                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                 );
//               },
//               error: (e, st) => const Icon(
//                     Icons.error,
//                     color: Colors.red,
//                   ),
//               loading: () => const CircularProgressIndicator())
//         ],
//       );
//     },
//   );
// }
}
