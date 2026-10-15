import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static const _storageKey = 'app_theme_mode';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode =>
      _themeMode == ThemeMode.dark ||
      (_themeMode == ThemeMode.system && Get.isDarkMode);

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
    _themeMode = switch (savedMode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    update();
  }
}
