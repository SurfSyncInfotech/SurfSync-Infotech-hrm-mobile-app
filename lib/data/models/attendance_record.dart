enum AttendancePunchState { notCheckedIn, checkedIn, checkedOut }

class AttendanceRecord {
  AttendanceRecord({
    required this.employeeId,
    required this.employeeName,
    required this.department,
    required this.date,
    this.checkIn,
    this.checkOut,
    this.photoPath,
    this.checkOutPhotoPath,
    this.locationLabel,
    this.latitude,
    this.longitude,
    this.lateMinutes = 0,
  });

  final String employeeId;
  final String employeeName;
  final String department;
  final DateTime date;
  DateTime? checkIn;
  DateTime? checkOut;
  String? photoPath;
  String? checkOutPhotoPath;
  String? locationLabel;
  double? latitude;
  double? longitude;
  int lateMinutes;

  bool get isPresent => checkIn != null;
  bool get isComplete => checkIn != null && checkOut != null;
  bool get isLate => lateMinutes > 15;

  Duration? get workedDuration {
    if (checkIn == null) return null;
    final end = checkOut ?? DateTime.now();
    return end.difference(checkIn!);
  }

  AttendancePunchState get punchState {
    if (checkIn == null) return AttendancePunchState.notCheckedIn;
    if (checkOut == null) return AttendancePunchState.checkedIn;
    return AttendancePunchState.checkedOut;
  }

  Map<String, dynamic> toJson() => {
        'employeeId': employeeId,
        'employeeName': employeeName,
        'department': department,
        'date': date.toIso8601String(),
        'checkIn': checkIn?.toIso8601String(),
        'checkOut': checkOut?.toIso8601String(),
        'photoPath': photoPath,
        'checkOutPhotoPath': checkOutPhotoPath,
        'locationLabel': locationLabel,
        'latitude': latitude,
        'longitude': longitude,
        'lateMinutes': lateMinutes,
      };

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    return AttendanceRecord(
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      department: json['department'] as String,
      date: DateTime.parse(json['date'] as String),
      checkIn: json['checkIn'] == null
          ? null
          : DateTime.parse(json['checkIn'] as String),
      checkOut: json['checkOut'] == null
          ? null
          : DateTime.parse(json['checkOut'] as String),
      photoPath: json['photoPath'] as String?,
      checkOutPhotoPath: json['checkOutPhotoPath'] as String?,
      locationLabel: json['locationLabel'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      lateMinutes: json['lateMinutes'] as int? ?? 0,
    );
  }
}
