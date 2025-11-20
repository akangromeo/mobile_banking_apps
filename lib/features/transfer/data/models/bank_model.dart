import 'package:mobile_banking_apps/features/transfer/domain/entities/bank_entity.dart';

class BankModel {
  final String bankCode;
  final String bankName;
  final String country;

  BankModel({
    required this.bankCode,
    required this.bankName,
    required this.country,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      bankCode: json['bank_code'],
      bankName: json['bank_name'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bank_code': bankCode,
      'bank_name': bankName,
      'country': country,
    };
  }

  factory BankModel.fromEntity(BankEntity entity) {
    return BankModel(
      bankCode: entity.bankCode,
      bankName: entity.bankName,
      country: entity.country,
    );
  }

  BankEntity toEntity() {
    return BankEntity(
      bankCode: bankCode,
      bankName: bankName,
      country: country,
    );
  }
}
