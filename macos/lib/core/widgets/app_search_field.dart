import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    this.hint = 'Search...',
    this.onChanged,
    this.controller,
  });

  final String hint;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        fillColor: AppColors.surface,
        prefixIcon: const Icon(Icons.search_rounded,
            size: 20, color: AppColors.textSecondary),
      ),
    );
  }
}
