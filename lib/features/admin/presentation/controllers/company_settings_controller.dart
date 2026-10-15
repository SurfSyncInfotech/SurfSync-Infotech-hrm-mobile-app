import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/company_settings_repository.dart';

class CompanySettingsController extends GetxController {
  CompanySettingsRepository get repository =>
      Get.find<CompanySettingsRepository>();

  Future<void> pickStart(BuildContext context) async {
    final settings = repository.settings.value;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.workStart.inHours,
        minute: settings.workStart.inMinutes.remainder(60),
      ),
    );
    if (picked == null) return;
    settings.workStart = Duration(hours: picked.hour, minutes: picked.minute);
    repository.settings.refresh();
  }

  Future<void> pickEnd(BuildContext context) async {
    final settings = repository.settings.value;
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: settings.workEnd.inHours,
        minute: settings.workEnd.inMinutes.remainder(60),
      ),
    );
    if (picked == null) return;
    settings.workEnd = Duration(hours: picked.hour, minutes: picked.minute);
    repository.settings.refresh();
  }

  void toggleLocation(bool value) {
    repository.settings.value.requireLocation = value;
    repository.settings.refresh();
  }
}
