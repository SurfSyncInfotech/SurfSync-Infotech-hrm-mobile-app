enum LeaveStatus { pending, approved, rejected }

enum LeaveType { casual, sick }

class LeaveBalance {
  LeaveBalance({
    required this.type,
    required this.allocated,
    required this.used,
    required this.pending,
  });

  final LeaveType type;
  int allocated;
  int used;
  int pending;

  int get remaining => allocated - used - pending;
}

class LeaveRequest {
  LeaveRequest({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.type,
    required this.start,
    required this.end,
    required this.days,
    required this.appliedOn,
    required this.status,
    this.reason = '',
    this.rejectionReason,
  });

  final String id;
  final String employeeId;
  final String employeeName;
  final LeaveType type;
  final DateTime start;
  final DateTime end;
  final int days;
  final DateTime appliedOn;
  LeaveStatus status;
  final String reason;
  String? rejectionReason;
}

extension LeaveTypeLabel on LeaveType {
  String get label => switch (this) {
        LeaveType.casual => 'Casual Leaves',
        LeaveType.sick => 'Sick Leaves',
      };
}

extension LeaveStatusLabel on LeaveStatus {
  String get label => switch (this) {
        LeaveStatus.pending => 'Pending',
        LeaveStatus.approved => 'Approved',
        LeaveStatus.rejected => 'Rejected',
      };
}
