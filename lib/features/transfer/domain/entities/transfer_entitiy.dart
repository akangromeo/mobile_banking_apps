class TransferEntitiy {
  final double amount;
  final String description;
  final String recipientUname;
  final String externalBankName;
  final String externalAccNumber;

  TransferEntitiy({
    required this.amount,
    required this.description,
    required this.recipientUname,
    required this.externalBankName,
    required this.externalAccNumber,
  });
}
