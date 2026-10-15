import 'package:flutter/material.dart';

import '../../app/theme/app_text_styles.dart';
import 'app_card.dart';

/// Card with a deep-green header bar, as used on profile and dashboard panels.
class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 12),
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerBg = isDark ? colors.surfaceContainerHighest : colors.primary;
    final headerFg = isDark ? colors.primary : colors.onPrimary;

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: headerBg,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    style: AppTextStyles.bodyBold.copyWith(
                      color: headerFg,
                      fontSize: 12.5,
                      letterSpacing: 0.9,
                    ),
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

/// Label on the left, bold value on the right, with a hairline divider.
class AppKeyValueRow extends StatelessWidget {
  const AppKeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
    this.showDivider = true,
  });

  final String label;
  final String value;
  final Widget? trailing;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: showDivider
            ? Border(bottom: BorderSide(color: colors.outline))
            : null,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 340) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodyMuted
                      .copyWith(color: colors.onSurfaceVariant),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: AppTextStyles.bodyBold
                            .copyWith(color: colors.onSurface),
                      ),
                    ),
                    if (trailing != null) trailing!,
                  ],
                ),
              ],
            );
          }

          return Row(
            children: [
              Text(
                label,
                style: AppTextStyles.bodyMuted
                    .copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.right,
                  style:
                      AppTextStyles.bodyBold.copyWith(color: colors.onSurface),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          );
        },
      ),
    );
  }
}
