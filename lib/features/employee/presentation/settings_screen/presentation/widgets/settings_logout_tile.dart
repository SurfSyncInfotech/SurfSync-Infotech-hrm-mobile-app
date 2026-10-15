import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app/routes/app_routes.dart';

class SettingsLogoutTile extends StatelessWidget {
  const SettingsLogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outline),
      ),
      child: ListTile(
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: colors.errorContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.logout_rounded, color: colors.error, size: 20),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          'Sign out of the employee portal',
          style: TextStyle(
            color: colors.onSurfaceVariant,
            fontSize: 12,
          ),
        ),
        trailing:
            Icon(Icons.chevron_right_rounded, color: colors.onSurfaceVariant),
        onTap: () => Get.offAllNamed(AppRoutes.login),
      ),
    );
  }
}
