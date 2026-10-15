import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/theme/app_dimensions.dart';
import '../../app/theme/app_text_styles.dart';

abstract class AppConfirmDialog {
  AppConfirmDialog._();

  /// Shows a confirmation dialog and resolves to `true` when confirmed.
  static Future<bool> show({
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool destructive = false,
  }) async {
    final colors = Get.theme.colorScheme;
    final result = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        title: Text(title, style: AppTextStyles.heading3),
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Text(message, style: AppTextStyles.bodyMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelLabel,
                style: TextStyle(color: colors.onSurfaceVariant)),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: destructive ? colors.error : colors.primary,
              foregroundColor: destructive ? colors.onError : colors.onPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
              ),
            ),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}
