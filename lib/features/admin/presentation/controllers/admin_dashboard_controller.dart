import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/models/attendance_record.dart';
import '../../../../data/models/leave_models.dart';
import '../../../../data/repositories/attendance_repository.dart';
import '../../../../data/repositories/company_settings_repository.dart';
import '../../../../data/repositories/employee_directory_repository.dart';
import '../../../../data/repositories/leave_repository.dart';
import '../../../../features/employee/data/models/employee_model.dart';

class AnalyticsInsight {
  const AnalyticsInsight({required this.warning, required this.text});

  final bool warning;
  final String text;
}

class AdminDashboardController extends GetxController {
  final from = DateTime(DateTime.now().year, DateTime.now().month, 1).obs;
  final to = DateTime.now().obs;

  EmployeeDirectoryRepository get directory =>
      Get.find<EmployeeDirectoryRepository>();
  AttendanceRepository get attendance => Get.find<AttendanceRepository>();
  LeaveRepository get leaves => Get.find<LeaveRepository>();
  CompanySettingsRepository get settings =>
      Get.find<CompanySettingsRepository>();

  List<Employee> get activeEmployees => directory.employees
      .where((e) => e.status != 'Inactive')
      .toList();

  List<AttendanceRecord> get scopedRecords {
    final start = DateTime(from.value.year, from.value.month, from.value.day);
    final end = DateTime(to.value.year, to.value.month, to.value.day, 23, 59);
    return attendance.records
        .where((r) => !r.date.isBefore(start) && !r.date.isAfter(end))
        .toList();
  }

  int get headcount => activeEmployees.length;

  int get presentToday {
    final now = DateTime.now();
    return attendance.records
        .where((r) =>
            r.checkIn != null &&
            r.date.year == now.year &&
            r.date.month == now.month &&
            r.date.day == now.day)
        .length;
  }

  int get expectedToday => activeEmployees
      .where((e) => e.status != 'On Leave')
      .length;

  double get attendanceRate {
    final expected = scopedRecords.length;
    if (expected == 0) return 0;
    final present = scopedRecords.where((r) => r.checkIn != null).length;
    return present / expected * 100;
  }

  double get averageHours {
    final present = scopedRecords.where((r) => r.workedDuration != null);
    if (present.isEmpty) return 0;
    final minutes = present.fold<int>(
      0,
      (sum, r) => sum + r.workedDuration!.inMinutes,
    );
    return minutes / present.length / 60;
  }

  int get lateCheckIns =>
      scopedRecords.where((r) => r.checkIn != null && r.isLate).length;

  int get leaveDaysTaken => leaves.requests
      .where((r) => r.status == LeaveStatus.approved)
      .fold(0, (sum, r) => sum + r.days);

  Map<String, double> get attendanceByDepartment {
    final grouped = <String, List<AttendanceRecord>>{};
    for (final record in scopedRecords) {
      grouped.putIfAbsent(record.department, () => []).add(record);
    }
    return {
      for (final entry in grouped.entries)
        entry.key: entry.value.isEmpty
            ? 0
            : entry.value.where((r) => r.checkIn != null).length /
                entry.value.length *
                100,
    };
  }

  Map<String, double> get attendanceByWeekday {
    const labels = {
      DateTime.monday: 'Mon',
      DateTime.tuesday: 'Tue',
      DateTime.wednesday: 'Wed',
      DateTime.thursday: 'Thu',
      DateTime.friday: 'Fri',
      DateTime.saturday: 'Sat',
      DateTime.sunday: 'Sun',
    };
    final grouped = <int, List<AttendanceRecord>>{};
    for (final record in scopedRecords) {
      grouped.putIfAbsent(record.date.weekday, () => []).add(record);
    }
    return {
      for (final weekday in labels.keys)
        labels[weekday]!: grouped[weekday] == null || grouped[weekday]!.isEmpty
            ? 0
            : grouped[weekday]!.where((r) => r.checkIn != null).length /
                grouped[weekday]!.length *
                100,
    };
  }

  Map<String, int> get leaveDaysByType {
    final map = <String, int>{};
    for (final request in leaves.requests) {
      if (request.status != LeaveStatus.approved) continue;
      map[request.type.label] = (map[request.type.label] ?? 0) + request.days;
    }
    return map;
  }

  List<(String employeeName, String department, int absent, int late)>
      get mostAbsences {
    final absent = <String, int>{};
    final late = <String, int>{};
    final dept = <String, String>{};
    for (final record in scopedRecords) {
      dept[record.employeeId] = record.department;
      if (record.checkIn == null) {
        absent[record.employeeId] = (absent[record.employeeId] ?? 0) + 1;
      } else if (record.isLate) {
        late[record.employeeId] = (late[record.employeeId] ?? 0) + 1;
      }
    }
    final ids = {...absent.keys, ...late.keys}.toList()
      ..sort((a, b) => (absent[b] ?? 0).compareTo(absent[a] ?? 0));
    return [
      for (final id in ids.take(5))
        (
          directory.employees
              .firstWhere((e) => e.id == id,
                  orElse: () => directory.current)
              .name,
          dept[id] ?? '—',
          absent[id] ?? 0,
          late[id] ?? 0,
        ),
    ];
  }

  List<AnalyticsInsight> get insights {
    final items = <AnalyticsInsight>[];
    items.add(AnalyticsInsight(
      warning: false,
      text:
          'Attendance was ${attendanceRate.toStringAsFixed(1)}% of expected working days from ${DateFormat('d MMM').format(from.value)} to ${DateFormat('d MMM').format(to.value)}.',
    ));
    if (lateCheckIns > 0) {
      items.add(AnalyticsInsight(
        warning: true,
        text:
            '$lateCheckIns late check-ins were recorded (more than ${settings.settings.value.lateAfterMinutes} min after shift start).',
      ));
    }
    if (leaveDaysTaken > 0) {
      final sick = leaveDaysByType[LeaveType.sick.label] ?? 0;
      items.add(AnalyticsInsight(
        warning: false,
        text:
            '$leaveDaysTaken leave days taken. Sick leave accounted for ${leaveDaysTaken == 0 ? 0 : (sick / leaveDaysTaken * 100).round()}%.',
      ));
    }
    return items;
  }

  void applyRange(DateTime start, DateTime end) {
    from.value = start;
    to.value = end;
  }
}
