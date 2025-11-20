import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/method_entity.dart';
import 'package:mobile_banking_apps/features/transfer/domain/repositories/transfer_repository.dart';

class GetMethodsUsecase {
  final TransferRepository repository;

  GetMethodsUsecase(this.repository);

  Future<Either<String, List<MethodEntity>>> call() {
    return repository.getMethods();
  }
}
