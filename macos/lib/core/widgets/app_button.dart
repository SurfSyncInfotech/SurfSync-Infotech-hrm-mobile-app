import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimensions.dart';
import '../../app/theme/app_text_styles.dart';

enum AppButtonType { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.fullWidth = false,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final IconData? icon;
  final bool fullWidth;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final filled = type == AppButtonType.primary || type == AppButtonType.secondary;
    final Color fg = filled
        ? Colors.white
        : (type == AppButtonType.outline
            ? AppColors.textPrimary
            : AppColors.forest);

    final content = loading
        ? SizedBox(
            height: 18,
            width: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
              Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
            ],
          );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
    );
    const padding = EdgeInsets.symmetric(horizontal: 20, vertical: 15);
    final VoidCallback? action = loading ? null : onPressed;

    Widget button;
    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.secondary:
        button = ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
            backgroundColor: type == AppButtonType.primary
                ? AppColors.orange
                : AppColors.forest,
            foregroundColor: Colors.white,
            disabledBackgroundColor:
                (type == AppButtonType.primary ? AppColors.orange : AppColors.forest)
                    .withValues(alpha: 0.6),
            disabledForegroundColor: Colors.white,
            elevation: 0,
            padding: padding,
            shape: shape,
            textStyle: AppTextStyles.button,
          ),
          child: content,
        );
      case AppButtonType.outline:
        button = OutlinedButton(
          onPressed: action,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            side: const BorderSide(color: AppColors.border),
            padding: padding,
            shape: shape,
            textStyle: AppTextStyles.button,
          ),
          child: content,
        );
      case AppButtonType.text:
        button = TextButton(
          onPressed: action,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.forest,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            shape: shape,
            textStyle: AppTextStyles.button,
          ),
          child: content,
        );
    }

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
