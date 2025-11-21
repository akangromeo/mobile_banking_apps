import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.username,
    required super.email,
    required super.firstName,
    required super.lastName,
    required super.birthdate,
    required super.isActive,
    required super.is2faEnabled,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      birthdate: json['birthdate'] ?? '',
      isActive: json['is_active'] ?? false,
      is2faEnabled: json['is_2fa_enabled'] ?? false,
    );
  }
}
