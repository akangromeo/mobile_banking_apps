part of 'beneficiary_cubit.dart';

enum BeneficiaryStatus { initial, loading, success, error }

class BeneficiaryState extends Equatable {
  final BeneficiaryStatus status;
  final BeneficiaryEntity? data;
  final String? message;

  BeneficiaryState({
    this.status = BeneficiaryStatus.initial,
    this.data,
    this.message,
  });

  BeneficiaryState copyWith({
    BeneficiaryStatus? status,
    BeneficiaryEntity? data,
    String? message,
  }) {
    return BeneficiaryState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}

class Equatable {}
