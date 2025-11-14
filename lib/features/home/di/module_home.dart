import 'package:get_it/get_it.dart';
import 'package:mobile_banking_apps/core/network/api_client.dart';
import 'package:mobile_banking_apps/core/services/auth_service.dart';
import 'package:mobile_banking_apps/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:mobile_banking_apps/features/home/data/repositories/home_repository_impl.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';
import 'package:mobile_banking_apps/features/home/presentation/cubit/home_cubit.dart';

Future<void> initHomeModule(GetIt sl) async {
  sl.registerLazySingleton<HomeRemoteDatasource>(
    () => HomeRemoteDatasourceImpl(
      sl<ApiClient>(),
      sl<AuthService>(),
    ),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeRemoteDatasource: sl<HomeRemoteDatasource>()),
  );

  sl.registerFactory(
    () => HomeCubit(sl<HomeRepository>()),
  );
}
