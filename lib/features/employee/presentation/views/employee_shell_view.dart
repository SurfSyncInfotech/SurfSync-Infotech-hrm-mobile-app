import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrms_app/features/employee/presentation/controllers/employee_shell_controller.dart';
import 'package:hrms_app/features/employee/presentation/daily_report_screen/presentation/views/employee_daily_report_view.dart';
import 'package:hrms_app/features/employee/presentation/home_screen/presentation/views/employee_home_view.dart';
import 'package:hrms_app/features/employee/presentation/leave_screen/presentation/views/employee_leave_view.dart';
import 'package:hrms_app/features/employee/presentation/profile_screen/presentation/views/employee_profile_view.dart';
import 'package:hrms_app/features/employee/presentation/settings_screen/presentation/views/settings_view.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

class EmployeeShellView extends GetView<EmployeeShellController> {
  const EmployeeShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeShellController>(
      builder: (shellController) => EmployeeLayout(
        currentRoute: shellController.currentRoute,
        scrollBody: false,
        onBottomNavTap: shellController.selectTab,
        child: IndexedStack(
          index: shellController.tabIndex,
          children: const [
            EmployeeHomeView(embedded: true),
            EmployeeProfileView(embedded: true),
            EmployeeDailyReportView(embedded: true),
            EmployeeLeaveView(embedded: true),
            SettingsView(embedded: true),
          ],
        ),
      ),
    );
  }
}
