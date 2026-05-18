import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/app_settings.dart';

class SettingsLocalDatasource {
  static const _keySeconds = 'autofocus_seconds';
  static const _keyEnabled = 'autofocus_enabled';

  Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    final seconds = prefs.getInt(_keySeconds) ?? AppSettings.defaults().autofocusSeconds;
    final enabled = prefs.getBool(_keyEnabled) ?? AppSettings.defaults().autofocusEnabled;
    return AppSettings(autofocusSeconds: seconds, autofocusEnabled: enabled);
  }

  Future<void> save(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keySeconds, settings.autofocusSeconds);
    await prefs.setBool(_keyEnabled, settings.autofocusEnabled);
  }
}
