import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app/routes/app_routes.dart';
import '../../../../../../data/mock/mock_employee_data.dart';

class SettingsProfileCard extends StatelessWidget {
  const SettingsProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = MockEmployeeData.currentEmployee;
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBg = isDark ? colors.surface : colors.primary;
    final fg = isDark ? colors.onSurface : colors.onPrimary;
    final fgMuted = isDark
        ? colors.onSurfaceVariant
        : colors.onPrimary.withValues(alpha: 0.85);

    return Material(
      color: cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: isDark ? colors.outline : Colors.transparent),
      ),
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.employeeProfile),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isDark
                      ? colors.primary.withValues(alpha: 0.14)
                      : colors.onPrimary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: isDark ? colors.primary : colors.onPrimary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: TextStyle(
                        color: fg,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.designation,
                      style: TextStyle(
                        color: fgMuted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: isDark ? colors.onSurfaceVariant : colors.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
