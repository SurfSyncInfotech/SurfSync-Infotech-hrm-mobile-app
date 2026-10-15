import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../app/routes/app_routes.dart';
import '../../../../../../shared/layouts/employee_layout.dart';
import '../controllers/settings_controller.dart';
import '../widgets/settings_appearance_section.dart';
import '../widgets/settings_header.dart';
import '../widgets/settings_logout_tile.dart';
import '../widgets/settings_profile_card.dart';
import '../widgets/settings_section.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final content = Obx(
      () => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SettingsHeader(title: 'Settings'),
            const SizedBox(height: 16),
            const SettingsProfileCard(),
            const SizedBox(height: 18),
            ...controller.sections.expand((section) => [
                  SettingsSectionWidget(section: section),
                  const SizedBox(height: 16),
                ]),
            const SettingsAppearanceSection(),
            const SizedBox(height: 16),
            const SettingsLogoutTile(),
          ],
        ),
      ),
    );

    if (embedded) return content;
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeSettings,
      child: content,
    );
  }
}
