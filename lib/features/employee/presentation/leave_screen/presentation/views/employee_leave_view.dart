import 'package:flutter/material.dart';

import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/app/theme/app_text_styles.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

import '../widgets/leave_balance_section.dart';
import '../widgets/leave_history_section.dart';
import '../widgets/leave_request_form.dart';

class EmployeeLeaveView extends StatelessWidget {
  const EmployeeLeaveView({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final content = ListView(
      children: [
        Text(
          'Apply leave',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
                fontWeight: FontWeight.w800,
                color: colors.onSurface,
              ),
        ),
        // const SizedBox(height: 4),
        // Text(
        //   'Check your balance and submit leave requests for approval.',
        //   style: AppTextStyles.bodyMuted
        //       .copyWith(color: colors.onSurfaceVariant),
        // ),
        const SizedBox(height: 16),
        const LeaveBalanceSection(),
        const SizedBox(height: 20),
        const LeaveRequestForm(),
        const SizedBox(height: 20),
        const LeaveHistorySection(),
      ],
    );

    if (embedded) return content;
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeLeave,
      scrollBody: false,
      child: content,
    );
  }
}
