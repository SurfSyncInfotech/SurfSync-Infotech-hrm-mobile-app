import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hrms_app/app/theme/app_text_styles.dart';
import 'package:hrms_app/core/widgets/app_empty_state.dart';
import 'package:hrms_app/core/widgets/app_status_chip.dart';
import 'package:hrms_app/data/models/leave_models.dart';
import 'package:hrms_app/features/employee/presentation/leave_screen/presentation/controllers/leave_controller.dart';

class LeaveHistorySection extends GetView<LeaveController> {
  const LeaveHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Obx(() {
      final requests = controller.repository.requests;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Leave history',
            style: AppTextStyles.heading3.copyWith(color: colors.onSurface),
          ),
          const SizedBox(height: 8),
          if (requests.isEmpty)
            const AppEmptyState(
              title: 'No leave requests yet',
              message: 'Submitted requests will appear here.',
              icon: Icons.event_note_outlined,
            )
          else
            ...requests.map(
              (request) => Card(
                child: ListTile(
                  title: Text(
                    request.type.label,
                    style: AppTextStyles.bodyBold
                        .copyWith(color: colors.onSurface),
                  ),
                  subtitle: Text(
                    '${DateFormat('d MMM').format(request.start)} – ${DateFormat('d MMM yyyy').format(request.end)} · ${request.days} day(s)\nApplied ${DateFormat('d MMM yyyy').format(request.appliedOn)}'
                    '${request.rejectionReason == null ? '' : '\n${request.rejectionReason}'}',
                    style: AppTextStyles.bodyMuted
                        .copyWith(color: colors.onSurfaceVariant),
                  ),
                  isThreeLine: true,
                  trailing: AppStatusChip.auto(request.status.label),
                ),
              ),
            ),
        ],
      );
    });
  }
}
