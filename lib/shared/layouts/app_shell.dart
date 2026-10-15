import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimensions.dart';
import '../../core/utils/app_nav.dart';
import '../../core/utils/responsive.dart';
import '../../features/employee/presentation/controllers/employee_shell_controller.dart';
import 'app_sidebar.dart';
import 'app_top_bar.dart';
import 'nav_item.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.brandName,
    required this.brandSubtitle,
    required this.brandIcon,
    required this.groups,
    required this.currentRoute,
    required this.topTitle,
    required this.topSubtitle,
    required this.userName,
    required this.footerText,
    required this.child,
    this.bottomNavItems,
    this.scrollBody = true,
    this.portal = AppPortal.employee,
    this.onBottomNavTap,
  });

  final String brandName;
  final String brandSubtitle;
  final IconData brandIcon;
  final List<NavGroup> groups;
  final String currentRoute;
  final String topTitle;
  final String topSubtitle;
  final String userName;
  final String footerText;
  final Widget child;
  final List<NavItem>? bottomNavItems;
  final bool scrollBody;
  final AppPortal portal;
  final ValueChanged<int>? onBottomNavTap;

  AppSidebar _sidebar({required bool inDrawer}) => AppSidebar(
        brandName: brandName,
        brandSubtitle: brandSubtitle,
        brandIcon: brandIcon,
        groups: groups,
        currentRoute: currentRoute,
        footerText: footerText,
        inDrawer: inDrawer,
      );

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final padding = Responsive.isMobile(context) ? 16.0 : 24.0;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final systemUiStyle = SystemUiOverlayStyle(
      statusBarColor: theme.colorScheme.surface,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: theme.colorScheme.surface,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    );
    final selectedIndex = bottomNavItems?.indexWhere(
      (item) => item.route == currentRoute,
    );

    final content = Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
        child: child,
      ),
    );

    final body = Column(
      children: [
        AppTopBar(
          title: topTitle,
          subtitle: topSubtitle,
          userName: userName,
          portal: portal,
        ),
        Expanded(
          child: scrollBody
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(padding),
                  child: content,
                )
              : Padding(
                  padding: EdgeInsets.all(padding),
                  child: content,
                ),
        ),
      ],
    );

    Widget scaffold({required bool withDrawer}) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        drawer: withDrawer
            ? Drawer(
                width: AppDimensions.sidebarWidth,
                backgroundColor: AppColors.forest,
                shape: const RoundedRectangleBorder(),
                child: _sidebar(inDrawer: true),
              )
            : null,
        bottomNavigationBar: withDrawer && bottomNavItems != null
            ? NavigationBar(
                selectedIndex: selectedIndex == null || selectedIndex < 0
                    ? 0
                    : selectedIndex,
                onDestinationSelected: (index) {
                  final item = bottomNavItems![index];
                  if (onBottomNavTap != null) {
                    onBottomNavTap!(index);
                    return;
                  }
                  if (Get.isRegistered<EmployeeShellController>() &&
                      EmployeeShellController.tabRoutes.contains(item.route)) {
                    Get.find<EmployeeShellController>().selectRoute(item.route);
                    if (Get.currentRoute != AppRoutes.employeeDashboard) {
                      AppNav.go(AppRoutes.employeeDashboard);
                    }
                    return;
                  }
                  if (item.route != currentRoute) AppNav.go(item.route);
                },
                destinations: [
                  for (final item in bottomNavItems!)
                    NavigationDestination(
                      icon: Icon(item.icon),
                      label: item.label,
                    ),
                ],
              )
            : null,
        body: withDrawer
            ? SafeArea(bottom: false, child: body)
            : Row(
                children: [
                  SizedBox(
                    width: AppDimensions.sidebarWidth,
                    child: _sidebar(inDrawer: false),
                  ),
                  Expanded(child: body),
                ],
              ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiStyle,
      child: scaffold(withDrawer: !isDesktop),
    );
  }
}
