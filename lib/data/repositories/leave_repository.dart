import 'package:get/get.dart';

import '../../features/employee/data/models/employee_model.dart';
import '../models/company_settings_model.dart';
import '../models/leave_models.dart';
import 'company_settings_repository.dart';
import 'employee_directory_repository.dart';

class LeaveRepository extends GetxService {
  final balances = <LeaveBalance>[].obs;
  final requests = <LeaveRequest>[].obs;
  final isSubmitting = false.obs;

  CompanySettingsModel get _settings =>
      Get.find<CompanySettingsRepository>().settings.value;

  Employee get _me => Get.find<EmployeeDirectoryRepository>().current;

  @override
  void onInit() {
    super.onInit();
    balances.assignAll([
      LeaveBalance(
        type: LeaveType.casual,
        allocated: _settings.casualLeaveDays,
        used: 0,
        pending: 0,
      ),
      LeaveBalance(
        type: LeaveType.sick,
        allocated: _settings.sickLeaveDays,
        used: 0,
        pending: 0,
      ),
    ]);
    requests.assignAll([
      LeaveRequest(
        id: 'LV-1001',
        employeeId: _me.id,
        employeeName: _me.name,
        type: LeaveType.casual,
        start: DateTime(2026, 9, 22),
        end: DateTime(2026, 9, 22),
        days: 1,
        appliedOn: DateTime(2026, 9, 18),
        status: LeaveStatus.approved,
        reason: 'Personal work',
      ),
    ]);
    _recomputeBalances();
  }

  LeaveBalance balanceOf(LeaveType type) =>
      balances.firstWhere((b) => b.type == type);

  int workingDays(DateTime start, DateTime end) {
    if (end.isBefore(start)) return 0;
    var count = 0;
    for (var cursor = DateTime(start.year, start.month, start.day);
        !cursor.isAfter(DateTime(end.year, end.month, end.day));
        cursor = cursor.add(const Duration(days: 1))) {
      if (!_settings.weekendDays.contains(cursor.weekday)) count++;
    }
    return count;
  }

  bool overlaps(DateTime start, DateTime end) {
    return requests.any((request) {
      if (request.employeeId != _me.id) return false;
      if (request.status == LeaveStatus.rejected) return false;
      return !request.end.isBefore(start) && !request.start.isAfter(end);
    });
  }

  Future<String?> submit({
    required LeaveType type,
    required DateTime start,
    required DateTime end,
    required String reason,
  }) async {
    if (end.isBefore(start)) {
      return 'Start date cannot be after end date.';
    }
    final days = workingDays(start, end);
    if (days <= 0) {
      return 'The selected range has no working days.';
    }
    if (overlaps(start, end)) {
      return 'This request overlaps an existing leave.';
    }
    final balance = balanceOf(type);
    if (days > balance.remaining) {
      return 'Not enough ${type.label.toLowerCase()} remaining.';
    }

    isSubmitting.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    requests.insert(
      0,
      LeaveRequest(
        id: 'LV-${DateTime.now().millisecondsSinceEpoch}',
        employeeId: _me.id,
        employeeName: _me.name,
        type: type,
        start: start,
        end: end,
        days: days,
        appliedOn: DateTime.now(),
        status: LeaveStatus.pending,
        reason: reason.trim(),
      ),
    );
    _recomputeBalances();
    isSubmitting.value = false;
    return null;
  }

  void _recomputeBalances() {
    for (final balance in balances) {
      final mine = requests.where(
        (r) => r.employeeId == _me.id && r.type == balance.type,
      );
      balance.used =
          mine.where((r) => r.status == LeaveStatus.approved).fold(0, (s, r) => s + r.days);
      balance.pending =
          mine.where((r) => r.status == LeaveStatus.pending).fold(0, (s, r) => s + r.days);
    }
    balances.refresh();
    requests.refresh();
  }
}
