import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrms_app/core/widgets/app_stat_card.dart';
import 'package:hrms_app/data/models/leave_models.dart';
import 'package:hrms_app/features/employee/presentation/leave_screen/presentation/controllers/leave_controller.dart';

class LeaveBalanceSection extends GetView<LeaveController> {
  const LeaveBalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final repository = controller.repository;
      return AppStatGrid(
        desktopColumns: 2,
        items: [
          for (final balance in repository.balances)
            AppStatCard(
              label: balance.type.label,
              value: '${balance.remaining}',
              caption:
                  'of ${balance.allocated} · used ${balance.used} · pending ${balance.pending}',
            ),
        ],
      );
    });
  }
}
