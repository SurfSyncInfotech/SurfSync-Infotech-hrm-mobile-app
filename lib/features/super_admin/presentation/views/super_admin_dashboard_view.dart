import 'package:flutter/material.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../shared/layouts/super_admin_layout.dart';

class SuperAdminDashboardView extends StatelessWidget {
  const SuperAdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SuperAdminLayout(
      currentRoute: AppRoutes.superDashboard,
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
              'System overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Active companies: 14\nUsers: 2,340\nMonthly recurring revenue: \$42,500\nPayments processed: 96%',
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
