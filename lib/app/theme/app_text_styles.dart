import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heading1 =>
      GoogleFonts.sourceSans3(fontSize: 28, fontWeight: FontWeight.w700);
  static TextStyle get heading2 =>
      GoogleFonts.sourceSans3(fontSize: 20, fontWeight: FontWeight.w700);
  static TextStyle get heading3 =>
      GoogleFonts.sourceSans3(fontSize: 16, fontWeight: FontWeight.w700);
  static TextStyle get body => GoogleFonts.sourceSans3(fontSize: 14);
  static TextStyle get bodyMuted => GoogleFonts.sourceSans3(fontSize: 14);
  static TextStyle get bodyBold =>
      GoogleFonts.sourceSans3(fontSize: 14, fontWeight: FontWeight.w700);
  static TextStyle get overline => GoogleFonts.sourceSans3(
      fontSize: 11.5, fontWeight: FontWeight.w600, letterSpacing: 0.8);
  static TextStyle get button =>
      GoogleFonts.sourceSans3(fontSize: 14.5, fontWeight: FontWeight.w600);
  static TextStyle get chip => GoogleFonts.sourceSans3(
      fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 0.5);
}
