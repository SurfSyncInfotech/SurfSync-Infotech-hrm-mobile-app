import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrms_app/app/theme/app_text_styles.dart';
import 'package:hrms_app/core/extensions/date_extensions.dart';
import 'package:hrms_app/core/widgets/app_card.dart';
import 'package:hrms_app/core/widgets/app_status_chip.dart';
import 'package:hrms_app/features/employee/data/models/employee_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        spacing: 24,
        runSpacing: 16,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: colors.primary,
            child: Text(
              employee.initials,
              style: AppTextStyles.heading1
                  .copyWith(color: colors.onPrimary, fontSize: 32),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(employee.name,
                    style: AppTextStyles.heading1
                        .copyWith(fontSize: 32, color: colors.onSurface)),
                const SizedBox(height: 6),
                Text(
                  '${employee.designation} · ${employee.department} · ${employee.location}',
                  style: AppTextStyles.bodyMuted.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    AppStatusChip.auto(employee.status),
                    AppStatusChip(
                        label: employee.employmentType, uppercase: false),
                    AppStatusChip(
                        label: 'Joined ${employee.joiningDate.dMMMy}',
                        uppercase: false),
                  ],
                ),
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => Get.snackbar(
                    'Company policies',
                    'Policy documents will open here (UI preview).',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(16),
                    maxWidth: 420,
                  ),
                  icon: const Icon(Icons.description_outlined, size: 18),
                  label: const Text('See policies'),
                  style: TextButton.styleFrom(
                    foregroundColor: colors.primary,
                    padding: EdgeInsets.zero,
                    textStyle: AppTextStyles.bodyBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
