import 'package:flutter/material.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../shared/layouts/admin_layout.dart';

class AdminAttendanceView extends StatelessWidget {
  const AdminAttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AdminLayout(
      currentRoute: AppRoutes.adminAttendance,
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
              'Attendance monitor',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Present: 96\nLate arrivals: 7\nAbsent: 3\nWFH: 12\nAverage punctuality: 94.8%',
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
