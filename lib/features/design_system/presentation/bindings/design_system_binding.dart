import 'package:get/get.dart';

import '../controllers/design_system_controller.dart';

class DesignSystemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DesignSystemController>(() => DesignSystemController());
  }
}
