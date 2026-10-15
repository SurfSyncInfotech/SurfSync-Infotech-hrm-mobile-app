import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_app/data/models/employee_daily_report.dart';
import 'package:hrms_app/data/repositories/attendance_repository.dart';
import 'package:hrms_app/data/repositories/employee_daily_report_repository.dart';
import 'package:hrms_app/data/repositories/employee_directory_repository.dart';
import 'package:intl/intl.dart';

class DailyReportController extends GetxController {
  DailyReportController({
    EmployeeDailyReportRepository? reportRepository,
    AttendanceRepository? attendanceRepository,
    EmployeeDirectoryRepository? employeeDirectory,
  })  : _reportRepository = reportRepository,
        _attendanceRepository = attendanceRepository,
        _employeeDirectory = employeeDirectory;

  EmployeeDailyReportRepository? _reportRepository;
  AttendanceRepository? _attendanceRepository;
  EmployeeDirectoryRepository? _employeeDirectory;

  EmployeeDailyReportRepository get reportRepository =>
      _reportRepository ??= Get.find<EmployeeDailyReportRepository>();
  AttendanceRepository get attendanceRepository =>
      _attendanceRepository ??= Get.find<AttendanceRepository>();
  EmployeeDirectoryRepository get employeeDirectory =>
      _employeeDirectory ??= Get.find<EmployeeDirectoryRepository>();

  final reportDate = DateTime.now().obs;
  final statusFilter = 'All statuses'.obs;
  final isLoading = true.obs;
  final isSubmitting = false.obs;
  final errorMessage = RxnString();

  final workDoneController = TextEditingController();
  final blockersController = TextEditingController();
  final plansController = TextEditingController();

  String get employeeId => employeeDirectory.current.id;
  String get employeeName => employeeDirectory.current.name;
  String get dateLabel => DateFormat('d MMM yyyy').format(reportDate.value);

  List<EmployeeDailyReport> get employeeReports =>
      reportRepository.forEmployee(employeeId);

  List<EmployeeDailyReport> get visibleReports {
    final reports = employeeReports;
    if (statusFilter.value == 'All statuses') return reports;
    return reports
        .where((report) =>
            report.status.toLowerCase() == statusFilter.value.toLowerCase())
        .toList();
  }

  int countFor(String status) {
    final reports = employeeReports;
    if (status == 'Submitted') return reports.length;
    return reports
        .where((report) => report.status.toLowerCase() == status.toLowerCase())
        .length;
  }

  double get hoursWorked {
    final selected = reportDate.value;
    for (final record in attendanceRepository.records) {
      if (record.employeeId == employeeId && _sameDate(record.date, selected)) {
        return (record.workedDuration?.inMinutes ?? 0) / 60;
      }
    }
    return 0;
  }

  bool get alreadySubmitted =>
      reportRepository.hasReportForDate(employeeId, reportDate.value);

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await reportRepository.load();
    } catch (error) {
      errorMessage.value = 'Could not load your reports: $error';
    } finally {
      isLoading.value = false;
    }
  }

  void selectDate(DateTime date) {
    reportDate.value = DateTime(date.year, date.month, date.day);
    errorMessage.value = null;
  }

  void setStatusFilter(String? status) {
    if (status != null) statusFilter.value = status;
  }

  Future<void> submitReport() async {
    if (isSubmitting.value) return;
    if (workDoneController.text.trim().isEmpty) {
      errorMessage.value = 'Describe the work completed before submitting.';
      return;
    }
    if (alreadySubmitted) {
      errorMessage.value = 'A report has already been submitted for this date.';
      return;
    }

    isSubmitting.value = true;
    errorMessage.value = null;
    try {
      final date = reportDate.value;
      await reportRepository.submit(
        EmployeeDailyReport(
          id: '${employeeId}_${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}',
          employeeId: employeeId,
          employeeName: employeeName,
          date: date,
          hoursWorked: hoursWorked,
          workDone: workDoneController.text.trim(),
          blockers: blockersController.text.trim(),
          plansForTomorrow: plansController.text.trim(),
          status: 'Pending',
        ),
      );
      workDoneController.clear();
      blockersController.clear();
      plansController.clear();
      Get.snackbar(
        'Report submitted',
        'Your daily work report is saved and awaiting review.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      errorMessage.value = error.toString().replaceFirst('Bad state: ', '');
    } finally {
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    workDoneController.dispose();
    blockersController.dispose();
    plansController.dispose();
    super.onClose();
  }

  bool _sameDate(DateTime first, DateTime second) =>
      first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}
