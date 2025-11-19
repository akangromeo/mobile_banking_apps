part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistoryLoaded extends HistoryState {
  final List<TransactionEntity> transactions;

  HistoryLoaded({required this.transactions});
}

final class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
