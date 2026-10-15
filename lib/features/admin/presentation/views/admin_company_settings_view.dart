import 'package:flutter/material.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../shared/layouts/admin_layout.dart';

class AdminCompanySettingsView extends StatelessWidget {
  const AdminCompanySettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AdminLayout(
      currentRoute: AppRoutes.adminCompanySettings,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Organization details\nPolicies\nWorking hours\nNotification preferences\nHoliday calendar',
              style: TextStyle(
                fontSize: 14,
                height: 1.8,
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
