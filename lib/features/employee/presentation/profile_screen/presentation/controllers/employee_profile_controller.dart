import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrms_app/data/repositories/employee_directory_repository.dart';
import 'package:hrms_app/features/employee/data/models/employee_model.dart';

class EmployeeProfileController extends GetxController {
  EmployeeDirectoryRepository get directory =>
      Get.find<EmployeeDirectoryRepository>();

  Employee get employee => directory.current;

  final showAccountNumber = false.obs;

  void toggleAccountNumber() => showAccountNumber.toggle();

  Future<void> editProfile(BuildContext context) async {
    final phone = TextEditingController(text: employee.phone);
    final address = TextEditingController(text: employee.address);
    final personalEmail = TextEditingController(text: employee.personalEmail);
    final saved = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Edit profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: phone,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: personalEmail,
              decoration: const InputDecoration(labelText: 'Personal email'),
            ),
            TextField(
              controller: address,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Save')),
        ],
      ),
    );
    if (saved == true) {
      directory.upsert(employee.copyWith(
        phone: phone.text.trim(),
        personalEmail: personalEmail.text.trim(),
        address: address.text.trim(),
      ));
      update();
    }
    phone.dispose();
    address.dispose();
    personalEmail.dispose();
  }
}
