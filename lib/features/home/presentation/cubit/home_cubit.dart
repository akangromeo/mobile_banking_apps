import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit(this.homeRepository) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    try {
      final results = await Future.wait([
        homeRepository.getBalance(),
        homeRepository.getCards(),
      ]);

      emit(HomeLoaded(
        balance: results[0] as BalanceEntity,
        cards: results[1] as List<CardEntity>,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
