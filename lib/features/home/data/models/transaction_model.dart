import 'package:mobile_banking_apps/features/home/domain/entities/transaction_entity.dart';

class TransactionModel {
  final int id;
  final String type;
  final double amount;
  final String description;
  final String timestamp;
  final String status;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.timestamp,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['transaction_id'] ?? 0,
      type: json['type'] ?? '',
      amount: json['amount'] ?? 0,
      description: json['description'] ?? '',
      timestamp: json['timestamp'] ?? '',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'type': type,
      'amount': amount.toString(),
      'description': description,
      'timestamp': timestamp,
      'status': status,
    };
  }

  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      id: entity.id,
      type: entity.type,
      amount: entity.amount,
      description: entity.description,
      timestamp: entity.timestamp,
      status: entity.status,
    );
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: id,
      type: type,
      amount: amount,
      description: description,
      timestamp: timestamp,
      status: status,
    );
  }
}
