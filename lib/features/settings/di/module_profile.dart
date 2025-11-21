// features/profile/di/module_profile.dart
import 'package:get_it/get_it.dart';
import 'package:mobile_banking_apps/features/settings/data/datasources/remote/profile_remote_data_source.dart';
import 'package:mobile_banking_apps/features/settings/domain/repositories/profile_repository.dart';
import 'package:mobile_banking_apps/features/settings/presentation/bloc/profile_cubit.dart';

import '../data/repositories/profile_repository_impl.dart';
import '../domain/usecases/get_profile_usecase.dart';

Future<void> initProfileModule(GetIt sl) async {
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerFactory(
    () => GetProfileUseCase(sl()),
  );

  sl.registerFactory(
    () => ProfileCubit(sl()),
  );
}
