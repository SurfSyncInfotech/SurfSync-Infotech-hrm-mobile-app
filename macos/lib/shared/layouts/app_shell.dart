import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimensions.dart';
import '../../core/utils/responsive.dart';
import 'app_sidebar.dart';
import 'app_top_bar.dart';
import 'nav_item.dart';

/// Responsive portal shell: persistent sidebar on desktop, drawer otherwise.
/// Portal layouts (employee / admin / super admin) configure this.
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

    final body = Column(
      children: [
        AppTopBar(
          title: topTitle,
          subtitle: topSubtitle,
          userName: userName,
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: AppDimensions.maxContentWidth),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );

    if (isDesktop) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Row(
          children: [
            SizedBox(
                width: AppDimensions.sidebarWidth,
                child: _sidebar(inDrawer: false)),
            Expanded(child: body),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: Drawer(
        width: AppDimensions.sidebarWidth,
        backgroundColor: AppColors.forest,
        shape: const RoundedRectangleBorder(),
        child: _sidebar(inDrawer: true),
      ),
      body: SafeArea(bottom: false, child: body),
    );
  }
}
