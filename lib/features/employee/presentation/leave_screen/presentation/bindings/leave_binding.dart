import 'package:get/get.dart';

import '../controllers/leave_controller.dart';

class LeaveBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<LeaveController>()) {
      Get.lazyPut<LeaveController>(LeaveController.new, fenix: true);
    }
  }
}
