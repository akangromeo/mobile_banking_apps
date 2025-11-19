import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mobile_banking_apps/core/network/api_client.dart';
import 'package:mobile_banking_apps/core/services/auth_service.dart';
import 'package:mobile_banking_apps/features/auth/di/auth_module.dart';
import 'package:mobile_banking_apps/features/history/di/history_module.dart';
import 'package:mobile_banking_apps/features/home/di/module_home.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final authBox = await Hive.openBox('authBox');

  sl.registerLazySingleton<AuthService>(() => AuthService(authBox));

  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(authBox),
  );

  await _initFeatureModules();
}

Future<void> _initFeatureModules() async {
  await initHomeModule(sl);
  await initAuthModule(sl);
  await initHistoryModule(sl);
  // kalau nanti ada fitur lain, tambahkan juga di sini
}
