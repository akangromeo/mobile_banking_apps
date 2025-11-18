import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HomeRepository homeRepository;
  HistoryCubit(this.homeRepository) : super(HistoryInitial());

  Future<void> loadHistoryData() async {
    emit(HistoryLoading());

    try {
      final transactionsResult = await homeRepository.getTransactions();

      transactionsResult.fold(
        (failure) => emit(HistoryError(failure.toString())),
        (transactions) {
          emit(
            HistoryLoaded(
              transactions: transactions,
            ),
          );
        },
      );
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
