import 'package:dartz/dartz.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, ProfileEntity>> getProfile();
}
