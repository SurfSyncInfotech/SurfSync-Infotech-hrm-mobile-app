import 'package:flutter/material.dart';

import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

class EmployeeSettingsDetailView extends StatelessWidget {
  const EmployeeSettingsDetailView({
    super.key,
    required this.title,
    required this.summary,
    this.bullets = const [],
  });

  final String title;
  final String summary;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeSettings,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  summary,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (bullets.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: colors.outline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...bullets.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item,
                              style: TextStyle(
                                color: colors.onSurfaceVariant,
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
