part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final BalanceEntity balance;
  final List<CardEntity> cards;
  final List<TransactionEntity> transactions;

  HomeLoaded({
    required this.balance,
    required this.cards,
    required this.transactions,
  });
}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
