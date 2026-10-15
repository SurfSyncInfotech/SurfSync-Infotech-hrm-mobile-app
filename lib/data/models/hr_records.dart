class OfferLetterRecord {
  const OfferLetterRecord({
    required this.id,
    required this.employeeName,
    required this.role,
    required this.issuedOn,
    required this.status,
  });

  final String id;
  final String employeeName;
  final String role;
  final DateTime issuedOn;
  final String status;
}

class AssetRecord {
  const AssetRecord({
    required this.id,
    required this.employeeName,
    required this.item,
    required this.serial,
    required this.status,
  });

  final String id;
  final String employeeName;
  final String item;
  final String serial;
  final String status;
}

class PerformanceRecord {
  const PerformanceRecord({
    required this.employeeName,
    required this.department,
    required this.score,
    required this.period,
  });

  final String employeeName;
  final String department;
  final double score;
  final String period;
}

class DailyWorkReportRecord {
  const DailyWorkReportRecord({
    required this.employeeName,
    required this.date,
    required this.summary,
    required this.status,
  });

  final String employeeName;
  final DateTime date;
  final String summary;
  final String status;
}
