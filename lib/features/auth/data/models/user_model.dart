import 'package:mobile_banking_apps/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String token;
  final String status;
  final String message;

  const UserModel({
    required this.token,
    required this.status,
    required this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? "",
      status: json['status'] ?? "",
      message: json['message'] ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
        'token': token,
        'status': status,
        'message': message,
      };

  UserEntity toEntity() {
    return UserEntity(token: token, status: status, message: message);
  }
}
