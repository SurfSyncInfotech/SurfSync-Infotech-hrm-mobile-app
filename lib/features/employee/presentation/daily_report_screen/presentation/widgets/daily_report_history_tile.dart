import 'package:flutter/material.dart';
import 'package:hrms_app/data/models/employee_daily_report.dart';
import 'package:intl/intl.dart';

class DailyReportHistoryTile extends StatelessWidget {
  const DailyReportHistoryTile({super.key, required this.report});

  final EmployeeDailyReport report;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final (background, foreground) = switch (report.status.toLowerCase()) {
      'approved' => (colors.primaryContainer, colors.onPrimaryContainer),
      'rejected' => (colors.errorContainer, colors.onErrorContainer),
      _ => (colors.tertiaryContainer, colors.onTertiaryContainer),
    };

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  DateFormat('d MMM yyyy').format(report.date),
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  '${report.hoursWorked.toStringAsFixed(1)} hrs',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    report.status.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: foreground,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(report.workDone, style: theme.textTheme.bodyMedium),
            if (report.blockers.isNotEmpty) ...[
              const SizedBox(height: 10),
              _Detail(label: 'Blockers', value: report.blockers),
            ],
            if (report.plansForTomorrow.isNotEmpty) ...[
              const SizedBox(height: 10),
              _Detail(
                  label: 'Plans for tomorrow', value: report.plansForTomorrow),
            ],
            if (report.note != null && report.note!.isNotEmpty) ...[
              const SizedBox(height: 10),
              _Detail(label: 'Note', value: report.note!),
            ],
          ],
        ),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelMedium),
        const SizedBox(height: 3),
        Text(value, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
