import 'package:get/get.dart';

import '../controllers/employee_notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<EmployeeNotificationsController>()) {
      Get.lazyPut<EmployeeNotificationsController>(
        EmployeeNotificationsController.new,
        fenix: true,
      );
    }
  }
}
