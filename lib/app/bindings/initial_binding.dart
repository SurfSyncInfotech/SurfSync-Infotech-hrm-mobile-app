import 'package:get/get.dart';

import '../../data/repositories/attendance_repository.dart';
import '../../data/repositories/company_settings_repository.dart';
import '../../data/repositories/employee_directory_repository.dart';
import '../../data/repositories/hr_records_repository.dart';
import '../../data/repositories/leave_repository.dart';
import '../../data/services/activity_session_service.dart';
import '../../features/auth/presentation/controllers/session_controller.dart';
import '../../features/employee/presentation/notifications_screen/presentation/controllers/employee_notifications_controller.dart';

import '../theme/theme_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<ThemeController>()) {
      Get.put<ThemeController>(ThemeController(), permanent: true);
    }
    Get.put<SessionController>(SessionController(), permanent: true);
    Get.put<EmployeeNotificationsController>(
      EmployeeNotificationsController(),
      permanent: true,
    );
    Get.put<CompanySettingsRepository>(
      CompanySettingsRepository(),
      permanent: true,
    );
    Get.put<EmployeeDirectoryRepository>(
      EmployeeDirectoryRepository(),
      permanent: true,
    );
    Get.put<AttendanceRepository>(AttendanceRepository(), permanent: true);
    Get.put<LeaveRepository>(LeaveRepository(), permanent: true);
    Get.put<HrRecordsRepository>(HrRecordsRepository(), permanent: true);
    Get.put<ActivitySessionService>(ActivitySessionService(), permanent: true);
  }
}
