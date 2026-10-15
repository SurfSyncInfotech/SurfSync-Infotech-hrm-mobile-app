import 'package:get/get.dart';

import '../controllers/login_controller.dart';

/// Shared by the employee and admin sign-in routes. The controller is kept
/// alive so switching between the two routes never disposes it mid-transition.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<LoginController>()) {
      Get.put<LoginController>(LoginController(), permanent: true);
    }
  }
}
