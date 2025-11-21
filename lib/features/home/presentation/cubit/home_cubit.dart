import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/usecases/get_balance_usecase.dart';
import 'package:mobile_banking_apps/features/home/domain/usecases/get_cards_usecase.dart';
import 'package:mobile_banking_apps/features/home/domain/usecases/get_transaction_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetBalanceUsecase getBalanceUsecase;
  final GetCardsUsecase getCardsUsecase;
  final GetTransactionUsecase getTransactionUsecase;

  HomeCubit(
    this.getBalanceUsecase,
    this.getCardsUsecase,
    this.getTransactionUsecase,
  ) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    try {
      final balanceResult = await getBalanceUsecase.call();
      final cardsResult = await getCardsUsecase.call();
      final transactionsResult = await getTransactionUsecase.call();

      balanceResult.fold(
        (failure) => emit(HomeError(failure.toString())),
        (balance) {
          cardsResult.fold(
            (failure) => emit(HomeError(failure.toString())),
            (cards) {
              transactionsResult.fold(
                (failure) => emit(HomeError(failure.toString())),
                (transactions) {
                  emit(
                    HomeLoaded(
                      balance: balance,
                      cards: cards,
                      transactions: transactions,
                    ),
                  );
                },
              );
            },
          );
        },
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
