import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';

class CardModel {
  final String cardNumber;
  final String cardType;
  final String expiry;
  final String activateAt;

  CardModel({
    required this.cardNumber,
    required this.cardType,
    required this.expiry,
    required this.activateAt,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardNumber: json['card_number'] ?? '',
      cardType: json['card_type'] ?? '',
      expiry: json['expiry'] ?? '',
      activateAt: json['activateAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      cardNumber: cardNumber,
      cardType: cardType,
      expiry: expiry,
      activateAt: activateAt,
    };
  }

  factory CardModel.fromEntity(CardEntity entity) {
    return CardModel(
      cardNumber: entity.cardNumber,
      cardType: entity.cardType,
      expiry: entity.expiry,
      activateAt: entity.activateAt,
    );
  }

  CardEntity toEntity() {
    return CardEntity(
      cardNumber: cardNumber,
      cardType: cardType,
      expiry: expiry,
      activateAt: activateAt,
    );
  }
}
