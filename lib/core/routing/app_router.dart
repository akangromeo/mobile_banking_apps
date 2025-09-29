import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_banking_apps/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:mobile_banking_apps/features/auth/presentation/screens/login_screen.dart';
import 'package:mobile_banking_apps/features/auth/presentation/screens/otp_screen.dart';
import 'package:mobile_banking_apps/features/auth/presentation/screens/signup_screen.dart';
import "package:mobile_banking_apps/features/home/presentation/screens/home_screen.dart";

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(
        child: LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) => MaterialPage(
        child: SignupScreen(),
      ),
    ),
    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) => MaterialPage(
        child: ForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      path: '/otp-screen',
      pageBuilder: (context, state) => const MaterialPage(
        child: OtpScreen(),
      ),
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
