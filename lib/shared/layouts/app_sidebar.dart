import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/utils/app_nav.dart';
import '../../features/employee/presentation/controllers/employee_shell_controller.dart';
import 'nav_item.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({
    super.key,
    required this.brandName,
    required this.brandSubtitle,
    required this.brandIcon,
    required this.groups,
    required this.currentRoute,
    required this.footerText,
    this.inDrawer = false,
  });

  final String brandName;
  final String brandSubtitle;
  final IconData brandIcon;
  final List<NavGroup> groups;
  final String currentRoute;
  final String footerText;
  final bool inDrawer;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sidebarBg = isDark ? const Color(0xFF131D18) : AppColors.forest;
    final dividerColor = isDark ? colors.outline : Colors.white24;

    return Material(
      color: sidebarBg,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: isDark
                          ? colors.surfaceContainerHighest
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      brandIcon,
                      color: isDark ? colors.primary : AppColors.forest,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brandName,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading3.copyWith(
                            color: isDark ? colors.onSurface : Colors.white,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          brandSubtitle.toUpperCase(),
                          style: AppTextStyles.overline.copyWith(
                            color: isDark
                                ? colors.onSurfaceVariant
                                : AppColors.sidebarText,
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: dividerColor),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 12),
                children: [
                  for (final group in groups) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
                      child: Text(
                        group.label.toUpperCase(),
                        style: AppTextStyles.overline.copyWith(
                          color: isDark
                              ? colors.primary
                              : const Color(0xFF8FC2AE),
                          fontSize: 11,
                        ),
                      ),
                    ),
                    for (final item in group.items)
                      _SidebarTile(
                        item: item,
                        active: item.route == currentRoute,
                        inDrawer: inDrawer,
                      ),
                  ],
                ],
              ),
            ),
            Divider(height: 1, color: dividerColor),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                footerText,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyBold.copyWith(
                  color: isDark ? colors.onSurface : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.item,
    required this.active,
    required this.inDrawer,
  });

  final NavItem item;
  final bool active;
  final bool inDrawer;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeTileBg = isDark
        ? colors.primary.withValues(alpha: 0.15)
        : Colors.white.withValues(alpha: 0.14);
    final activeIndicator = isDark ? colors.primary : AppColors.orange;
    final activeColor = isDark ? colors.primary : Colors.white;
    final inactiveColor =
        isDark ? colors.onSurfaceVariant : AppColors.sidebarText;

    return Material(
      color: active ? activeTileBg : Colors.transparent,
      child: InkWell(
        hoverColor: isDark
            ? colors.surfaceContainerHighest.withValues(alpha: 0.5)
            : Colors.white.withValues(alpha: 0.08),
        onTap: () {
          if (inDrawer) Get.back();
          if (Get.isRegistered<EmployeeShellController>() &&
              EmployeeShellController.tabRoutes.contains(item.route)) {
            Get.find<EmployeeShellController>().selectRoute(item.route);
            if (Get.currentRoute != AppRoutes.employeeDashboard) {
              AppNav.go(AppRoutes.employeeDashboard);
            }
            return;
          }
          AppNav.go(item.route);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: active ? activeIndicator : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: 20,
                color: active ? activeColor : inactiveColor,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  item.label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: active ? activeColor : inactiveColor,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
