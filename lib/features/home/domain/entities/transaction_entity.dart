class TransactionEntity {
  final int id;
  final String type;
  final double amount;
  final String description;
  final String timestamp;
  final String status;

  TransactionEntity({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.timestamp,
    required this.status,
  });
}
