import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/bank_entity.dart';
import 'package:mobile_banking_apps/features/transfer/domain/usecases/get_banks_usecase.dart';

part 'bank_state.dart';

class BankCubit extends Cubit<BankState> {
  final GetBanksUsecase getBanksUsecase;

  BankCubit(this.getBanksUsecase) : super(BankInitial());

  Future<void> loadBanks() async {
    emit(BankLoading());

    try {
      final banksResult = await getBanksUsecase.call();

      banksResult.fold(
        (failure) => emit(
          BankError(
            failure.toString(),
          ),
        ),
        (banks) => emit(
          BankLoaded(banks: banks),
        ),
      );
    } catch (e) {
      emit(BankError(e.toString()));
    }
  }
}
