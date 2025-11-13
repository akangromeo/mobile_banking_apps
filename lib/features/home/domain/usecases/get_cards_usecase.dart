import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/home/domain/entities/card_entity.dart';
import 'package:mobile_banking_apps/features/home/domain/repositories/home_repository.dart';

class GetCardsUsecase {
  final HomeRepository repository;

  GetCardsUsecase(this.repository);

  Future<Either<String, List<CardEntity>>> call() {
    return repository.getCards();
  }
}
