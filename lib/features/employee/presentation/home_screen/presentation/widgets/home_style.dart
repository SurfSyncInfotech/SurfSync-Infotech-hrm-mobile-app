import 'package:flutter/material.dart';

/// Shared look for the home screen cards (works in light + dark).
class HomeStyle {
  HomeStyle._();

  static bool isDark(BuildContext c) =>
      Theme.of(c).brightness == Brightness.dark;

  static Color _shade(Color c, double lightnessFactor) {
    final hsl = HSLColor.fromColor(c);
    return hsl
        .withLightness((hsl.lightness * lightnessFactor).clamp(0.0, 1.0))
        .toColor();
  }

  /// Deep brand gradient used by the green header bands.
  static LinearGradient heroGradient(BuildContext c) {
    final colors = Theme.of(c).colorScheme;
    if (isDark(c)) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          _shade(colors.primary, 0.55),
          _shade(colors.primary, 0.38),
        ],
      );
    }
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [_shade(colors.primary, 0.85), _shade(colors.primary, 1.1)],
    );
  }

  /// Text/icon color that sits on [heroGradient].
  static Color onHero(BuildContext c) => Colors.white;

  static List<BoxShadow> softShadow(BuildContext c) => isDark(c)
      ? const []
      : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ];

  static BoxDecoration card(BuildContext c, {double radius = 20}) {
    final colors = Theme.of(c).colorScheme;
    return BoxDecoration(
      color: colors.surface,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: colors.outlineVariant.withValues(alpha: 0.8)),
      boxShadow: softShadow(c),
    );
  }
}
