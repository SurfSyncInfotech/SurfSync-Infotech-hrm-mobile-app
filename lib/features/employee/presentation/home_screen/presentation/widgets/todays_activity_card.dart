import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hrms_app/app/theme/app_dimensions.dart';
import 'package:hrms_app/data/repositories/company_settings_repository.dart';
import 'package:hrms_app/features/employee/presentation/controllers/employee_shell_controller.dart';
import 'home_style.dart';

class TodaysActivityCard extends StatelessWidget {
  const TodaysActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = Get.find<CompanySettingsRepository>().settings.value;
    final now = DateTime.now();
    final end = DateTime(
      now.year,
      now.month,
      now.day,
      settings.workEnd.inHours,
      settings.workEnd.inMinutes.remainder(60),
    );
    final remaining = end.difference(now);
    final closed = remaining.isNegative;
    final onHero = HomeStyle.onHero(context);

    final countdown =
        '${remaining.inHours}h ${remaining.inMinutes.remainder(60).toString().padLeft(2, '0')}m';
    final nextAt = DateFormat('hh:mm a').format(end);

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.spaceLg,
        AppDimensions.spaceMd,
        AppDimensions.spaceMd,
        AppDimensions.spaceMd,
      ),
      decoration: BoxDecoration(
        gradient: HomeStyle.heroGradient(context),
        borderRadius: BorderRadius.circular(18),
        boxShadow: HomeStyle.softShadow(context),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: onHero.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.insights_rounded, color: onHero),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's activity",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: onHero,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                if (closed)
                  Text(
                    'Period closed for today',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: onHero.withValues(alpha: 0.8)),
                  )
                else
                  Text.rich(
                    TextSpan(
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: onHero.withValues(alpha: 0.8)),
                      children: [
                        const TextSpan(text: 'Period refreshes in '),
                        TextSpan(
                          text: countdown,
                          style: TextStyle(
                            color: onHero,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: '  ·  next at $nextAt'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.tonal(
            onPressed: () {
              if (Get.isRegistered<EmployeeShellController>()) {
                Get.find<EmployeeShellController>().selectTab(2);
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: onHero.withValues(alpha: 0.16),
              foregroundColor: onHero,
              minimumSize: const Size(40, 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: onHero.withValues(alpha: 0.35)),
              ),
            ),
            child: const Text('View'),
          ),
        ],
      ),
    );
  }
}
