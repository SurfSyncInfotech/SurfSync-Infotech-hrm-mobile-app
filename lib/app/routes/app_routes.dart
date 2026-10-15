/// All route names. Routes marked "planned" are registered in [AppPages]
/// only once their screen is built.
abstract class AppRoutes {
  AppRoutes._();

  // Auth
  static const login = '/login';
  static const adminLogin = '/admin-login';

  // Employee portal
  static const employeeDashboard = '/employee/dashboard';
  static const employeeProfile = '/employee/profile';
  static const employeeAttendance = '/employee/attendance';
  static const employeeLeave = '/employee/leave';
  static const employeeAlertSettings = '/employee/alert-settings';
  static const employeeSettings = '/employee/settings';
  static const employeeNotifications = '/employee/notifications';
  static const employeeDailyReport = '/employee/daily-report';
  static const employeeOfferLetter = '/employee/offer-letter';
  static const employeeMailbox = '/employee/mailbox';
  static const employeePayslips = '/employee/payslips';
  static const employeeAssets = '/employee/assets';
  static const employeeAnnouncements = '/employee/announcements';
  static const employeeTargets = '/employee/targets';

  // HR / Admin portal
  static const adminDashboard = '/admin/dashboard';
  static const adminAddEmployee = '/admin/employees/add';
  static const adminAttendance = '/admin/attendance';
  static const adminCompanySettings = '/admin/company-settings';
  static const adminOfferLetters = '/admin/offer-letters';
  static const adminLeaves = '/admin/leaves';
  static const adminAssets = hrAssets;
  static const adminPerformance = hrTargets;
  static const adminDailyReports = hrDailyReports;

  static const hrDashboard = adminDashboard;
  static const hrEmployees = '/hr/employees';
  static const hrAddEmployee = adminAddEmployee;
  static const hrEmployeeDetails = '/hr/employees/details';
  static const hrAttendance = adminAttendance;
  static const hrLeave = employeeLeave;
  static const hrDailyReports = '/hr/daily-reports';
  static const hrPayroll = '/hr/payroll';
  static const hrAnnouncements = '/hr/announcements';
  static const hrAssets = '/hr/assets';
  static const hrTargets = '/hr/targets';
  static const hrReports = '/hr/reports';

  // Super admin portal
  static const superDashboard = '/super/dashboard';
  static const superTalentManagement = '/super/talent';
  static const superSubscriptions = '/super/subscriptions';
  static const superBilling = '/super/billing';

  static const superTenants = superTalentManagement;
  static const superCreateCompany = '/super/tenants/create';
  static const superCompanyDetails = '/super/tenants/details';
  static const superPlans = superSubscriptions;
  static const superPlanDetails = '/super/plans/details';
  static const superTrials = '/super/trials';
  static const superFeatures = '/super/features';

  // Development
  static const designSystem = '/design-system';
}
