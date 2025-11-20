part of 'transfer_cubit.dart';

enum TransferStatus { initial, loading, success, failure }

class TransferState extends Equatable {
  final TransferStatus status;
  final String? succesMessage;
  final String? errorMessage;

  const TransferState({
    this.status = TransferStatus.initial,
    this.succesMessage,
    this.errorMessage,
  });

  TransferState copyWith({
    TransferStatus? status,
    String? succesMessage,
    String? errorMessage,
  }) {
    return TransferState(
      status: status ?? this.status,
      succesMessage: succesMessage ?? this.succesMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        succesMessage,
        errorMessage,
      ];
}
