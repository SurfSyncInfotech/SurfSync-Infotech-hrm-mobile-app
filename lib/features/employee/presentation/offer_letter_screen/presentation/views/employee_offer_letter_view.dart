import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/data/models/hr_records.dart';
import 'package:hrms_app/data/repositories/employee_directory_repository.dart';
import 'package:hrms_app/data/repositories/hr_records_repository.dart';
import 'package:hrms_app/features/employee/data/models/employee_model.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';
import 'package:intl/intl.dart';

class EmployeeOfferLetterView extends StatelessWidget {
  const EmployeeOfferLetterView({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = Get.find<EmployeeDirectoryRepository>().current;
    final offer = Get.find<HrRecordsRepository>().offerLetters.firstWhereOrNull(
          (record) => record.employeeName == employee.name,
        );

    return EmployeeLayout(
      currentRoute: AppRoutes.employeeOfferLetter,
      scrollBody: false,
      child: offer == null
          ? const _OfferLetterEmptyState()
          : _OfferLetterContent(
              offer: offer,
              employee: employee,
            ),
    );
  }
}

class _OfferLetterContent extends StatelessWidget {
  const _OfferLetterContent({
    required this.offer,
    required this.employee,
  });

  final OfferLetterRecord offer;
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final statusColor = switch (offer.status.toLowerCase()) {
      'accepted' || 'approved' => colors.primary,
      'rejected' || 'declined' => colors.error,
      'draft' => colors.onSurfaceVariant,
      _ => colors.tertiary,
    };

    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Text(
          'My Offer Letter',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Review the details of your employment offer.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 12,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.description_outlined,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minWidth: 180),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer.role,
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: colors.onSurface,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Employee ID ${employee.id}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _OfferStatusChip(
                      label: offer.status,
                      color: statusColor,
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  'Offer details',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    const gap = 12.0;
                    final columns = constraints.maxWidth >= 700
                        ? 3
                        : constraints.maxWidth >= 430
                            ? 2
                            : 1;
                    final width =
                        (constraints.maxWidth - gap * (columns - 1)) / columns;
                    return Wrap(
                      spacing: gap,
                      runSpacing: gap,
                      children: [
                        SizedBox(
                          width: width,
                          child: _OfferDetailCard(
                            label: 'Position',
                            value: offer.role,
                            icon: Icons.work_outline_rounded,
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: _OfferDetailCard(
                            label: 'Joining date',
                            value: DateFormat('d MMM yyyy')
                                .format(employee.joiningDate),
                            icon: Icons.event_outlined,
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: _OfferDetailCard(
                            label: 'Reporting manager',
                            value: employee.reportingManager,
                            icon: Icons.supervisor_account_outlined,
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: _OfferDetailCard(
                            label: 'Department',
                            value: employee.department,
                            icon: Icons.apartment_rounded,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                const _DocumentNotice(),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'Your response',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'For changes to this offer or to submit your response, please contact your HR representative.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OfferStatusChip extends StatelessWidget {
  const _OfferStatusChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
        ),
      ),
    );
  }
}

class _OfferDetailCard extends StatelessWidget {
  const _OfferDetailCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      constraints: const BoxConstraints(minHeight: 96),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: colors.primary),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurface,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentNotice extends StatelessWidget {
  const _DocumentNotice();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.picture_as_pdf_outlined, color: colors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Offer document',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'No PDF is attached to this offer yet. Contact HR if you need a copy.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.45,
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

class _OfferLetterEmptyState extends StatelessWidget {
  const _OfferLetterEmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ListView(
      children: [
        Text(
          'My Offer Letter',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Review the details of your employment offer.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 20),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 42,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(height: 12),
                Text(
                  'No offer letter available',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your offer letter will appear here once it has been issued by HR.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
