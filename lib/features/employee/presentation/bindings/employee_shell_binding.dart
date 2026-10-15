import 'package:get/get.dart';

import '../attendance_screen/presentation/bindings/attendance_binding.dart';
import '../daily_report_screen/presentation/bindings/daily_report_binding.dart';
import '../home_screen/presentation/bindings/home_binding.dart';
import '../leave_screen/presentation/bindings/leave_binding.dart';
import '../notifications_screen/presentation/bindings/notifications_binding.dart';
import '../profile_screen/presentation/bindings/employee_profile_binding.dart';
import '../settings_screen/presentation/bindings/settings_binding.dart';
import '../controllers/employee_shell_controller.dart';

class EmployeeShellBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<EmployeeShellController>()) {
      Get.lazyPut<EmployeeShellController>(
        EmployeeShellController.new,
        fenix: true,
      );
    }
    HomeBinding().dependencies();
    AttendanceBinding().dependencies();
    DailyReportBinding().dependencies();
    EmployeeProfileBinding().dependencies();
    LeaveBinding().dependencies();
    SettingsBinding().dependencies();
    NotificationsBinding().dependencies();
  }
}
