import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes/app_routes.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimensions.dart';
import '../../app/theme/app_text_styles.dart';
import '../../core/utils/app_nav.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_confirm_dialog.dart';
import '../../features/auth/presentation/controllers/session_controller.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.userName,
  });

  final String title;
  final String subtitle;
  final String userName;

  Future<void> _logout() async {
    final confirmed = await AppConfirmDialog.show(
      title: 'Log out',
      message: 'Are you sure you want to sign out of your account?',
      confirmLabel: 'Log out',
    );
    if (!confirmed) return;
    Get.find<SessionController>().signOut();
    AppNav.goAll(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      height: AppDimensions.topBarHeight,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.heading3
                        .copyWith(color: AppColors.forest, fontSize: 16.5)),
                Text(subtitle.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.overline.copyWith(fontSize: 10.5)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            ),
            child: PopupMenuButton<int>(
              tooltip: 'Notifications',
              offset: const Offset(0, 48),
              icon: const Icon(Icons.notifications_none_rounded, size: 22),
              itemBuilder: (_) => const [
                PopupMenuItem(enabled: false, child: Text('Notifications')),
                PopupMenuItem(value: 1, child: Text('Leave request approved')),
                PopupMenuItem(
                    value: 2, child: Text('October payslip is ready')),
                PopupMenuItem(value: 3, child: Text('New policy published')),
              ],
            ),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 16),
            Text(userName, style: AppTextStyles.bodyMuted),
          ],
          const SizedBox(width: 12),
          OutlinedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout_rounded, size: 18),
            label: Text(isMobile ? '' : 'Logout'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: AppColors.border),
              padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 10 : 16, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
