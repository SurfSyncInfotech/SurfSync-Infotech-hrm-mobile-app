import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/app/theme/app_text_styles.dart';
import 'package:hrms_app/core/widgets/app_empty_state.dart';
import 'package:hrms_app/core/widgets/app_status_chip.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

import '../controllers/attendance_controller.dart';
import '../widgets/employee_attendance_card.dart';

class EmployeeAttendanceView extends GetView<AttendanceController> {
  const EmployeeAttendanceView({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final attendanceController = controller;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final content = Obx(() {
      final history = attendanceController.attendance.historyFor(
        attendanceController.directory.current.id,
      );
      return ListView(
        children: [
          Text(
            'Attendance',
            style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colors.onSurface,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Today’s punch and your previous records share the same attendance data.',
            style: AppTextStyles.bodyMuted
                .copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          const EmployeeAttendanceCard(),
          const SizedBox(height: 18),
          Text(
            'History',
            style: AppTextStyles.heading3.copyWith(color: colors.onSurface),
          ),
          const SizedBox(height: 8),
          if (history.isEmpty)
            const AppEmptyState(
              title: 'No attendance history yet',
              message: 'Completed punches will appear here.',
              icon: Icons.history_rounded,
            )
          else
            ...history.map(
              (record) => Card(
                child: ListTile(
                  title: Text(
                    DateFormat('EEE, d MMM yyyy').format(record.date),
                    style: AppTextStyles.bodyBold
                        .copyWith(color: colors.onSurface),
                  ),
                  subtitle: Text(
                    'In ${attendanceController.formatTime(record.checkIn)} · Out ${attendanceController.formatTime(record.checkOut)}'
                    '${record.locationLabel == null ? '' : ' · ${record.locationLabel}'}',
                    style: AppTextStyles.bodyMuted
                        .copyWith(color: colors.onSurfaceVariant),
                  ),
                  trailing: AppStatusChip.auto(
                    record.checkOut != null
                        ? 'Completed'
                        : record.checkIn != null
                            ? 'Checked in'
                            : 'Absent',
                  ),
                ),
              ),
            ),
        ],
      );
    });

    if (embedded) return content;
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeAttendance,
      scrollBody: false,
      child: content,
    );
  }
}
