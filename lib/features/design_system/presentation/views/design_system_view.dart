import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/extensions/date_extensions.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_data_table.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/app_stat_card.dart';
import '../../../../core/widgets/app_status_chip.dart';
import '../../../../shared/layouts/admin_layout.dart';
import '../../../../shared/widgets/page_header.dart';
import '../../../employee/data/models/employee_model.dart';
import '../controllers/design_system_controller.dart';

/// Developer preview of the shared widgets. Replaced by real screens as phases land.
class DesignSystemView extends GetView<DesignSystemController> {
  const DesignSystemView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      currentRoute: AppRoutes.designSystem,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageHeader(
            title: 'Design System',
            subtitle: 'Shared widgets used across all three portals',
            actions: [
              AppButton(
                label: 'Add Employee',
                icon: Icons.add_rounded,
                type: AppButtonType.secondary,
                onPressed: () => Get.snackbar('Add Employee', 'Form arrives in Phase 4.',
                    snackPosition: SnackPosition.BOTTOM,
                    margin: const EdgeInsets.all(16),
                    maxWidth: 420),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const AppStatGrid(items: [
            AppStatCard(label: 'Headcount', value: '8', caption: '3 joined · 0 left'),
            AppStatCard(label: 'Present today', value: '6 / 8', caption: '1 on leave today'),
            AppStatCard(label: 'Attendance rate', value: '77.1%', icon: Icons.trending_up_rounded),
            AppStatCard(
                label: 'Pending leaves',
                value: '3',
                valueColor: AppColors.orangeDark,
                icon: Icons.event_busy_outlined),
          ]),
          const SizedBox(height: 20),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buttons',
                  style: AppTextStyles.heading3.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  AppButton(label: 'Primary', onPressed: () {}),
                  AppButton(
                      label: 'Secondary',
                      type: AppButtonType.secondary,
                      onPressed: () {}),
                  AppButton(
                      label: 'Outline',
                      type: AppButtonType.outline,
                      onPressed: () {}),
                  AppButton(
                      label: 'Text',
                      type: AppButtonType.text,
                      onPressed: () {}),
                  const AppButton(label: 'Disabled', onPressed: null),
                ]),
                const SizedBox(height: 20),
                Text(
                  'Status chips',
                  style: AppTextStyles.heading3.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  AppStatusChip.auto('Active'),
                  AppStatusChip.auto('Pending'),
                  AppStatusChip.auto('Suspended'),
                  AppStatusChip.auto('Draft'),
                  AppStatusChip.auto('Full Time'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AppSearchField(
                  hint: 'Search by name or department',
                  onChanged: controller.setQuery,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() {
            final rows = controller.pagedRows;
            final total = controller.filtered.length;
            return AppDataTable<Employee>(
              rows: rows,
              columns: [
                AppTableColumn(
                  label: 'Employee',
                  cell: (e) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(e.name, style: AppTextStyles.bodyBold),
                      Text(e.designation,
                          style: AppTextStyles.bodyMuted.copyWith(fontSize: 12.5)),
                    ],
                  ),
                ),
                AppTableColumn(label: 'Department', cell: (e) => Text(e.department)),
                AppTableColumn(label: 'Location', cell: (e) => Text(e.location)),
                AppTableColumn(label: 'Joined', cell: (e) => Text(e.joiningDate.dMMMy)),
                AppTableColumn(label: 'Status', cell: (e) => AppStatusChip.auto(e.status)),
                AppTableColumn(label: '', cell: (e) => _RowMenu(employee: e)),
              ],
              mobileItemBuilder: (context, e) => AppCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.name, style: AppTextStyles.bodyBold),
                          Text('${e.designation} · ${e.department}',
                              style: AppTextStyles.bodyMuted),
                          const SizedBox(height: 8),
                          AppStatusChip.auto(e.status),
                        ],
                      ),
                    ),
                    _RowMenu(employee: e),
                  ],
                ),
              ),
              footer: AppPaginationBar(
                page: controller.page.value,
                pageSize: DesignSystemController.pageSize,
                totalItems: total,
                onPageChanged: controller.setPage,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _RowMenu extends GetView<DesignSystemController> {
  const _RowMenu({required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Actions',
      icon: const Icon(Icons.more_horiz_rounded),
      onSelected: (value) async {
        if (value == 'remove') {
          final ok = await controller.confirmRemove(employee);
          if (ok) {
            Get.snackbar('Done (demo)', '${employee.name} would be removed.',
                snackPosition: SnackPosition.BOTTOM,
                margin: const EdgeInsets.all(16),
                maxWidth: 420);
          }
        }
      },
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'view', child: Text('View details')),
        PopupMenuItem(value: 'edit', child: Text('Edit')),
        PopupMenuItem(value: 'remove', child: Text('Remove')),
      ],
    );
  }
}
