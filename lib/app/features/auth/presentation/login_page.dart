import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:test_agora/app/features/auth/presentation/controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ref.watch(authControllerProvider).when(
            data: (data) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (data != null) ...[
                    ElevatedButton.icon(
                      onPressed: () {
                        context.go('/home_page');
                      },
                      icon: const Icon(Icons.login),
                      label: Text('Continue with ${data.name}'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () =>
                          ref.read(authControllerProvider.notifier).logout(),
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                    )
                  ] else
                    ElevatedButton.icon(
                      onPressed: () =>
                          ref.read(authControllerProvider.notifier).login(),
                      icon: const Icon(Icons.login),
                      label: const Text('Login'),
                    )
                ],
              );
            },
            error: (e, st) => Text(e.toString()),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
