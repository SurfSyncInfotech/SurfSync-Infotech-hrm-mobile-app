import 'package:get/get.dart';

import '../../features/auth/presentation/controllers/session_controller.dart';

/// Registers app-wide dependencies that live for the whole app lifetime.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SessionController>(SessionController(), permanent: true);
  }
}
