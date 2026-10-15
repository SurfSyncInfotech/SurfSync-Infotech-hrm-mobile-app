import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/features/employee/presentation/attendance_screen/presentation/widgets/employee_attendance_card.dart';
import 'package:hrms_app/features/employee/presentation/home_screen/presentation/controllers/home_controller.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

class _QuickAction {
  const _QuickAction({
    required this.label,
    required this.icon,
    required this.route,
  });

  final String label;
  final IconData icon;
  final String route;
}

class EmployeeHomeView extends GetView<HomeController> {
  const EmployeeHomeView({super.key, this.embedded = false});

  final bool embedded;

  static const List<_QuickAction> _actions = [
    _QuickAction(
      label: 'Apply Leave',
      icon: Icons.event_available_outlined,
      route: AppRoutes.employeeLeave,
    ),
    _QuickAction(
      label: 'Work Report',
      icon: Icons.description_outlined,
      route: AppRoutes.employeeDailyReport,
    ),
    _QuickAction(
      label: 'Payslips',
      icon: Icons.payments_outlined,
      route: AppRoutes.employeePayslips,
    ),
    _QuickAction(
      label: 'Mailbox',
      icon: Icons.mail_outline_rounded,
      route: AppRoutes.employeeMailbox,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final content = ListView(
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        Text(
          DateFormat('EEEE, d MMMM').format(controller.today),
          style: theme.textTheme.labelLarge?.copyWith(
            color: colors.onSurfaceVariant,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${controller.greeting}, ${controller.firstName}',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colors.onSurface,
            fontSize: 25,
            fontWeight: FontWeight.w700,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 20),
        const EmployeeAttendanceCard(),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => Get.toNamed(AppRoutes.employeeAttendance),
            icon: const Icon(Icons.arrow_forward_rounded),
            label: const Text('View Attendance'),
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final columnCount = constraints.maxWidth >= 640 ? 4 : 2;
            const gap = 12.0;
            final itemWidth =
                (constraints.maxWidth - gap * (columnCount - 1)) / columnCount;

            return Wrap(
              spacing: gap,
              runSpacing: 12,
              children: _actions.map((action) {
                return SizedBox(
                  width: itemWidth,
                  child: _QuickActionCard(
                    label: action.label,
                    icon: action.icon,
                    onTap: () => _handleAction(action),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );

    if (embedded) return content;
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeDashboard,
      scrollBody: false,
      child: content,
    );
  }

  void _handleAction(_QuickAction action) {
    switch (action.route) {
      case AppRoutes.employeeLeave:
        Get.toNamed(AppRoutes.employeeLeave);
        return;
      case AppRoutes.employeeDailyReport:
        Get.toNamed(AppRoutes.employeeDailyReport);
        return;
      case AppRoutes.employeePayslips:
        Get.toNamed(AppRoutes.employeePayslips);
        return;
      case AppRoutes.employeeMailbox:
        Get.snackbar(
          'Coming soon',
          '${action.label} is being added.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      default:
        break;
    }
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        constraints: const BoxConstraints(minHeight: 88),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: colors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: colors.primary.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: colors.onPrimaryContainer,
                size: 21,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
