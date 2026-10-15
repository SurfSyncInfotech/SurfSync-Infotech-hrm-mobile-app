import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../core/constants/app_constants.dart';
import '../../data/repositories/employee_directory_repository.dart';
import '../../features/auth/presentation/controllers/session_controller.dart';
import 'app_shell.dart';
import 'app_top_bar.dart';
import 'nav_item.dart';

class EmployeeLayout extends StatelessWidget {
  const EmployeeLayout({
    super.key,
    required this.currentRoute,
    required this.child,
    this.scrollBody = true,
    this.onBottomNavTap,
  });

  final String currentRoute;
  final Widget child;
  final bool scrollBody;
  final ValueChanged<int>? onBottomNavTap;

  static const _groups = [
    NavGroup(label: 'Main', items: [
      NavItem(
          label: 'Home',
          icon: Icons.home_outlined,
          route: AppRoutes.employeeDashboard),
      NavItem(
          label: 'My Profile',
          icon: Icons.account_circle_outlined,
          route: AppRoutes.employeeProfile),
      NavItem(
          label: 'Attendance',
          icon: Icons.access_time_rounded,
          route: AppRoutes.employeeAttendance),
      NavItem(
          label: 'Leaves',
          icon: Icons.event_available_outlined,
          route: AppRoutes.employeeLeave),
      NavItem(
          label: 'Settings',
          icon: Icons.settings_outlined,
          route: AppRoutes.employeeSettings),
    ]),
    NavGroup(label: 'Work', items: [
      NavItem(
          label: 'Daily Work Report',
          icon: Icons.description_outlined,
          route: AppRoutes.employeeDailyReport),
      NavItem(
          label: 'My Offer Letter',
          icon: Icons.assignment_turned_in_outlined,
          route: AppRoutes.employeeOfferLetter),
      NavItem(
          label: 'My Assets',
          icon: Icons.laptop_mac_rounded,
          route: AppRoutes.employeeAssets),
    ]),
  ];

  static const List<NavItem> bottomNavItems = [
    NavItem(
        label: 'Home',
        icon: Icons.home_rounded,
        route: AppRoutes.employeeDashboard),
    NavItem(
        label: 'Profile',
        icon: Icons.person_outline_rounded,
        route: AppRoutes.employeeProfile),
    NavItem(
        label: 'Attendance',
        icon: Icons.access_time_rounded,
        route: AppRoutes.employeeAttendance),
    NavItem(
        label: 'Leaves',
        icon: Icons.event_available_rounded,
        route: AppRoutes.employeeLeave),
    NavItem(
        label: 'Settings',
        icon: Icons.settings_outlined,
        route: AppRoutes.employeeSettings),
  ];

  @override
  Widget build(BuildContext context) {
    final name = Get.isRegistered<SessionController>() &&
            Get.find<SessionController>().displayName.value.isNotEmpty
        ? Get.find<SessionController>().displayName.value
        : Get.isRegistered<EmployeeDirectoryRepository>()
            ? Get.find<EmployeeDirectoryRepository>().current.name
            : 'Employee';
    return AppShell(
      brandName: AppConstants.companyName,
      brandSubtitle: 'Employee Portal',
      brandIcon: Icons.wb_sunny_rounded,
      groups: _groups,
      currentRoute: currentRoute,
      topTitle: AppConstants.companyName,
      topSubtitle: 'Employee Portal',
      userName: name,
      footerText: name,
      bottomNavItems: bottomNavItems,
      scrollBody: scrollBody,
      portal: AppPortal.employee,
      onBottomNavTap: onBottomNavTap,
      child: child,
    );
  }
}
