import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile_banking_apps/core/services/auth_service.dart';
import 'package:mobile_banking_apps/core/di/injector.dart';

// AUTH
import 'package:mobile_banking_apps/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:mobile_banking_apps/features/auth/presentation/screens/login_screen.dart';
import 'package:mobile_banking_apps/features/auth/presentation/screens/otp_screen.dart';
import 'package:mobile_banking_apps/features/auth/presentation/screens/signup_screen.dart';

// HOME + FEATURES
import 'package:mobile_banking_apps/features/history/presentation/screens/history_screen.dart';
import 'package:mobile_banking_apps/features/home/presentation/screens/home_screen.dart';
import 'package:mobile_banking_apps/features/settings/presentation/bloc/profile_cubit.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/transfer_entitiy.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/bloc/bank_cubit.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/bloc/transfer_input_cubit.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/screens/transfer_destination_bank_screen.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/screens/transfer_input_amount_screen.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/screens/transfer_input_pin_screen.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/screens/transfer_result_screen.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/screens/transfer_screen.dart';
import 'package:mobile_banking_apps/features/settings/presentation/screens/setting_detail_screen.dart';
import 'package:mobile_banking_apps/features/settings/presentation/screens/setting_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  refreshListenable: Hive.box('authBox').listenable(),
  redirect: (context, state) {
    final auth = sl<AuthService>();
    final loggedIn = auth.isLoggedIn;

    final isLoggingIn =
        state.uri.toString() == '/login' || state.uri.toString() == '/signup';

    // belum login → paksa ke login
    if (!loggedIn && !isLoggingIn) return '/login';

    // sudah login tapi mencoba ke login → lempar ke beranda
    if (loggedIn && isLoggingIn) return '/';

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => const MaterialPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) => MaterialPage(child: SignupScreen()),
    ),
    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) =>
          MaterialPage(child: ForgotPasswordScreen()),
    ),
    GoRoute(
      path: '/otp-screen',
      pageBuilder: (context, state) => const MaterialPage(child: OtpScreen()),
    ),

    /// TRANSFER
    GoRoute(
      path: '/transfer',
      pageBuilder: (context, state) =>
          const MaterialPage(child: TransferScreen()),
    ),
    GoRoute(
      path: '/select-bank',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => sl<BankCubit>()..loadBanks(),
          child: const TransferDestinationBankScreen(),
        );
      },
    ),
    GoRoute(
      path: '/transfer-input-amount',
      builder: (context, state) {
        if (state.extra == null) {
          return const Scaffold(
            body: Center(child: Text("Missing transfer data")),
          );
        }

        final data = state.extra as Map<String, dynamic>;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<TransferInputCubit>()..loadTransferInput(),
            ),
            BlocProvider(
              create: (context) => sl<TransferCubit>(),
            ),
          ],
          child: TransferDetailsScreen(
            bank: data['bank'],
            accountNumber: data['accountNumber'],
            username: data['username'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/transfer-input-pin',
      pageBuilder: (context, state) =>
          const MaterialPage(child: TransferInputPinScreen()),
    ),
    GoRoute(
        path: '/transfer-result-success',
        pageBuilder: (context, state) {
          final data = state.extra as TransferEntitiy;
          return MaterialPage(
            child: TransferSuccessScreen(
              data: data,
            ),
          );
        }),

    /// HISTORY
    GoRoute(
      path: '/history',
      pageBuilder: (context, state) =>
          const MaterialPage(child: HistoryScreen()),
    ),

    /// SETTINGS
    /// SETTINGS
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),

    GoRoute(
      path: '/settings-detail',
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};

        return MaterialPage(
          child: SettingDetailScreen(
            title: args['title'] ?? 'Detail Pengaturan',
            currentValue: args['currentValue'] ?? '',
            description: args['description'] ?? 'Deskripsi tidak tersedia.',
            isPassword: args['isPassword'] ?? false,
            isPin: args['isPin'] ?? false,
            initialPin: args['initialPin'],
          ),
        );
      },
    ),
  ],
);
