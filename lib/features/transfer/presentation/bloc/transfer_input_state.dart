part of 'transfer_input_cubit.dart';

@immutable
sealed class TransferInputState {}

final class TransferInputInitial extends TransferInputState {}

final class TransferInputLoading extends TransferInputState {}

final class TransferInputLoaded extends TransferInputState {
  final List<MethodEntity> methods;
  final BalanceEntity balance;
  final List<CardEntity> cards;

  TransferInputLoaded({
    required this.methods,
    required this.balance,
    required this.cards,
  });
}

final class TransferInputError extends TransferInputState {
  final String message;

  TransferInputError(this.message);
}
