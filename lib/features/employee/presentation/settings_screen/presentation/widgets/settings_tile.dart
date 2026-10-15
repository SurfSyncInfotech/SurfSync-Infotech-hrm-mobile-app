import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app/routes/app_routes.dart';
import '../controllers/settings_controller.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.item,
  });

  final SettingsItem item;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleTap(item),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: colors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        color: colors.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTap(SettingsItem item) {
    if (item.route != null && item.route != '/login') {
      Get.toNamed(item.route!);
      return;
    }

    if (item.route == '/login') {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    Get.snackbar(
      item.title,
      item.subtitle,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.inverseSurface,
      colorText: Get.theme.colorScheme.onInverseSurface,
      margin: const EdgeInsets.all(12),
    );
  }
}
