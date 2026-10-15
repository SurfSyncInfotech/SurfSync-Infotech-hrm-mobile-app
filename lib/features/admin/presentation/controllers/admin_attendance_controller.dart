import 'package:get/get.dart';

import '../../../../data/models/attendance_record.dart';
import '../../../../data/repositories/attendance_repository.dart';

class AdminAttendanceController extends GetxController {
  final query = ''.obs;
  final department = 'All'.obs;
  final status = 'All'.obs;
  final day = DateTime.now().obs;

  AttendanceRepository get attendance => Get.find<AttendanceRepository>();

  List<String> get departments {
    final values = attendance.records.map((r) => r.department).toSet().toList()
      ..sort();
    return ['All', ...values];
  }

  List<AttendanceRecord> get filtered {
    final q = query.value.trim().toLowerCase();
    return attendance.records.where((record) {
      final sameDay = record.date.year == day.value.year &&
          record.date.month == day.value.month &&
          record.date.day == day.value.day;
      if (!sameDay) return false;
      final matchesQuery = q.isEmpty ||
          record.employeeName.toLowerCase().contains(q) ||
          record.employeeId.toLowerCase().contains(q);
      final matchesDept =
          department.value == 'All' || record.department == department.value;
      final recordStatus = record.checkIn == null
          ? 'Absent'
          : record.isLate
              ? 'Late'
              : 'Present';
      final matchesStatus =
          status.value == 'All' || recordStatus == status.value;
      return matchesQuery && matchesDept && matchesStatus;
    }).toList()
      ..sort((a, b) => a.employeeName.compareTo(b.employeeName));
  }
}
