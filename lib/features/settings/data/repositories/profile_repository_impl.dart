import 'package:dartz/dartz.dart';
import 'package:mobile_banking_apps/core/exceptions/app_exception.dart';
import 'package:mobile_banking_apps/features/settings/data/datasources/remote/profile_remote_data_source.dart';
import 'package:mobile_banking_apps/features/settings/domain/entities/profile_entity.dart';
import 'package:mobile_banking_apps/features/settings/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<String, ProfileEntity>> getProfile() async {
    try {
      final profile = await remoteDataSource.getProfile();
      return Right(profile);
    } on UnauthorizedException {
      return Left("unauthorized");
    } on AppException catch (e) {
      return Left(e.message);
    } catch (e) {
      return Left("Unexpected error: $e");
    }
  }
}
