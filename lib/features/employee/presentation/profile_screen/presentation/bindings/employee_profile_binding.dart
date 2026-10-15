import 'package:get/get.dart';

import '../controllers/employee_profile_controller.dart';

class EmployeeProfileBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<EmployeeProfileController>()) {
      Get.lazyPut<EmployeeProfileController>(
        EmployeeProfileController.new,
        fenix: true,
      );
    }
  }
}
