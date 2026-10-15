import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/app/theme/theme_controller.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

class EmployeeThemeSettingsView extends StatelessWidget {
  const EmployeeThemeSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeSettings,
      scrollBody: false,
      child: GetBuilder<ThemeController>(
        builder: (themeController) {
          final theme = Theme.of(context);
          final colors = theme.colorScheme;
          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              Text(
                'Appearance',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    _ThemeModeOption(
                      title: 'System default',
                      subtitle: 'Match your device appearance',
                      icon: Icons.settings_brightness_rounded,
                      selected: themeController.themeMode == ThemeMode.system,
                      onTap: () =>
                          themeController.changeThemeMode(ThemeMode.system),
                    ),
                    const Divider(height: 1, indent: 18, endIndent: 18),
                    _ThemeModeOption(
                      title: 'Light',
                      subtitle: 'A bright, clean appearance',
                      icon: Icons.light_mode_rounded,
                      selected: themeController.themeMode == ThemeMode.light,
                      onTap: () =>
                          themeController.changeThemeMode(ThemeMode.light),
                    ),
                    const Divider(height: 1, indent: 18, endIndent: 18),
                    _ThemeModeOption(
                      title: 'Dark',
                      subtitle: 'A darker appearance for low-light use',
                      icon: Icons.dark_mode_rounded,
                      selected: themeController.themeMode == ThemeMode.dark,
                      onTap: () =>
                          themeController.changeThemeMode(ThemeMode.dark),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                margin: EdgeInsets.zero,
                color: colors.surfaceContainerLow,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.devices_outlined, color: colors.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your preference is saved',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Your selection is applied immediately and saved on this device.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ThemeModeOption extends StatelessWidget {
  const _ThemeModeOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ListTile(
      onTap: onTap,
      selected: selected,
      selectedTileColor: colors.primary.withValues(alpha: 0.06),
      selectedColor: colors.primary,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: selected
              ? colors.primaryContainer
              : colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: selected ? colors.onPrimaryContainer : colors.onSurfaceVariant,
        ),
      ),
      trailing: selected
          ? Icon(Icons.check_circle_rounded, color: colors.primary)
          : Icon(Icons.circle_outlined, color: colors.outline),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}
