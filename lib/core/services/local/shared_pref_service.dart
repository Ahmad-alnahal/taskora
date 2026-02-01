

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _seenOnboardingKey = 'seen_onboarding';

  final SharedPreferences _prefs;

  SharedPrefService(this._prefs);

  bool get hasSeenOnboarding {
    return _prefs.getBool(_seenOnboardingKey) ?? false;
  }

  Future<void> setSeenOnboarding() async {
    await _prefs.setBool(_seenOnboardingKey, true);
  }
}
