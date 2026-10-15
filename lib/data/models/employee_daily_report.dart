class EmployeeDailyReport {
  const EmployeeDailyReport({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.date,
    required this.hoursWorked,
    required this.workDone,
    required this.blockers,
    required this.plansForTomorrow,
    required this.status,
    this.note,
  });

  final String id;
  final String employeeId;
  final String employeeName;
  final DateTime date;
  final double hoursWorked;
  final String workDone;
  final String blockers;
  final String plansForTomorrow;
  final String status;
  final String? note;

  Map<String, dynamic> toJson() => {
        'id': id,
        'employeeId': employeeId,
        'employeeName': employeeName,
        'date': date.toIso8601String(),
        'hoursWorked': hoursWorked,
        'workDone': workDone,
        'blockers': blockers,
        'plansForTomorrow': plansForTomorrow,
        'status': status,
        'note': note,
      };

  factory EmployeeDailyReport.fromJson(Map<String, dynamic> json) {
    return EmployeeDailyReport(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      date: DateTime.parse(json['date'] as String),
      hoursWorked: (json['hoursWorked'] as num).toDouble(),
      workDone: json['workDone'] as String,
      blockers: json['blockers'] as String? ?? '',
      plansForTomorrow: json['plansForTomorrow'] as String? ?? '',
      status: json['status'] as String,
      note: json['note'] as String?,
    );
  }
}
