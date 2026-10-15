import 'package:flutter/material.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../shared/layouts/admin_layout.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminLayout(
      currentRoute: AppRoutes.adminDashboard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _KpiRow(
            stats: [
              _StatCard(label: 'Employees', value: '128'),
              _StatCard(label: 'Present', value: '96'),
              _StatCard(label: 'On leave', value: '8'),
              _StatCard(label: 'Open tasks', value: '17'),
            ],
          ),
          SizedBox(height: 18),
          _PanelCard(
            title: 'Company activity',
            body:
                'New hires this month: 6\nAttendance rate: 94%\nPayroll run: 3 days away\nHighlights: onboarding completed for 4 staff',
          ),
        ],
      ),
    );
  }
}

class _KpiRow extends StatelessWidget {
  const _KpiRow({required this.stats});

  final List<_StatCard> stats;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: stats,
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 180,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                fontSize: 13,
                color: colors.onSurfaceVariant,
              )),
          const SizedBox(height: 12),
          Text(value,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: colors.onSurface,
              )),
        ],
      ),
    );
  }
}

class _PanelCard extends StatelessWidget {
  const _PanelCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colors.onSurface,
              )),
          const SizedBox(height: 12),
          Text(body,
              style: TextStyle(
                fontSize: 14,
                height: 1.7,
                color: colors.onSurfaceVariant,
              )),
        ],
      ),
    );
  }
}
