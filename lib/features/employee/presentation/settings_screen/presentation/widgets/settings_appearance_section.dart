import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app/theme/theme_controller.dart';

class SettingsAppearanceSection extends StatelessWidget {
  const SettingsAppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outline),
      ),
      child: GetBuilder<ThemeController>(
        builder: (themeController) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Appearance',
              style: TextStyle(
                color: colors.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose how SurfSync looks on this device.',
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _ThemeChoice(
                  label: 'System Default',
                  icon: Icons.settings_brightness_rounded,
                  mode: ThemeMode.system,
                  selected: themeController.themeMode == ThemeMode.system,
                  onSelected: themeController.changeThemeMode,
                ),
                _ThemeChoice(
                  label: 'Light Mode',
                  icon: Icons.light_mode_rounded,
                  mode: ThemeMode.light,
                  selected: themeController.themeMode == ThemeMode.light,
                  onSelected: themeController.changeThemeMode,
                ),
                _ThemeChoice(
                  label: 'Dark Mode',
                  icon: Icons.dark_mode_rounded,
                  mode: ThemeMode.dark,
                  selected: themeController.themeMode == ThemeMode.dark,
                  onSelected: themeController.changeThemeMode,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeChoice extends StatelessWidget {
  const _ThemeChoice({
    required this.label,
    required this.icon,
    required this.mode,
    required this.selected,
    required this.onSelected,
  });

  final String label;
  final IconData icon;
  final ThemeMode mode;
  final bool selected;
  final ValueChanged<ThemeMode> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      selected: selected,
      onSelected: (_) => onSelected(mode),
    );
  }
}
