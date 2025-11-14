import 'package:get_it/get_it.dart';
import 'package:mobile_banking_apps/core/network/api_client.dart';
import 'package:mobile_banking_apps/features/home/di/module_home.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(),
  );

  await _initFeatureModules();
}

Future<void> _initFeatureModules() async {
  await initHomeModule(sl);
  // await initAuthModule(sl);
  // kalau nanti ada fitur lain, tambahkan juga di sini
}
