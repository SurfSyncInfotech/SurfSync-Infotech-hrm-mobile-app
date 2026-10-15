import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:hrms_app/data/models/attendance_record.dart';
import 'package:hrms_app/data/repositories/attendance_repository.dart';
import 'package:hrms_app/data/repositories/company_settings_repository.dart';
import 'package:hrms_app/data/repositories/employee_directory_repository.dart';

class AttendanceController extends GetxController {
  AttendanceController({
    AttendanceRepository? attendance,
    CompanySettingsRepository? settings,
    EmployeeDirectoryRepository? directory,
    ImagePicker? picker,
  })  : _attendance = attendance,
        _settings = settings,
        _directory = directory,
        _picker = picker ?? ImagePicker();

  AttendanceRepository? _attendance;
  CompanySettingsRepository? _settings;
  EmployeeDirectoryRepository? _directory;
  final ImagePicker _picker;

  AttendanceRepository get attendance =>
      _attendance ??= Get.find<AttendanceRepository>();
  CompanySettingsRepository get settingsRepo =>
      _settings ??= Get.find<CompanySettingsRepository>();
  EmployeeDirectoryRepository get directory =>
      _directory ??= Get.find<EmployeeDirectoryRepository>();

  final errorMessage = RxnString();
  final capturing = false.obs;

  AttendanceRecord get today => attendance.myToday;
  AttendancePunchState get punchState => today.punchState;

  String get todayLabel => DateFormat('EEE, d MMM').format(DateTime.now());

  String formatTime(DateTime? value) =>
      value == null ? '—' : DateFormat('hh:mm a').format(value);

  String? get periodLabel {
    final percent = attendance.currentPeriodPercent();
    if (percent == null) return null;
    return '${percent.round()}%';
  }

  Future<void> punch() async {
    if (attendance.isBusy.value || capturing.value) return;
    if (punchState == AttendancePunchState.checkedOut) return;

    errorMessage.value = null;
    capturing.value = true;
    try {
      String? photoPath;
      if (!kIsWeb) {
        final image = await _picker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.front,
          imageQuality: 70,
        );
        if (image == null) {
          errorMessage.value = 'Photo capture was cancelled.';
          return;
        }
        photoPath = image.path;
        if (!File(photoPath).existsSync()) {
          errorMessage.value = 'The captured photo could not be saved.';
          return;
        }
      }

      final location = await _captureLocation();
      await attendance.punch(
        isCheckIn: punchState == AttendancePunchState.notCheckedIn,
        photoPath: photoPath,
        locationLabel: location.$1,
        latitude: location.$2,
        longitude: location.$3,
      );
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      capturing.value = false;
    }
  }

  Future<(String, double?, double?)> _captureLocation() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        return ('Location services are turned off', null, null);
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return ('Location permission not granted', null, null);
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );
      return (
        '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}',
        position.latitude,
        position.longitude,
      );
    } catch (_) {
      return ('Location unavailable on this device', null, null);
    }
  }
}
