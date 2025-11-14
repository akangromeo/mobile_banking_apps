import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';

class BalanceModel {
  final String username;
  final double balance;

  BalanceModel({
    required this.username,
    required this.balance,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      username: json['username'],
      balance: json['balance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'balance': balance,
    };
  }

  factory BalanceModel.fromEntity(BalanceEntity entity) {
    return BalanceModel(
      username: entity.username,
      balance: entity.balance,
    );
  }

  BalanceEntity toEntity() {
    return BalanceEntity(
      username: username,
      balance: balance,
    );
  }
}
