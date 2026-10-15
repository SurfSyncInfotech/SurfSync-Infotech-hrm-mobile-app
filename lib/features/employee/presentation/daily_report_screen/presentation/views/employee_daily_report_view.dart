import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/data/models/employee_daily_report.dart';
import 'package:hrms_app/features/employee/presentation/daily_report_screen/presentation/controllers/daily_report_controller.dart';
import 'package:hrms_app/features/employee/presentation/daily_report_screen/presentation/widgets/daily_report_history_tile.dart';
import 'package:hrms_app/features/employee/presentation/daily_report_screen/presentation/widgets/daily_report_stat_card.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';
import 'package:intl/intl.dart';

class EmployeeDailyReportView extends GetView<DailyReportController> {
  const EmployeeDailyReportView({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final reportController = controller;
    final content = Obx(() {
      if (reportController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      final colors = Theme.of(context).colorScheme;
      final reports = reportController.visibleReports;
      final date = reportController.reportDate.value;

      return ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Text(
            'Daily Work Report',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            "Submit today's work and track approvals",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: colors.onSurfaceVariant),
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 10.0;
              final columns = constraints.maxWidth >= 720 ? 4 : 2;
              final width =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  SizedBox(
                    width: width,
                    child: DailyReportStatCard(
                      label: 'Submitted',
                      value: reportController.countFor('Submitted'),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: DailyReportStatCard(
                      label: 'Pending',
                      value: reportController.countFor('Pending'),
                      highlight: true,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: DailyReportStatCard(
                      label: 'Approved',
                      value: reportController.countFor('Approved'),
                    ),
                  ),
                  SizedBox(
                    width: width,
                    child: DailyReportStatCard(
                      label: 'Rejected',
                      value: reportController.countFor('Rejected'),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          _buildSubmissionForm(context, reportController, date),
          const SizedBox(height: 22),
          _buildHistory(context, reportController, reports),
        ],
      );
    });

    if (embedded) return content;
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeDailyReport,
      scrollBody: false,
      child: content,
    );
  }

  Widget _buildSubmissionForm(
    BuildContext context,
    DailyReportController reportController,
    DateTime date,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final alreadySubmitted = reportController.alreadySubmitted;
    final hours = reportController.hoursWorked;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: colors.primary,
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Icon(Icons.description_outlined, color: colors.onPrimary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Submit today's report",
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors.onPrimary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Share what you completed, any blockers, and tomorrow's plan.",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.onPrimary.withValues(alpha: 0.82),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 560;
                    final fieldWidth = isWide
                        ? (constraints.maxWidth - 16) / 2
                        : constraints.maxWidth;
                    return Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        SizedBox(
                          width: fieldWidth,
                          child: _dateSelector(
                            context,
                            reportController,
                            date,
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth,
                          child: _hoursField(context, hours),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 18),
                _ReportTextField(
                  controller: reportController.workDoneController,
                  label: 'Work done *',
                  hint: 'What did you accomplish today?',
                  icon: Icons.description_outlined,
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                _ReportTextField(
                  controller: reportController.blockersController,
                  label: 'Blockers / challenges',
                  hint: 'Anything blocking progress?',
                  icon: Icons.flag_outlined,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                _ReportTextField(
                  controller: reportController.plansController,
                  label: 'Plans for tomorrow',
                  hint: 'What will you focus on next?',
                  icon: Icons.send_outlined,
                  maxLines: 3,
                ),
                if (alreadySubmitted) ...[
                  const SizedBox(height: 14),
                  _InfoMessage(
                    message:
                        'A report has already been submitted for ${DateFormat('d MMM yyyy').format(date)}.',
                    icon: Icons.check_circle_outline,
                  ),
                ],
                if (reportController.errorMessage.value != null) ...[
                  const SizedBox(height: 14),
                  _InfoMessage(
                    message: reportController.errorMessage.value!,
                    isError: true,
                    icon: Icons.error_outline,
                  ),
                ],
                const SizedBox(height: 18),
                const Divider(),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed:
                        alreadySubmitted || reportController.isSubmitting.value
                            ? null
                            : reportController.submitReport,
                    icon: reportController.isSubmitting.value
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send_outlined),
                    label: Text(
                      reportController.isSubmitting.value
                          ? 'Submitting…'
                          : 'Submit report',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateSelector(
    BuildContext context,
    DailyReportController reportController,
    DateTime date,
  ) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel(label: 'Report date', icon: Icons.calendar_today),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () async {
            final now = DateTime.now();
            final selected = await showDatePicker(
              context: context,
              initialDate: date.isAfter(now) ? now : date,
              firstDate: DateTime(now.year - 2),
              lastDate: DateTime(now.year, now.month, now.day),
              helpText: 'Choose report date',
            );
            if (selected != null) reportController.selectDate(selected);
          },
          style: OutlinedButton.styleFrom(
            alignment: Alignment.centerLeft,
            minimumSize: const Size.fromHeight(48),
            side: BorderSide(color: colors.outlineVariant),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  DateFormat('MM/dd/yyyy').format(date),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Icon(Icons.calendar_month_outlined,
                  size: 18, color: colors.onSurfaceVariant),
            ],
          ),
        ),
      ],
    );
  }

  Widget _hoursField(BuildContext context, double hours) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FieldLabel(label: 'Hours worked', icon: Icons.access_time),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            hours.toStringAsFixed(1),
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'From attendance tracking (cannot be edited)',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(
    BuildContext context,
    DailyReportController reportController,
    List<EmployeeDailyReport> reports,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final filter = DropdownButtonFormField<String>(
                  initialValue: reportController.statusFilter.value,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'History status',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  items: const [
                    'All statuses',
                    'Pending',
                    'Approved',
                    'Rejected',
                  ]
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child:
                                Text(status, overflow: TextOverflow.ellipsis),
                          ))
                      .toList(),
                  onChanged: reportController.setStatusFilter,
                );
                final heading = Text(
                  'Report history',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                );
                if (constraints.maxWidth < 400) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heading,
                      const SizedBox(height: 10),
                      filter,
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: heading),
                    SizedBox(width: 180, child: filter),
                  ],
                );
              },
            ),
          ),
          if (reports.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 22),
              child: Column(
                children: [
                  Icon(Icons.inbox_outlined,
                      size: 34, color: colors.onSurfaceVariant),
                  const SizedBox(height: 8),
                  Text(
                    'No reports found',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Submitted reports will appear here with their review status.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var index = 0; index < reports.length; index++) ...[
                    DailyReportHistoryTile(report: reports[index]),
                    if (index != reports.length - 1) const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 15, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 7),
        Expanded(
          child: Text(label, style: theme.textTheme.labelLarge),
        ),
      ],
    );
  }
}

class _ReportTextField extends StatelessWidget {
  const _ReportTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.maxLines,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label, icon: icon),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          minLines: maxLines,
          maxLines: maxLines,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: hint,
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}

class _InfoMessage extends StatelessWidget {
  const _InfoMessage({
    required this.message,
    required this.icon,
    this.isError = false,
  });

  final String message;
  final IconData icon;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final foreground = isError ? colors.error : colors.primary;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isError ? colors.errorContainer : colors.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: foreground),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isError
                      ? colors.onErrorContainer
                      : colors.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
