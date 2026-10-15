import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

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

  // Status
  static const success = Color(0xFF0F6B4D);
  static const successBg = Color(0xFFE3F2EC);
  static const warning = Color(0xFFB45309);
  static const warningBg = Color(0xFFFDEBD8);
  static const danger = Color(0xFFB42318);
  static const dangerBg = Color(0xFFFCE4E0);
  static const info = Color(0xFF1D6FA5);
  static const infoBg = Color(0xFFE0EEF7);
  static const neutralBg = Color(0xFFEEF2F0);

  static const loginGradient = [
    Color(0xFFEA6F1A),
    Color(0xFF9DAA8F),
    Color(0xFF55C2D6),
  ];
}
