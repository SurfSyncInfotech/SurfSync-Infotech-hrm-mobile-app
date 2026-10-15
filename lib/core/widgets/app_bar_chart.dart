import 'package:flutter/material.dart';

import '../../app/theme/app_text_styles.dart';

class AppBarChart extends StatelessWidget {
  const AppBarChart({
    super.key,
    required this.values,
    this.maxValue,
    this.height = 180,
  });

  final Map<String, double> values;
  final double? maxValue;
  final double height;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return Text('No data for this range', style: AppTextStyles.bodyMuted);
    }
    final colors = Theme.of(context).colorScheme;
    final peak = maxValue ??
        values.values.fold<double>(0, (m, v) => v > m ? v : m).clamp(1, 9999);
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final entry in values.entries)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FractionallySizedBox(
                          heightFactor: (entry.value / peak).clamp(0.04, 1),
                          widthFactor: 0.7,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: colors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      entry.key,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.overline.copyWith(
                        fontSize: 10,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AppHorizontalBarChart extends StatelessWidget {
  const AppHorizontalBarChart({super.key, required this.values});

  final Map<String, double> values;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return Text('No data for this range', style: AppTextStyles.bodyMuted);
    }
    final colors = Theme.of(context).colorScheme;
    final peak =
        values.values.fold<double>(0, (m, v) => v > m ? v : m).clamp(1, 9999);
    return Column(
      children: [
        for (final entry in values.entries)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    entry.key,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMuted.copyWith(fontSize: 12),
                  ),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: (entry.value / peak).clamp(0, 1),
                      color: colors.primary,
                      backgroundColor: colors.surfaceContainerHighest,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 48,
                  child: Text(
                    entry.value % 1 == 0
                        ? entry.value.toStringAsFixed(0)
                        : entry.value.toStringAsFixed(1),
                    textAlign: TextAlign.right,
                    style: AppTextStyles.bodyBold.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
