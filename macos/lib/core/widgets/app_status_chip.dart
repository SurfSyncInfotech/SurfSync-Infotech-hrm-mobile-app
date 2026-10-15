import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

enum StatusType { success, warning, danger, info, neutral }

class AppStatusChip extends StatelessWidget {
  const AppStatusChip({
    super.key,
    required this.label,
    this.type = StatusType.neutral,
    this.uppercase = true,
  });

  /// Picks a colour automatically from common HR/billing status words.
  factory AppStatusChip.auto(String label) =>
      AppStatusChip(label: label, type: typeFor(label));

  final String label;
  final StatusType type;
  final bool uppercase;

  static StatusType typeFor(String label) {
    switch (label.trim().toLowerCase()) {
      case 'active':
      case 'paid':
      case 'approved':
      case 'present':
      case 'live':
      case 'completed':
        return StatusType.success;
      case 'pending':
      case 'trial':
      case 'on trial':
      case 'late':
      case 'on leave':
      case 'probation':
        return StatusType.warning;
      case 'suspended':
      case 'rejected':
      case 'absent':
      case 'expired':
      case 'overdue':
      case 'inactive':
        return StatusType.danger;
      case 'info':
      case 'draft':
        return StatusType.info;
      default:
        return StatusType.neutral;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = switch (type) {
      StatusType.success => (AppColors.successBg, AppColors.success),
      StatusType.warning => (AppColors.warningBg, AppColors.warning),
      StatusType.danger => (AppColors.dangerBg, AppColors.danger),
      StatusType.info => (AppColors.infoBg, AppColors.info),
      StatusType.neutral => (AppColors.neutralBg, AppColors.textSecondary),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        uppercase ? label.toUpperCase() : label,
        style: AppTextStyles.chip.copyWith(color: fg),
      ),
    );
  }
}
