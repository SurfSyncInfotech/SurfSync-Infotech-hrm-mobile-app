import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_dimensions.dart';
import '../../app/theme/app_text_styles.dart';
import '../../app/theme/theme_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/app_nav.dart';
import '../../core/utils/responsive.dart';
import '../../features/auth/presentation/controllers/session_controller.dart';
import '../../features/employee/presentation/notifications_screen/presentation/controllers/employee_notifications_controller.dart';

enum AppPortal { employee, admin, superAdmin }

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.userName,
    this.portal = AppPortal.employee,
  });

  final String title;
  final String subtitle;
  final String userName;
  final AppPortal portal;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        height: AppDimensions.topBarHeight,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(bottom: BorderSide(color: colorScheme.outline)),
        ),
        child: Row(
          children: [
            Expanded(
  child: Padding(
    padding: EdgeInsets.only(left: isMobile ? 12 : 4),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.heading3.copyWith(
            color: colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          subtitle,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.overline.copyWith(
            fontSize: 14,
            letterSpacing: 0.8,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    ),
  ),
),
            GetBuilder<ThemeController>(
              builder: (themeController) => IconButton(
                tooltip: themeController.isDarkMode
                    ? 'Switch to light mode'
                    : 'Switch to dark mode',
                onPressed: themeController.toggleTheme,
                icon: Icon(
                  themeController.isDarkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                  color: colorScheme.primary,
                ),
              ),
            ),
            Obx(() {
              final unreadCount =
                  Get.find<EmployeeNotificationsController>().unreadCount;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    tooltip: 'Notifications',
                    onPressed: () =>
                        Get.toNamed(AppRoutes.employeeNotifications),
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 10,
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 16),
                        height: 16,
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(
                            color: colorScheme.surface,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          '$unreadCount',
                          style: TextStyle(
                            fontSize: 9,
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }),
            PopupMenuButton<String>(
              tooltip: 'Account',
              onSelected: (value) async {
                if (value == 'profile' && portal == AppPortal.employee) {
                  AppNav.go(AppRoutes.employeeProfile);
                } else if (value == 'logout') {
                  await Get.find<SessionController>().signOut();
                  AppNav.goAll(AppRoutes.login);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  enabled: false,
                  child: Text(
                    userName,
                    style: AppTextStyles.bodyBold,
                  ),
                ),
                if (portal == AppPortal.employee)
                  const PopupMenuItem(
                    value: 'profile',
                    child: Text('My profile'),
                  ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
              child: Padding(
                padding: const EdgeInsets.only(left: 4, right: 6),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.person_rounded,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String brandTitle() => AppConstants.companyName;
}
