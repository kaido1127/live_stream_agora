import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_agora/app/routes/app_routes_provider.dart';

// app id
// app certificate 64488b92687240f0aab6601b54dcb4b2
// name test
// temp token 007eJxTYPgZN9+bZV1o7ITeEw0b/+w4fP+fleYyrvn6ZgvZJ/jYy7UoMBgYJhunWVgYmZsmJpskm1kmmaVYmhokGhkYJJsYpxql6qqXpDYEMjKcXdTNzMgAgSA+C0NJanEJAwMARWoe6g==
late Size deviceSize;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    deviceSize = MediaQuery.of(context).size;
    return MaterialApp.router(
      title: 'Agora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 23)),
        useMaterial3: true,
      ),
      routerConfig: ref.watch(routeProvider),
    );
  }
}
