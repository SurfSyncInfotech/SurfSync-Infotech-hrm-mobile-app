import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  static const light = AppPalette(
    primary: Color(0xFF0F4F3E),
    onPrimary: Colors.white,
    secondary: Color(0xFF1A6B54),
    background: Color(0xFFEDF3EF),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF3F7F5),
    textPrimary: Color(0xFF14261F),
    textSecondary: Color(0xFF5B6B64),
    border: Color(0xFFDCE4E0),
  );
  static const dark = AppPalette(
    primary: Color(0xFF85D0AE),
    onPrimary: Color(0xFF082E22),
    secondary: Color(0xFFA7E2C5),
    background: Color(0xFF121A16),
    surface: Color(0xFF1D2A24),
    surfaceMuted: Color(0xFF293830),
    textPrimary: Color(0xFFE5EEE9),
    textSecondary: Color(0xFFB2C2BA),
    border: Color(0xFF405249),
  );

  // Brand
  static const forest = Color(0xFF0F4F3E);
  static const forestDark = Color(0xFF0B3D30);
  static const forestLight = Color(0xFF1A6B54);
  static const orange = Color(0xFFEA6F1A);
  static const orangeDark = Color(0xFFB45309);

  // Surfaces
  static const background = Color(0xFFEDF1EF);
  static const surface = Colors.white;
  static const surfaceMuted = Color(0xFFF6F9F8);
  static const border = Color(0xFFDCE4E0);

  // Text
  static const textPrimary = Color(0xFF14261F);
  static const textSecondary = Color(0xFF5B6B64);
  static const sidebarText = Color(0xFFCFE3DA);

  // Status - Light
  static const success = Color(0xFF0F6B4D);
  static const successBg = Color(0xFFE3F2EC);
  static const warning = Color(0xFFB45309);
  static const warningBg = Color(0xFFFDEBD8);
  static const danger = Color(0xFFB42318);
  static const dangerBg = Color(0xFFFCE4E0);
  static const info = Color(0xFF1D6FA5);
  static const infoBg = Color(0xFFE0EEF7);
  static const neutralBg = Color(0xFFEEF2F0);

  // Status - Dark
  static const successDark = Color(0xFF7BE4B5);
  static const successBgDark = Color(0xFF0F3627);
  static const warningDark = Color(0xFFFFB866);
  static const warningBgDark = Color(0xFF3D270F);
  static const dangerDark = Color(0xFFFF8E88);
  static const dangerBgDark = Color(0xFF3D1414);
  static const infoDark = Color(0xFF78C0F0);
  static const infoBgDark = Color(0xFF132A3B);
  static const neutralBgDark = Color(0xFF24332C);

  static const loginGradient = [
    Color(0xFF0B3D30),
    Color(0xFF1A6B54),
    Color(0xFF3D9B78),
  ];
}

class AppPalette {
  const AppPalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
  });

  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
}
