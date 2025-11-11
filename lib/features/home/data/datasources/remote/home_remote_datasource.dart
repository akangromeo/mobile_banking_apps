import 'package:mobile_banking_apps/features/home/data/models/balance_model.dart';
import 'package:mobile_banking_apps/features/home/data/models/card_model.dart';

abstract class HomeRemoteDatasource {
  Future<List<CardModel>> getCards();
  Future<BalanceModel> getBalance();
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  @override
  Future<BalanceModel> getBalance() {
    // TODO: implement getBalance
    throw UnimplementedError();
  }

  @override
  Future<List<CardModel>> getCards() {
    // TODO: implement getCards
    throw UnimplementedError();
  }
}
