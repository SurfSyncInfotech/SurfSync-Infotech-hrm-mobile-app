import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/employee/data/models/employee_model.dart';
import '../models/attendance_record.dart';
import '../models/company_settings_model.dart';
import 'company_settings_repository.dart';
import 'employee_directory_repository.dart';

class AttendanceRepository extends GetxService {
  static const _storageKey = 'attendance_records_v1';

  final records = <AttendanceRecord>[].obs;
  final isBusy = false.obs;

  CompanySettingsModel get _settings =>
      Get.find<CompanySettingsRepository>().settings.value;

  Employee get _me => Get.find<EmployeeDirectoryRepository>().current;

  @override
  void onInit() {
    super.onInit();
    _restore();
  }

  AttendanceRecord? todayFor(String employeeId) {
    final now = DateTime.now();
    for (final record in records) {
      if (record.employeeId == employeeId && _sameDay(record.date, now)) {
        return record;
      }
    }
    return null;
  }

  AttendanceRecord get myToday {
    final existing = todayFor(_me.id);
    return existing ?? _newTodayRecord();
  }

  AttendanceRecord _newTodayRecord() => AttendanceRecord(
        employeeId: _me.id,
        employeeName: _me.name,
        department: _me.department,
        date: DateTime.now(),
      );

  AttendanceRecord _getOrCreateToday() {
    final existing = todayFor(_me.id);
    if (existing != null) return existing;
    final created = _newTodayRecord();
    records.add(created);
    return created;
  }

  List<AttendanceRecord> historyFor(String employeeId) {
    final items = records
        .where((r) => r.employeeId == employeeId && r.checkIn != null)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return items;
  }

  double? currentPeriodPercent() {
    final today = todayFor(_me.id);
    if (today?.checkIn == null) return null;
    final required = Duration(hours: _settings.requiredHours);
    if (required.inMinutes <= 0) return null;
    final worked = today!.workedDuration;
    if (worked == null) return null;
    return min(100, (worked.inMinutes / required.inMinutes) * 100);
  }

  Future<void> punch({
    required bool isCheckIn,
    String? photoPath,
    String? locationLabel,
    double? latitude,
    double? longitude,
  }) async {
    isBusy.value = true;
    try {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      final today = _getOrCreateToday();
      final now = DateTime.now();
      if (isCheckIn) {
        if (today.checkIn != null) return;
        today.checkIn = now;
        today.photoPath = photoPath;
        today.locationLabel = locationLabel;
        today.latitude = latitude;
        today.longitude = longitude;
        final shiftStart = _settings.shiftStartOn(now);
        today.lateMinutes =
            now.isAfter(shiftStart) ? now.difference(shiftStart).inMinutes : 0;
      } else {
        if (today.checkIn == null || today.checkOut != null) return;
        today.checkOut = now;
        today.checkOutPhotoPath = photoPath;
      }
      records.refresh();
      await _persist();
    } finally {
      isBusy.value = false;
    }
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null && raw.isNotEmpty) {
      final decoded = jsonDecode(raw) as List<dynamic>;
      records.assignAll(
        decoded
            .map((item) =>
                AttendanceRecord.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    }
    _seedDirectoryIfNeeded();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _storageKey,
      jsonEncode(records.map((r) => r.toJson()).toList()),
    );
  }

  void _seedDirectoryIfNeeded() {
    final directory = Get.find<EmployeeDirectoryRepository>().employees;
    final now = DateTime.now();
    var seeded = false;
    for (final employee in directory) {
      if (employee.id == _me.id) continue;
      for (var i = 0; i < 10; i++) {
        final day =
            DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
        if (_settings.weekendDays.contains(day.weekday)) continue;
        if (records
            .any((r) => r.employeeId == employee.id && _sameDay(r.date, day))) {
          continue;
        }
        seeded = true;
        final absent = employee.status == 'Inactive' ||
            employee.status == 'On Leave' ||
            (employee.department == 'Digital Marketing' &&
                day.weekday == DateTime.monday);
        if (absent) {
          records.add(AttendanceRecord(
            employeeId: employee.id,
            employeeName: employee.name,
            department: employee.department,
            date: day,
          ));
          continue;
        }
        final late = employee.department == 'Development' &&
            day.weekday == DateTime.tuesday;
        final checkIn = _settings.shiftStartOn(day).add(
              Duration(minutes: late ? 22 : 4),
            );
        records.add(AttendanceRecord(
          employeeId: employee.id,
          employeeName: employee.name,
          department: employee.department,
          date: day,
          checkIn: checkIn,
          checkOut: checkIn.add(const Duration(hours: 8, minutes: 12)),
          locationLabel: employee.location,
          lateMinutes: late ? 22 : 4,
        ));
      }
    }
    if (seeded) {
      _persist();
    }
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
