import 'package:flutter/material.dart';
import 'package:mobile_banking_apps/core/routing/app_router.dart';
import 'package:mobile_banking_apps/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mobile Banking App',
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}
