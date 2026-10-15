import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_pages.dart';

/// Navigation helper. Routes that are declared but not yet built show a
/// friendly message instead of crashing, so sidebars are safe to click
/// during phased development.
abstract class AppNav {
  AppNav._();

  static bool isRegistered(String route) =>
      AppPages.pages.any((p) => p.name == route);

  /// Replace the current page (used by sidebars).
  static void go(String route) {
    if (Get.currentRoute == route) return;
    if (!_guard(route)) return;
    Get.offNamed(route);
  }

  /// Clear the stack and go (used after login / logout).
  static void goAll(String route) {
    if (!_guard(route)) return;
    Get.offAllNamed(route);
  }

  static bool _guard(String route) {
    if (isRegistered(route)) return true;
    Get.snackbar(
      'Coming in a later phase',
      'This screen has not been built yet.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      maxWidth: 420,
      duration: const Duration(seconds: 2),
    );
    return false;
  }
}
