import 'package:get_it/get_it.dart';
import 'package:mobile_banking_apps/features/history/presentation/cubit/history_cubit.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';

Future<void> initHistoryModule(GetIt sl) async {
  sl.registerFactory(
    () => HistoryCubit(sl<HomeRepository>()),
  );
}
