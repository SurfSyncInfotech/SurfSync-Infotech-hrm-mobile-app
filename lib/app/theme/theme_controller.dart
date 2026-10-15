import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const _storageKey = 'app_theme_mode';

  ThemeController({ThemeMode initialMode = ThemeMode.system})
      : _themeMode = initialMode;

  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode {
    if (_themeMode == ThemeMode.dark) return true;
    if (_themeMode == ThemeMode.light) return false;
    return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
  }

  @override
  void onInit() {
    super.onInit();
    _restoreThemeMode();
  }

  void toggleTheme() {
    changeThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  Future<void> changeThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    Get.changeThemeMode(mode);
    update();

    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setString(_storageKey, mode.name);
    if (!saved) {
      Get.snackbar(
        'Theme not saved',
        'Your theme changed, but the preference could not be saved.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _restoreThemeMode() async {
    final preferences = await SharedPreferences.getInstance();
    final savedMode = preferences.getString(_storageKey);
    final restored = switch (savedMode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    _themeMode = restored;
    Get.changeThemeMode(restored);
    update();
  }
}
