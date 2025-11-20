import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/usecases/get_balance_usecase.dart';
import 'package:mobile_banking_apps/features/home/domain/usecases/get_cards_usecase.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/method_entity.dart';
import 'package:mobile_banking_apps/features/transfer/domain/usecases/get_methods_usecase.dart';

part 'transfer_input_state.dart';

class TransferInputCubit extends Cubit<TransferInputState> {
  final GetMethodsUsecase getMethodsUsecase;
  final GetBalanceUsecase getBalanceUsecase;
  final GetCardsUsecase getCardsUsecase;

  TransferInputCubit(
    this.getMethodsUsecase,
    this.getBalanceUsecase,
    this.getCardsUsecase,
  ) : super(TransferInputInitial());

  Future<void> loadTransferInput() async {
    emit(TransferInputLoading());

    try {
      final methodResult = await getMethodsUsecase.call();
      final balanceResult = await getBalanceUsecase.call();
      final cardsResult = await getCardsUsecase.call();

      methodResult.fold(
        (failure) => emit(TransferInputError(failure.toString())),
        (methods) {
          cardsResult.fold(
            (failure) => emit(TransferInputError(failure.toString())),
            (cards) {
              balanceResult.fold(
                (failure) => emit(TransferInputError(failure.toString())),
                (balance) {
                  emit(
                    TransferInputLoaded(
                      balance: balance,
                      cards: cards,
                      methods: methods,
                    ),
                  );
                },
              );
            },
          );
        },
      );
    } catch (e) {
      emit(TransferInputError(e.toString()));
    }
  }
}
