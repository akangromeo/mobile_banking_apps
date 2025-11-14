import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  static const _keyToken = "TOKEN";

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyToken, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyToken);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyToken);
  }

  Future<bool> isLoggedIn() async {
    return (await getToken()) != null;
  }
}
