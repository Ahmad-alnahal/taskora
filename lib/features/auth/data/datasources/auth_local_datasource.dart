import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this.prefs);
  final SharedPreferences prefs;

  static const _kTokenKey     = 'auth_token';
  static const _kWatchCostKey = 'auth_watch_cost';

  // Token
  Future<void> saveToken(String token) async {
    await prefs.setString(_kTokenKey, token);
  }

  Future<String?> getToken() async {
    return prefs.getString(_kTokenKey);
  }

  // hourly rate
  Future<void> saveWatchCost(double watchCost) async {
    await prefs.setDouble(_kWatchCostKey, watchCost);
  }

  double? getWatchCost() {
    return prefs.getDouble(_kWatchCostKey);
  }

  //  Clear all (logout)
  Future<void> clearToken() async {
    await prefs.remove(_kTokenKey);
    await prefs.remove(_kWatchCostKey);
  }
}
