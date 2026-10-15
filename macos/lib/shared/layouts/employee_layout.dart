import 'package:flutter/material.dart';

import '../../app/routes/app_routes.dart';
import '../../core/constants/app_constants.dart';
import '../../data/mock/mock_employee_data.dart';
import 'app_shell.dart';
import 'nav_item.dart';

class EmployeeLayout extends StatelessWidget {
  const EmployeeLayout({
    super.key,
    required this.currentRoute,
    required this.child,
  });

  final String currentRoute;
  final Widget child;

  static const _groups = [
    NavGroup(label: 'Main', items: [
      NavItem(label: 'My Profile', icon: Icons.account_circle_outlined, route: AppRoutes.employeeProfile),
      NavItem(label: 'Dashboard', icon: Icons.dashboard_outlined, route: AppRoutes.employeeDashboard),
      NavItem(label: 'Mark Attendance', icon: Icons.access_time_rounded, route: AppRoutes.employeeAttendance),
      NavItem(label: 'Apply Leave', icon: Icons.event_available_outlined, route: AppRoutes.employeeLeave),
      NavItem(label: 'Daily Work Report', icon: Icons.description_outlined, route: AppRoutes.employeeDailyReport),
      NavItem(label: 'My Offer Letter', icon: Icons.assignment_turned_in_outlined, route: AppRoutes.employeeOfferLetter),
      NavItem(label: 'My Mailbox', icon: Icons.mail_outline_rounded, route: AppRoutes.employeeMailbox),
      NavItem(label: 'My Payslips', icon: Icons.payments_outlined, route: AppRoutes.employeePayslips),
      NavItem(label: 'My Assets', icon: Icons.laptop_mac_rounded, route: AppRoutes.employeeAssets),
      NavItem(label: 'Announcements', icon: Icons.campaign_outlined, route: AppRoutes.employeeAnnouncements),
      NavItem(label: 'My Targets', icon: Icons.task_alt_rounded, route: AppRoutes.employeeTargets),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    final name = MockEmployeeData.currentEmployee.name;
    return AppShell(
      brandName: AppConstants.companyName,
      brandSubtitle: 'Employee Portal',
      brandIcon: Icons.wb_sunny_rounded,
      groups: _groups,
      currentRoute: currentRoute,
      topTitle: AppConstants.companyName,
      topSubtitle: 'Employee portal · Tracking',
      userName: name,
      footerText: name,
      child: child,
    );
  }
}
