import 'package:mobile_banking_apps/features/home/domain/entities/balance_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<BalanceEntity> getBalance() {
    // TODO: implement getBalance
    throw UnimplementedError();
  }

  @override
  Future<List<CardEntity>> getCards() {
    // TODO: implement getCards
    throw UnimplementedError();
  }
}
