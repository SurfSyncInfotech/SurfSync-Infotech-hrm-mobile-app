import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_dimensions.dart';

abstract class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final palette = isDark ? AppColors.dark : AppColors.light;
    final scheme = ColorScheme(
      brightness: brightness,
      primary: palette.primary,
      onPrimary: palette.onPrimary,
      primaryContainer:
          isDark ? const Color(0xFF1B3D31) : const Color(0xFFE3F3EC),
      onPrimaryContainer:
          isDark ? const Color(0xFFA5E6C8) : const Color(0xFF0B4234),
      secondary: palette.secondary,
      onSecondary: isDark ? const Color(0xFF082E22) : Colors.white,
      secondaryContainer:
          isDark ? const Color(0xFF3D2A14) : const Color(0xFFFEF3E2),
      onSecondaryContainer:
          isDark ? const Color(0xFFFFC078) : const Color(0xFFB45309),
      tertiary: isDark ? const Color(0xFF78C0F0) : const Color(0xFF1D6FA5),
      onTertiary: isDark ? const Color(0xFF082233) : Colors.white,
      tertiaryContainer:
          isDark ? const Color(0xFF132A3B) : const Color(0xFFE0EEF7),
      onTertiaryContainer:
          isDark ? const Color(0xFF9FD4F7) : const Color(0xFF13537D),
      error: isDark ? const Color(0xFFFFB4AB) : AppColors.danger,
      onError: isDark ? const Color(0xFF690005) : Colors.white,
      errorContainer:
          isDark ? const Color(0xFF3F1616) : const Color(0xFFFDE8E8),
      onErrorContainer:
          isDark ? const Color(0xFFFF8E88) : const Color(0xFF9B1C1C),
      surface: palette.surface,
      onSurface: palette.textPrimary,
      onSurfaceVariant: palette.textSecondary,
      surfaceContainerHighest: palette.surfaceMuted,
      surfaceContainer:
          isDark ? const Color(0xFF1E2C25) : const Color(0xFFF7FAF8),
      surfaceContainerLow:
          isDark ? const Color(0xFF16211C) : const Color(0xFFF0F5F2),
      outline: palette.border,
      outlineVariant:
          isDark ? const Color(0xFF2E3E36) : const Color(0xFFE2EBE6),
      shadow: Colors.black,
    );
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          borderSide: BorderSide(color: color, width: width),
        );

    final textTheme = GoogleFonts.interTextTheme(base.textTheme).apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    return base.copyWith(
      brightness: brightness,
      scaffoldBackgroundColor: palette.background,
      dividerColor: scheme.outline,
      textTheme: textTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? scheme.surfaceContainerHighest : scheme.surface,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        hintStyle: GoogleFonts.inter(
          color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
          fontSize: 14,
        ),
        labelStyle: GoogleFonts.inter(
          color: scheme.onSurfaceVariant,
          fontSize: 14,
        ),
        border: border(scheme.outline),
        enabledBorder: border(scheme.outline),
        focusedBorder: border(scheme.primary, 1.5),
        errorBorder: border(scheme.error),
        focusedErrorBorder: border(scheme.error, 1.5),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: scheme.surface,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: scheme.surface,
          systemNavigationBarIconBrightness:
              isDark ? Brightness.light : Brightness.dark,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          side: BorderSide(color: scheme.outline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: GoogleFonts.inter(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        selectedColor: scheme.primary.withValues(alpha: 0.16),
        labelStyle: GoogleFonts.inter(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          color: scheme.onSurface,
        ),
        side: BorderSide(color: scheme.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
          side: BorderSide(color: scheme.outline),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: scheme.surface,
        selectedItemColor: scheme.primary,
        unselectedItemColor: scheme.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showUnselectedLabels: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primary.withValues(alpha: 0.14),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.onSurfaceVariant,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => GoogleFonts.inter(
            color: states.contains(WidgetState.selected)
                ? scheme.primary
                : scheme.onSurfaceVariant,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
