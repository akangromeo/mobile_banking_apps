import 'package:hive/hive.dart';

class AuthService {
  final Box authBox;

  AuthService(this.authBox);

  bool get isLoggedIn => authBox.get('token') != null;

  String? get token => authBox.get('token');

  void saveToken(String token) {
    authBox.put('token', token);
  }

  void logout() {
    authBox.delete('token');
  }
}
