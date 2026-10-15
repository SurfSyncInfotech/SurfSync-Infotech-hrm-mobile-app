import 'package:get/get.dart';

import '../models/hr_records.dart';
import 'employee_directory_repository.dart';

class HrRecordsRepository extends GetxService {
  final offerLetters = <OfferLetterRecord>[].obs;
  final assets = <AssetRecord>[].obs;
  final performance = <PerformanceRecord>[].obs;
  final workReports = <DailyWorkReportRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    final people = Get.find<EmployeeDirectoryRepository>().employees;
    offerLetters.assignAll([
      for (final employee in people.take(4))
        OfferLetterRecord(
          id: 'OL-${employee.id}',
          employeeName: employee.name,
          role: employee.designation,
          issuedOn: employee.joiningDate,
          status: employee.profileComplete ? 'Issued' : 'Draft',
        ),
    ]);
    assets.assignAll([
      for (final employee in people.where((e) => e.status == 'Active').take(5))
        AssetRecord(
          id: 'AST-${employee.id}',
          employeeName: employee.name,
          item: employee.department == 'Development'
              ? 'Laptop'
              : 'Workstation kit',
          serial: 'SN-${employee.id.hashCode.abs()}',
          status: 'Assigned',
        ),
    ]);
    performance.assignAll([
      for (final employee in people.where((e) => e.status != 'Inactive'))
        PerformanceRecord(
          employeeName: employee.name,
          department: employee.department,
          score: 3.4 + (employee.id.hashCode.abs() % 16) / 10,
          period: 'Oct 2026',
        ),
    ]);
    workReports.assignAll([
      for (final employee in people.where((e) => e.status == 'Active').take(6))
        DailyWorkReportRecord(
          employeeName: employee.name,
          date: DateTime.now().subtract(const Duration(days: 1)),
          summary: 'Logged planned tasks for ${employee.department}.',
          status: 'Submitted',
        ),
    ]);
  }
}
