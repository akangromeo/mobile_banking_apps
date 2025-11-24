import 'package:mobile_banking_apps/features/transfer/domain/entities/beneficiary_entitiy.dart';

class BeneficiaryModel {
  final String internalAccountNumber;
  final String firstName;
  final String lastName;
  final String fullName;
  final String message;

  BeneficiaryModel({
    required this.internalAccountNumber,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.message,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      internalAccountNumber: json['internal_account_number'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      fullName: json['full_name'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'internal_account_number': internalAccountNumber,
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'message': message,
    };
  }

  factory BeneficiaryModel.fromEntity(BeneficiaryEntity entity) {
    return BeneficiaryModel(
      internalAccountNumber: entity.internalAccountNumber,
      firstName: entity.firstName,
      lastName: entity.lastName,
      fullName: entity.fullName,
      message: entity.message,
    );
  }

  BeneficiaryEntity toEntity() {
    return BeneficiaryEntity(
      internalAccountNumber: internalAccountNumber,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
      message: message,
    );
  }
}
