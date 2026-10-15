import 'package:flutter/material.dart';

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
    final colors = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        fillColor: colors.surface,
        prefixIcon: Icon(
          Icons.search_rounded,
          size: 20,
          color: colors.onSurfaceVariant,
        ),
      ),
    );
  }
}
