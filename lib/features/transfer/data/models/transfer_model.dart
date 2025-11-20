import 'package:mobile_banking_apps/features/transfer/domain/entities/transfer_entitiy.dart';

class TransferModel {
  final double amount;
  final String description;
  final String recipientUname;
  final String externalBankName;
  final String externalAccNumber;

  TransferModel({
    required this.amount,
    required this.description,
    required this.recipientUname,
    required this.externalBankName,
    required this.externalAccNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      "recipient_username": recipientUname,
      "external_bank_name": externalBankName,
      "external_account_number": externalAccNumber,
    };
  }

  factory TransferModel.fromEntity(TransferEntitiy entity) {
    return TransferModel(
      amount: entity.amount,
      description: entity.description,
      recipientUname: entity.recipientUname,
      externalBankName: entity.externalBankName,
      externalAccNumber: entity.externalAccNumber,
    );
  }

  TransferEntitiy toEntity() {
    return TransferEntitiy(
      amount: amount,
      description: description,
      recipientUname: recipientUname,
      externalBankName: externalBankName,
      externalAccNumber: externalAccNumber,
    );
  }
}
