import 'package:get/get.dart';

import '../controllers/admin_attendance_controller.dart';
import '../controllers/admin_dashboard_controller.dart';
import '../controllers/company_settings_controller.dart';
import '../controllers/employee_management_controller.dart';

class AdminShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminDashboardController>(AdminDashboardController.new);
    Get.lazyPut<EmployeeManagementController>(
      EmployeeManagementController.new,
    );
    Get.lazyPut<AdminAttendanceController>(AdminAttendanceController.new);
    Get.lazyPut<CompanySettingsController>(CompanySettingsController.new);
  }
}
