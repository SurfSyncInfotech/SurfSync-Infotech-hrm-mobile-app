import 'package:flutter/material.dart';

import '../../app/theme/app_dimensions.dart';
import '../../app/theme/app_text_styles.dart';
import 'app_card.dart';
import 'app_empty_state.dart';

class AppTableColumn<T> {
  const AppTableColumn({
    required this.label,
    required this.cell,
    this.numeric = false,
  });

  final String label;
  final Widget Function(T item) cell;
  final bool numeric;
}

/// Table on wide screens (horizontally scrollable if needed); optional card
/// list on phones via [mobileItemBuilder].
class AppDataTable<T> extends StatelessWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.mobileItemBuilder,
    this.footer,
    this.emptyState,
  });

  final List<AppTableColumn<T>> columns;
  final List<T> rows;
  final Widget Function(BuildContext context, T item)? mobileItemBuilder;
  final Widget? footer;
  final Widget? emptyState;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    if (rows.isEmpty) {
      return AppCard(
        child: emptyState ??
            const AppEmptyState(
              title: 'No records found',
              message: 'Try changing your search or filters.',
              icon: Icons.search_off_rounded,
            ),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      final isNarrow = constraints.maxWidth < AppDimensions.mobileBreakpoint;
      if (isNarrow && mobileItemBuilder != null) {
        return Column(
          children: [
            for (final row in rows)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: mobileItemBuilder!(context, row),
              ),
            if (footer != null) footer!,
          ],
        );
      }

      return AppCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth:
                      constraints.maxWidth > 2 ? constraints.maxWidth - 2 : 0,
                ),
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(
                    colors.surfaceContainerHighest,
                  ),
                  headingTextStyle: AppTextStyles.overline,
                  dataTextStyle: AppTextStyles.body,
                  dataRowMinHeight: 56,
                  dataRowMaxHeight: 64,
                  columnSpacing: 28,
                  horizontalMargin: 20,
                  dividerThickness: 1,
                  columns: [
                    for (final c in columns)
                      DataColumn(
                        label: Text(c.label.toUpperCase()),
                        numeric: c.numeric,
                      ),
                  ],
                  rows: [
                    for (final row in rows)
                      DataRow(cells: [
                        for (final c in columns) DataCell(c.cell(row)),
                      ]),
                  ],
                ),
              ),
            ),
            if (footer != null) ...[
              const Divider(height: 1),
              Padding(padding: const EdgeInsets.all(12), child: footer),
            ],
          ],
        ),
      );
    });
  }
}

/// "Showing 1–4 of 8" with previous / page numbers / next.
class AppPaginationBar extends StatelessWidget {
  const AppPaginationBar({
    super.key,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.onPageChanged,
  });

  final int page;
  final int pageSize;
  final int totalItems;
  final ValueChanged<int> onPageChanged;

  int get _totalPages => totalItems == 0 ? 1 : (totalItems / pageSize).ceil();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final start = totalItems == 0 ? 0 : (page - 1) * pageSize + 1;
    final end = (page * pageSize).clamp(0, totalItems);

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 8,
      spacing: 16,
      children: [
        Text('Showing $start–$end of $totalItems',
            style: AppTextStyles.bodyMuted),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Previous',
              onPressed: page > 1 ? () => onPageChanged(page - 1) : null,
              icon: const Icon(Icons.chevron_left_rounded),
            ),
            for (var p = 1; p <= _totalPages; p++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: TextButton(
                  onPressed: () => onPageChanged(p),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(36, 36),
                    padding: EdgeInsets.zero,
                    backgroundColor:
                        p == page ? colors.primary : Colors.transparent,
                    foregroundColor:
                        p == page ? colors.onPrimary : colors.onSurface,
                  ),
                  child: Text('$p'),
                ),
              ),
            IconButton(
              tooltip: 'Next',
              onPressed:
                  page < _totalPages ? () => onPageChanged(page + 1) : null,
              icon: const Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
      ],
    );
  }
}
