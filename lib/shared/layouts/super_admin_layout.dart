import 'package:flutter/material.dart';

import '../../app/routes/app_routes.dart';
import '../../core/constants/app_constants.dart';
import 'app_shell.dart';
import 'nav_item.dart';

class SuperAdminLayout extends StatelessWidget {
  const SuperAdminLayout({
    super.key,
    required this.currentRoute,
    required this.child,
  });

  final String currentRoute;
  final Widget child;

  static const _groups = [
    NavGroup(label: 'Features', items: [
      NavItem(label: 'Dashboard', icon: Icons.grid_view_rounded, route: AppRoutes.superDashboard),
      NavItem(label: 'Tenant Management', icon: Icons.apartment_rounded, route: AppRoutes.superTenants),
      NavItem(label: 'Subscription Plans', icon: Icons.credit_card_rounded, route: AppRoutes.superPlans),
      NavItem(label: 'Trial Management', icon: Icons.schedule_rounded, route: AppRoutes.superTrials),
      NavItem(label: 'Billing', icon: Icons.receipt_long_rounded, route: AppRoutes.superBilling),
      NavItem(label: 'Feature Management', icon: Icons.tune_rounded, route: AppRoutes.superFeatures),
    ]),
  ];

  static const List<NavItem> _bottomNavItems = [
    NavItem(label: 'Dashboard', icon: Icons.grid_view_rounded, route: AppRoutes.superDashboard),
    NavItem(label: 'Talent Management', icon: Icons.groups_rounded, route: AppRoutes.superTalentManagement),
    NavItem(label: 'Subscriptions', icon: Icons.credit_card_rounded, route: AppRoutes.superSubscriptions),
    NavItem(label: 'Billing', icon: Icons.receipt_long_rounded, route: AppRoutes.superBilling),
  ];

  @override
  Widget build(BuildContext context) {
    return AppShell(
      brandName: AppConstants.appName,
      brandSubtitle: 'Super Admin',
      brandIcon: Icons.auto_awesome_rounded,
      groups: _groups,
      currentRoute: currentRoute,
      topTitle: AppConstants.appName,
      topSubtitle: 'Administration portal',
      userName: 'Super Admin',
      footerText: AppConstants.appName,
      bottomNavItems: _bottomNavItems,
      child: child,
    );
  }
}
