import 'package:flutter/material.dart';
import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

class EmployeePayslipsView extends StatelessWidget {
  const EmployeePayslipsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final content = ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Text(
          'My Payslips',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            const gap = 12.0;
            final columns = constraints.maxWidth >= 640 ? 3 : 1;
            final width =
                (constraints.maxWidth - gap * (columns - 1)) / columns;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                SizedBox(
                  width: width,
                  child: const _PayslipSummaryCard(
                    label: 'YTD gross',
                    amount: '₹0.00',
                  ),
                ),
                SizedBox(
                  width: width,
                  child: const _PayslipSummaryCard(
                    label: 'YTD deductions',
                    amount: '₹0.00',
                  ),
                ),
                SizedBox(
                  width: width,
                  child: const _PayslipSummaryCard(
                    label: 'YTD net',
                    amount: '₹0.00',
                    highlighted: true,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: colors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Text(
                  'Published payslips',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 36,
                      color: colors.onSurfaceVariant,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'No published payslips yet',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your salary slips will appear here once they are published by HR.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return EmployeeLayout(
      currentRoute: AppRoutes.employeePayslips,
      scrollBody: false,
      child: content,
    );
  }
}

class _PayslipSummaryCard extends StatelessWidget {
  const _PayslipSummaryCard({
    required this.label,
    required this.amount,
    this.highlighted = false,
  });

  final String label;
  final String amount;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Card(
      margin: EdgeInsets.zero,
      color: highlighted ? colors.primaryContainer : colors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.onSurfaceVariant,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              amount,
              style: theme.textTheme.titleMedium?.copyWith(
                color:
                    highlighted ? colors.onPrimaryContainer : colors.onSurface,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
