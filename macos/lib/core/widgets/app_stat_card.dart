import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';
import 'app_card.dart';

class AppStatCard extends StatelessWidget {
  const AppStatCard({
    super.key,
    required this.label,
    required this.value,
    this.caption,
    this.icon,
    this.valueColor,
  });

  final String label;
  final String value;
  final String? caption;
  final IconData? icon;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(label.toUpperCase(),
                    style: AppTextStyles.overline,
                    overflow: TextOverflow.ellipsis),
              ),
              if (icon != null)
                Icon(icon, size: 18, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.heading1
                .copyWith(fontSize: 28, color: valueColor ?? AppColors.textPrimary),
          ),
          if (caption != null) ...[
            const SizedBox(height: 4),
            Text(caption!, style: AppTextStyles.bodyMuted.copyWith(fontSize: 12.5)),
          ],
        ],
      ),
    );
  }
}

/// Responsive grid for [AppStatCard]s: N columns on desktop, 2 on tablet, 1 on phones.
class AppStatGrid extends StatelessWidget {
  const AppStatGrid({
    super.key,
    required this.items,
    this.desktopColumns = 4,
    this.spacing = 12,
  });

  final List<Widget> items;
  final int desktopColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final cols = w >= 1000 ? desktopColumns : (w >= 560 ? 2 : 1);
      final itemWidth = (w - spacing * (cols - 1)) / cols;
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [for (final i in items) SizedBox(width: itemWidth, child: i)],
      );
    });
  }
}
