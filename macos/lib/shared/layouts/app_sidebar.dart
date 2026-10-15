import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/utils/app_nav.dart';
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
    return Material(
      color: AppColors.forest,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(brandIcon, color: AppColors.forest),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brandName,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.heading3
                              .copyWith(color: Colors.white, fontSize: 17),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          brandSubtitle.toUpperCase(),
                          style: AppTextStyles.overline.copyWith(
                              color: AppColors.sidebarText, fontSize: 10.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.white24),
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
                            color: const Color(0xFF8FC2AE), fontSize: 11),
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
            const Divider(height: 1, color: Colors.white24),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Text(
                footerText,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyBold.copyWith(color: Colors.white),
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
    return Material(
      color: active ? Colors.white.withValues(alpha: 0.14) : Colors.transparent,
      child: InkWell(
        hoverColor: Colors.white.withValues(alpha: 0.08),
        onTap: () {
          if (inDrawer) Get.back();
          AppNav.go(item.route);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: active ? AppColors.orange : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(item.icon,
                  size: 20,
                  color: active ? Colors.white : AppColors.sidebarText),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  item.label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.body.copyWith(
                    color: active ? Colors.white : AppColors.sidebarText,
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
