import 'package:get/get.dart';
import 'package:hrms_app/data/repositories/employee_daily_report_repository.dart';

import '../controllers/daily_report_controller.dart';

class DailyReportBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<EmployeeDailyReportRepository>()) {
      Get.lazyPut<EmployeeDailyReportRepository>(
        EmployeeDailyReportRepository.new,
        fenix: true,
      );
    }
    if (!Get.isRegistered<DailyReportController>()) {
      Get.lazyPut<DailyReportController>(
        DailyReportController.new,
        fenix: true,
      );
    }
  }
}
