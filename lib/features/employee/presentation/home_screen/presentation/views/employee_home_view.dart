import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/features/employee/presentation/attendance_screen/presentation/widgets/employee_attendance_card.dart';
import 'package:hrms_app/features/employee/presentation/home_screen/presentation/controllers/home_controller.dart';
import 'package:hrms_app/features/employee/presentation/home_screen/presentation/widgets/live_session_tracking_card.dart';
import 'package:hrms_app/features/employee/presentation/home_screen/presentation/widgets/todays_activity_card.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

class EmployeeHomeView extends GetView<HomeController> {
  const EmployeeHomeView({super.key, this.embedded = false});

  final bool embedded;

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
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${controller.greeting}, ${controller.firstName}',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w600,
            height: 1.10,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Mark your attendance and keep an eye on your day.',
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: colors.onSurfaceVariant),
        ),
        const SizedBox(height: 20),
        const EmployeeAttendanceCard(),
        const SizedBox(height: 14),
        const TodaysActivityCard(),
        const SizedBox(height: 14),
        const LiveSessionTrackingCard(),
      ],
    );

    if (embedded) return content;
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeDashboard,
      scrollBody: false,
      child: content,
    );
  }
}
