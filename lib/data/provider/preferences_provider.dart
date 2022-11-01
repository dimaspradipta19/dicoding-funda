import 'package:dicoding_restaurant_app/data/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}){
    _getDailyRestosPreferences();
  }

  bool _isDailyRestosActive = false;
  bool get isDailyRestosActive => _isDailyRestosActive;

  void _getDailyRestosPreferences() async {
    _isDailyRestosActive = await preferencesHelper.isDailyRestosActive;
    notifyListeners();
  }

  void enableDailyRestos(bool value) {
    preferencesHelper.setDailyRestos(value);
    _getDailyRestosPreferences();
  }
}
