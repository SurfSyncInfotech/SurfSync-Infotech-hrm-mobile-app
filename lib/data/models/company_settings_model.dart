class CompanySettingsModel {
  CompanySettingsModel({
    this.companyName = 'SurfSync Infotech',
    this.workStart = const Duration(hours: 10),
    this.workEnd = const Duration(hours: 19),
    this.requiredHours = 8,
    this.lateAfterMinutes = 15,
    this.requireLocation = true,
    this.weekendDays = const [DateTime.saturday, DateTime.sunday],
    this.casualLeaveDays = 12,
    this.sickLeaveDays = 12,
  });

  String companyName;
  Duration workStart;
  Duration workEnd;
  int requiredHours;
  int lateAfterMinutes;
  bool requireLocation;
  List<int> weekendDays;
  int casualLeaveDays;
  int sickLeaveDays;

  DateTime shiftStartOn(DateTime day) => DateTime(
        day.year,
        day.month,
        day.day,
        workStart.inHours,
        workStart.inMinutes.remainder(60),
      );
}
