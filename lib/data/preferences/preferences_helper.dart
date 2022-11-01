import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const dailyRestos = 'DAILY_RESTOS';

  Future<bool> get isDailyRestosActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyRestos) ?? false;
  }

  void setDailyRestos(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyRestos, value);
  }
}
