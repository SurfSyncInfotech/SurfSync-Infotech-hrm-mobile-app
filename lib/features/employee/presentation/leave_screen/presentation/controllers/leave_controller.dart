import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrms_app/data/models/leave_models.dart';
import 'package:hrms_app/data/repositories/leave_repository.dart';

class LeaveController extends GetxController {
  LeaveController({LeaveRepository? repository}) : _repository = repository;

  LeaveRepository? _repository;
  LeaveRepository get repository => _repository ??= Get.find<LeaveRepository>();

  final selectedType = LeaveType.casual.obs;
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().obs;
  final reasonController = TextEditingController();
  final formError = RxnString();

  int get calculatedDays =>
      repository.workingDays(startDate.value, endDate.value);

  Future<void> pickStart(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate.value,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked == null) return;
    startDate.value = picked;
    if (endDate.value.isBefore(picked)) endDate.value = picked;
  }

  Future<void> pickEnd(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: endDate.value.isBefore(startDate.value)
          ? startDate.value
          : endDate.value,
      firstDate: startDate.value,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) endDate.value = picked;
  }

  Future<void> submit() async {
    formError.value = null;
    final error = await repository.submit(
      type: selectedType.value,
      start: startDate.value,
      end: endDate.value,
      reason: reasonController.text,
    );
    if (error != null) {
      formError.value = error;
      return;
    }
    reasonController.clear();
    Get.snackbar(
      'Leave submitted',
      'Your request is pending approval.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }
}
