import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import "package:mobile_banking_apps/features/home/presentation/screens/home_screen.dart";

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
    ),
    // GoRoute(
    //   path: '/transfer',
    //   pageBuilder: (context, state) =>
    //       const MaterialPage(child: TransferScreen()),
    // ),
    // GoRoute(
    //   path: '/history',
    //   pageBuilder: (context, state) =>
    //       const MaterialPage(child: HistoryScreen()),
    // ),
    // GoRoute(
    //   path: '/settings',
    //   pageBuilder: (context, state) =>
    //       const MaterialPage(child: SettingsScreen()),
    // ),
  ],
);
