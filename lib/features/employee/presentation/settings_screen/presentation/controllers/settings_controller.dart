import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsItem {
  SettingsItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String? route;
}

class SettingsSection {
  SettingsSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<SettingsItem> items;
}

class SettingsController extends GetxController {
  final RxList<SettingsSection> sections = <SettingsSection>[
    SettingsSection(
      title: 'Account',
      items: [
        SettingsItem(
            title: 'My Profile',
            subtitle: 'Personal details and contact information',
            icon: Icons.person_outline_rounded,
            route: '/employee/profile'),
        SettingsItem(
            title: 'Personal Information',
            subtitle: 'Update your identity and address details',
            icon: Icons.badge_outlined,
            route: '/employee/profile'),
        SettingsItem(
            title: 'Change Password',
            subtitle: 'Secure your account and login access',
            icon: Icons.lock_outline_rounded),
      ],
    ),
    SettingsSection(
      title: 'Attendance & Work',
      items: [
        SettingsItem(
            title: 'Attendance Settings',
            subtitle: 'Manage check-in and location preferences',
            icon: Icons.access_time_rounded,
            route: '/employee/attendance'),
        SettingsItem(
            title: 'Work Schedule',
            subtitle: 'Review shift timings and calendar rules',
            icon: Icons.schedule_rounded),
        SettingsItem(
            title: 'Attendance History',
            subtitle: 'View current and previous punch records',
            icon: Icons.history_rounded,
            route: '/employee/attendance'),
      ],
    ),
    SettingsSection(
      title: 'Leave Management',
      items: [
        SettingsItem(
            title: 'Apply Leave',
            subtitle: 'Submit a leave request for approval',
            icon: Icons.event_available_outlined,
            route: '/employee/leave'),
        SettingsItem(
            title: 'Leave Balance',
            subtitle: 'Check remaining leave entitlement',
            icon: Icons.balance_outlined,
            route: '/employee/leave'),
        SettingsItem(
            title: 'Leave History',
            subtitle: 'See previous leave applications',
            icon: Icons.calendar_month_rounded,
            route: '/employee/leave'),
      ],
    ),
    SettingsSection(
      title: 'Notifications',
      items: [
        SettingsItem(
            title: 'Notification Preferences',
            subtitle: 'Control what alerts you receive',
            icon: Icons.notifications_none_rounded),
        SettingsItem(
            title: 'Alert Settings',
            subtitle: 'Review reminders and escalation rules',
            icon: Icons.notifications_active_outlined,
            route: '/employee/alert-settings'),
      ],
    ),
    SettingsSection(
      title: 'Documents & Payroll',
      items: [
        SettingsItem(
            title: 'Offer Letter',
            subtitle: 'View your employment letter',
            icon: Icons.description_outlined),
        SettingsItem(
            title: 'Payslips',
            subtitle: 'Access monthly salary slips',
            icon: Icons.payments_outlined),
        SettingsItem(
            title: 'Company Policies',
            subtitle: 'Read employee policy documents',
            icon: Icons.policy_rounded),
      ],
    ),
    SettingsSection(
      title: 'Application',
      items: [
        SettingsItem(
            title: 'About SurfSync HRMS',
            subtitle: 'App version and product information',
            icon: Icons.info_outline_rounded),
        SettingsItem(
            title: 'Logout',
            subtitle: 'Sign out of the employee portal',
            icon: Icons.logout_rounded,
            route: '/login'),
      ],
    ),
  ].obs;
}
