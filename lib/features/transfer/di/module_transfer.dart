import 'package:get_it/get_it.dart';
import 'package:mobile_banking_apps/core/network/api_client.dart';
import 'package:mobile_banking_apps/core/services/auth_service.dart';
import 'package:mobile_banking_apps/features/home/domain/usecases/get_balance_usecase.dart';
import 'package:mobile_banking_apps/features/home/domain/usecases/get_cards_usecase.dart';
import 'package:mobile_banking_apps/features/transfer/data/datasources/remote/transfer_remote_datasource.dart';
import 'package:mobile_banking_apps/features/transfer/data/repositories/transfer_repository_impl.dart';
import 'package:mobile_banking_apps/features/transfer/domain/repositories/transfer_repository.dart';
import 'package:mobile_banking_apps/features/transfer/domain/usecases/check_beneficiary_usecase.dart';
import 'package:mobile_banking_apps/features/transfer/domain/usecases/get_banks_usecase.dart';
import 'package:mobile_banking_apps/features/transfer/domain/usecases/get_methods_usecase.dart';
import 'package:mobile_banking_apps/features/transfer/domain/usecases/post_transfer_usecase.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/bloc/bank_cubit.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/bloc/beneficiary_cubit.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/bloc/transfer_cubit.dart';
import 'package:mobile_banking_apps/features/transfer/presentation/bloc/transfer_input_cubit.dart';

Future<void> initTransferModule(GetIt sl) async {
  sl.registerLazySingleton<TransferRemoteDatasource>(
    () => TransferRemoteDatasourceImpl(
      apiClient: sl<ApiClient>(),
      authService: sl<AuthService>(),
    ),
  );

  //repository
  sl.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImpl(
      transferRemoteDatasource: sl<TransferRemoteDatasource>(),
    ),
  );

  //usecase
  sl.registerLazySingleton<GetBanksUsecase>(
    () => GetBanksUsecase(
      sl<TransferRepository>(),
    ),
  );
  sl.registerLazySingleton<GetMethodsUsecase>(
    () => GetMethodsUsecase(
      sl<TransferRepository>(),
    ),
  );
  sl.registerLazySingleton<PostTransferUsecase>(
    () => PostTransferUsecase(
      sl<TransferRepository>(),
    ),
  );
  sl.registerLazySingleton<CheckBeneficiaryUsecase>(
    () => CheckBeneficiaryUsecase(
      sl<TransferRepository>(),
    ),
  );

  //cubit
  sl.registerFactory(
    () => BankCubit(
      sl<GetBanksUsecase>(),
    ),
  );
  sl.registerFactory(
    () => TransferInputCubit(
      sl<GetMethodsUsecase>(),
      sl<GetBalanceUsecase>(),
      sl<GetCardsUsecase>(),
    ),
  );
  sl.registerFactory(
    () => TransferCubit(
      sl<PostTransferUsecase>(),
    ),
  );
  sl.registerFactory(
    () => BeneficiaryCubit(
      sl<CheckBeneficiaryUsecase>(),
    ),
  );
}
