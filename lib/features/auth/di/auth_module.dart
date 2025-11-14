import 'package:get_it/get_it.dart';
import 'package:mobile_banking_apps/core/network/api_client.dart';
import 'package:mobile_banking_apps/features/auth/data/datasources/remote/auth_remote_data_source.dart';

import 'package:mobile_banking_apps/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mobile_banking_apps/features/auth/domain/repositories/auth_repository.dart';
import 'package:mobile_banking_apps/features/auth/domain/usecases/login_usecase.dart';
import 'package:mobile_banking_apps/features/auth/presentation/bloc/login_cubit.dart';

Future<void> initAuthModule(GetIt sl) async {
  // Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<ApiClient>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl<AuthRemoteDataSource>(),
    ),
  );

  // Usecase
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );

  sl.registerFactory<LoginCubit>(
    () => LoginCubit(sl<LoginUseCase>()),
  );
}
