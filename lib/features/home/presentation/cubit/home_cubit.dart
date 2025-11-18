import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    try {
      final balanceResult = await homeRepository.getBalance();
      final cardsResult = await homeRepository.getCards();
      final transactionsResult = await homeRepository.getTransactions();

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
