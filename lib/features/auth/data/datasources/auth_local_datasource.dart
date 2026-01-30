import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this.prefs);
  final SharedPreferences prefs;

  static const _kTokenKey = 'auth_token';

  Future<void> saveToken(String token) async {
    await prefs.setString(_kTokenKey, token);
  }

  Future<String?> getToken() async {
    return prefs.getString(_kTokenKey);
  }

  Future<void> clearToken() async {
    await prefs.remove(_kTokenKey);
  }
}
