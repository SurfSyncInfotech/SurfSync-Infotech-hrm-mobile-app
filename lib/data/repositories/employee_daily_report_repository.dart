import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/employee_daily_report.dart';

class EmployeeDailyReportRepository extends GetxService {
  static const _storageKey = 'employee_daily_reports_v1';

  final reports = <EmployeeDailyReport>[].obs;
  bool _loaded = false;

  Future<void> load() async {
    if (_loaded) return;
    final preferences = await SharedPreferences.getInstance();
    final raw = preferences.getString(_storageKey);
    if (raw != null && raw.isNotEmpty) {
      final decoded = jsonDecode(raw) as List<dynamic>;
      reports.assignAll(
        decoded
            .map((item) =>
                EmployeeDailyReport.fromJson(item as Map<String, dynamic>))
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date)),
      );
    }
    _loaded = true;
  }

  List<EmployeeDailyReport> forEmployee(String employeeId) =>
      reports.where((report) => report.employeeId == employeeId).toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  bool hasReportForDate(String employeeId, DateTime date) => reports.any(
        (report) =>
            report.employeeId == employeeId &&
            report.date.year == date.year &&
            report.date.month == date.month &&
            report.date.day == date.day,
      );

  Future<void> submit(EmployeeDailyReport report) async {
    if (hasReportForDate(report.employeeId, report.date)) {
      throw StateError('A report has already been submitted for this date.');
    }
    final updated = [report, ...reports];
    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setString(
      _storageKey,
      jsonEncode(updated.map((item) => item.toJson()).toList()),
    );
    if (!saved) {
      throw StateError('The report could not be saved on this device.');
    }
    reports.assignAll(updated);
  }
}
