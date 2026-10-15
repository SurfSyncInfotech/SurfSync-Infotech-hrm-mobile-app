import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/constants/app_constants.dart';
import '../../features/auth/presentation/controllers/session_controller.dart';
import 'app_shell.dart';
import 'app_top_bar.dart';
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
      NavItem(
          label: 'Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.adminDashboard),
    ]),
    NavGroup(label: 'Employee Management', items: [
      NavItem(
          label: 'Employees',
          icon: Icons.groups_outlined,
          route: AppRoutes.hrEmployees),
      NavItem(
          label: 'Add Employee',
          icon: Icons.person_add_alt_outlined,
          route: AppRoutes.adminAddEmployee),
      NavItem(
          label: 'Offer Letters',
          icon: Icons.assignment_outlined,
          route: AppRoutes.adminOfferLetters),
      NavItem(
          label: 'Assets',
          icon: Icons.laptop_mac_rounded,
          route: AppRoutes.hrAssets),
    ]),
    NavGroup(label: 'Attendance & Leaves', items: [
      NavItem(
          label: 'Attendance',
          icon: Icons.access_time_rounded,
          route: AppRoutes.adminAttendance),
      NavItem(
          label: 'Leave Management',
          icon: Icons.event_available_outlined,
          route: AppRoutes.adminLeaves),
    ]),
    NavGroup(label: 'Work & Performance', items: [
      NavItem(
          label: 'Daily Work Reports',
          icon: Icons.description_outlined,
          route: AppRoutes.hrDailyReports),
      NavItem(
          label: 'Performance',
          icon: Icons.task_alt_rounded,
          route: AppRoutes.hrTargets),
    ]),
    NavGroup(label: 'Company', items: [
      NavItem(
          label: 'Company Settings',
          icon: Icons.settings_outlined,
          route: AppRoutes.adminCompanySettings),
    ]),
  ];

  static const List<NavItem> _bottomNavItems = [
    NavItem(
        label: 'Dashboard',
        icon: Icons.dashboard_outlined,
        route: AppRoutes.adminDashboard),
    NavItem(
        label: 'Employees',
        icon: Icons.groups_outlined,
        route: AppRoutes.hrEmployees),
    NavItem(
        label: 'Attendance',
        icon: Icons.access_time_rounded,
        route: AppRoutes.adminAttendance),
    NavItem(
        label: 'Settings',
        icon: Icons.settings_outlined,
        route: AppRoutes.adminCompanySettings),
  ];

  @override
  Widget build(BuildContext context) {
    final name = Get.isRegistered<SessionController>() &&
            Get.find<SessionController>().displayName.value.isNotEmpty
        ? Get.find<SessionController>().displayName.value
        : '${AppConstants.companyName} Admin';
    return AppShell(
      brandName: AppConstants.companyName,
      brandSubtitle: 'Admin Dashboard',
      brandIcon: Icons.wb_sunny_rounded,
      groups: _groups,
      currentRoute: currentRoute,
      topTitle: AppConstants.companyName,
      topSubtitle: 'Admin Dashboard',
      userName: name,
      footerText: name,
      bottomNavItems: _bottomNavItems,
      portal: AppPortal.admin,
      child: child,
    );
  }
}
