import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/core/widgets/app_empty_state.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

import '../controllers/employee_notifications_controller.dart';
import '../widgets/employee_notification_tile.dart';

class EmployeeNotificationsView
    extends GetView<EmployeeNotificationsController> {
  const EmployeeNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeNotifications,
      child: Obx(() {
        final items = controller.notifications;
        final colors = Theme.of(context).colorScheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                ),
                if (items.isNotEmpty)
                  TextButton.icon(
                    onPressed: controller.markAllAsRead,
                    icon: const Icon(Icons.done_all_rounded, size: 18),
                    label: const Text('Mark all read'),
                    style: TextButton.styleFrom(
                      foregroundColor: colors.primary,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            if (items.isEmpty)
              const AppEmptyState(
                title: 'No notifications yet',
                message: 'You are all caught up.',
                icon: Icons.notifications_none_rounded,
              )
            else
              ...items.asMap().entries.map(
                    (entry) => EmployeeNotificationTile(
                      item: entry.value,
                      onMarkAsRead: () => controller.markAsRead(entry.key),
                    ),
                  ),
            const SizedBox(height: 12),
            if (items.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: controller.clearAll,
                  icon: const Icon(Icons.delete_outline_rounded, size: 18),
                  label: const Text('Clear all'),
                  style: TextButton.styleFrom(
                    foregroundColor: colors.primary,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
