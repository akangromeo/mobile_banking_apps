import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/features/transfer/domain/entities/transfer_entitiy.dart';
import 'package:mobile_banking_apps/features/transfer/domain/repositories/transfer_repository.dart';

class PostTransferUsecase {
  final TransferRepository repository;

  PostTransferUsecase(this.repository);

  Future<Either<String, String>> call(TransferEntitiy payload) {
    return repository.postTransfer(payload);
  }
}
