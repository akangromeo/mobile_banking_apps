part of 'bank_cubit.dart';

@immutable
sealed class BankState {}

final class BankInitial extends BankState {}

final class BankLoading extends BankState {}

final class BankLoaded extends BankState {
  final List<BankEntity> banks;

  BankLoaded({
    required this.banks,
  });
}

final class BankError extends BankState {
  final String message;

  BankError(this.message);
}
