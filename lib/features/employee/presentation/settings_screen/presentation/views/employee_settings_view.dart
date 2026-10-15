import 'package:flutter/material.dart';

import 'settings_view.dart';

class EmployeeSettingsView extends StatelessWidget {
  const EmployeeSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView(embedded: true);
  }
}
