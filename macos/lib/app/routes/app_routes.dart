/// All route names. Routes marked "planned" are registered in [AppPages]
/// only once their screen is built.
abstract class AppRoutes {
  AppRoutes._();

  // Auth
  static const login = '/login';
  static const adminLogin = '/admin-login';

  // Employee portal
  static const employeeDashboard = '/employee/dashboard'; // planned
  static const employeeProfile = '/employee/profile';
  static const employeeAttendance = '/employee/attendance'; // planned
  static const employeeLeave = '/employee/leave'; // planned
  static const employeeDailyReport = '/employee/daily-report'; // planned
  static const employeeOfferLetter = '/employee/offer-letter'; // planned
  static const employeeMailbox = '/employee/mailbox'; // planned
  static const employeePayslips = '/employee/payslips'; // planned
  static const employeeAssets = '/employee/assets'; // planned
  static const employeeAnnouncements = '/employee/announcements'; // planned
  static const employeeTargets = '/employee/targets'; // planned

  // HR / Admin portal (all planned)
  static const hrDashboard = '/hr/dashboard';
  static const hrEmployees = '/hr/employees';
  static const hrAddEmployee = '/hr/employees/add';
  static const hrEmployeeDetails = '/hr/employees/details';
  static const hrAttendance = '/hr/attendance';
  static const hrLeave = '/hr/leave';
  static const hrDailyReports = '/hr/daily-reports';
  static const hrPayroll = '/hr/payroll';
  static const hrAnnouncements = '/hr/announcements';
  static const hrAssets = '/hr/assets';
  static const hrTargets = '/hr/targets';
  static const hrReports = '/hr/reports';

  // Super admin portal (all planned)
  static const superDashboard = '/super/dashboard';
  static const superTenants = '/super/tenants';
  static const superCreateCompany = '/super/tenants/create';
  static const superCompanyDetails = '/super/tenants/details';
  static const superPlans = '/super/plans';
  static const superPlanDetails = '/super/plans/details';
  static const superTrials = '/super/trials';
  static const superBilling = '/super/billing';
  static const superFeatures = '/super/features';

  // Development
  static const designSystem = '/design-system';
}
