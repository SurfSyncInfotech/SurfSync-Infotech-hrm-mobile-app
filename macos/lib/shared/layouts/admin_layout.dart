import 'package:flutter/material.dart';

import '../../app/routes/app_routes.dart';
import '../../core/constants/app_constants.dart';
import 'app_shell.dart';
import 'nav_item.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({
    super.key,
    required this.currentRoute,
    required this.child,
  });

  final String currentRoute;
  final Widget child;

  static const _groups = [
    NavGroup(label: 'Main', items: [
      NavItem(label: 'Dashboard', icon: Icons.dashboard_outlined, route: AppRoutes.hrDashboard),
    ]),
    NavGroup(label: 'Employee Management', items: [
      NavItem(label: 'Employees', icon: Icons.groups_outlined, route: AppRoutes.hrEmployees),
      NavItem(label: 'Add Employee', icon: Icons.person_add_alt_outlined, route: AppRoutes.hrAddEmployee),
      NavItem(label: 'Assets', icon: Icons.laptop_mac_rounded, route: AppRoutes.hrAssets),
    ]),
    NavGroup(label: 'Attendance & Leaves', items: [
      NavItem(label: 'Attendance', icon: Icons.access_time_rounded, route: AppRoutes.hrAttendance),
      NavItem(label: 'Leave Management', icon: Icons.event_available_outlined, route: AppRoutes.hrLeave),
    ]),
    NavGroup(label: 'Work & Performance', items: [
      NavItem(label: 'Daily Work Reports', icon: Icons.description_outlined, route: AppRoutes.hrDailyReports),
      NavItem(label: 'Performance & Targets', icon: Icons.task_alt_rounded, route: AppRoutes.hrTargets),
    ]),
    NavGroup(label: 'Company', items: [
      NavItem(label: 'Payroll & Payslips', icon: Icons.payments_outlined, route: AppRoutes.hrPayroll),
      NavItem(label: 'Announcements', icon: Icons.campaign_outlined, route: AppRoutes.hrAnnouncements),
      NavItem(label: 'Reports', icon: Icons.bar_chart_rounded, route: AppRoutes.hrReports),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      brandName: AppConstants.companyName,
      brandSubtitle: 'HRMS Portal',
      brandIcon: Icons.wb_sunny_rounded,
      groups: _groups,
      currentRoute: currentRoute,
      topTitle: AppConstants.companyName,
      topSubtitle: 'HRMS Portal',
      userName: '${AppConstants.companyName} Admin',
      footerText: 'starter · ACTIVE',
      child: child,
    );
  }
}
