import 'package:flutter/material.dart';

import 'package:hrms_app/features/employee/presentation/notifications_screen/presentation/controllers/employee_notifications_controller.dart';

class EmployeeNotificationTile extends StatelessWidget {
  const EmployeeNotificationTile({
    super.key,
    required this.item,
    required this.onMarkAsRead,
  });

  final EmployeeNotificationItem item;
  final VoidCallback onMarkAsRead;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final unread = !item.isRead;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: unread ? colors.primaryContainer : colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 6, right: 12),
            decoration: BoxDecoration(
              color: unread ? colors.primary : Colors.transparent,
              shape: BoxShape.circle,
              border: unread ? null : Border.all(color: colors.outline),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: unread
                            ? colors.onPrimaryContainer
                            : colors.onSurface,
                        fontWeight: unread ? FontWeight.w800 : FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.5,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      item.time,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                    ),
                    const Spacer(),
                    if (unread)
                      TextButton(
                        onPressed: onMarkAsRead,
                        style: TextButton.styleFrom(
                          foregroundColor: colors.primary,
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                        ),
                        child: const Text('Mark as read'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
