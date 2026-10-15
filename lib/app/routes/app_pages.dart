import 'package:get/get.dart';

import '../../features/admin/presentation/views/admin_add_employee_view.dart';
import '../../features/admin/presentation/views/admin_attendance_view.dart';
import '../../features/admin/presentation/views/admin_company_settings_view.dart';
import '../../features/admin/presentation/views/admin_home_view.dart';
import '../../features/auth/presentation/bindings/login_binding.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/design_system/presentation/bindings/design_system_binding.dart';
import '../../features/design_system/presentation/views/design_system_view.dart';
import '../../features/employee/presentation/attendance_screen/presentation/bindings/attendance_binding.dart';
import '../../features/employee/presentation/bindings/employee_shell_binding.dart';
import '../../features/employee/presentation/daily_report_screen/presentation/bindings/daily_report_binding.dart';
import '../../features/employee/presentation/daily_report_screen/presentation/views/employee_daily_report_view.dart';
import '../../features/employee/presentation/leave_screen/presentation/bindings/leave_binding.dart';
import '../../features/employee/presentation/notifications_screen/presentation/bindings/notifications_binding.dart';
import '../../features/employee/presentation/profile_screen/presentation/bindings/employee_profile_binding.dart';
import '../../features/employee/presentation/settings_screen/presentation/bindings/settings_binding.dart';
import '../../features/employee/presentation/settings_screen/presentation/views/employee_theme_settings_view.dart';
import '../../features/employee/presentation/settings_screen/presentation/views/employee_alert_settings_view.dart';
import '../../features/employee/presentation/settings_screen/presentation/views/settings_view.dart';
import '../../features/employee/presentation/attendance_screen/presentation/views/employee_attendance_view.dart';
import '../../features/employee/presentation/announcements_screen/presentation/views/employee_announcements_view.dart';
import '../../features/employee/presentation/notifications_screen/presentation/views/employee_notifications_view.dart';
import '../../features/employee/presentation/offer_letter_screen/presentation/views/employee_offer_letter_view.dart';
import '../../features/employee/presentation/payslips_screen/presentation/views/employee_payslips_view.dart';
import '../../features/employee/presentation/views/employee_shell_view.dart';
import '../../features/employee/presentation/leave_screen/presentation/views/employee_leave_view.dart';
import '../../features/employee/presentation/profile_screen/presentation/views/employee_profile_view.dart';
import '../../features/super_admin/presentation/views/super_admin_billing_view.dart';
import '../../features/super_admin/presentation/views/super_admin_dashboard_view.dart';
import '../../features/super_admin/presentation/views/super_admin_subscriptions_view.dart';
import '../../features/super_admin/presentation/views/super_admin_talent_management_view.dart';
import 'app_routes.dart';

abstract class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.adminLogin,
      page: () => const LoginView(isAdmin: true),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.employeeDashboard,
      page: () => const EmployeeShellView(),
      binding: EmployeeShellBinding(),
    ),
    GetPage(
      name: AppRoutes.employeeProfile,
      page: () => const EmployeeProfileView(),
      binding: EmployeeProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.employeeAttendance,
      page: () => const EmployeeAttendanceView(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: AppRoutes.employeeDailyReport,
      page: () => const EmployeeDailyReportView(),
      binding: DailyReportBinding(),
    ),
    GetPage(
      name: AppRoutes.employeeLeave,
      page: () => const EmployeeLeaveView(),
      binding: LeaveBinding(),
    ),
    GetPage(
      name: AppRoutes.employeeAlertSettings,
      page: () => const EmployeeAlertSettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.employeeSettings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.employeeThemeSettings,
      page: () => const EmployeeThemeSettingsView(),
    ),
    GetPage(
      name: AppRoutes.employeeNotifications,
      page: () => const EmployeeNotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: AppRoutes.employeePayslips,
      page: () => const EmployeePayslipsView(),
    ),
    GetPage(
      name: AppRoutes.employeeOfferLetter,
      page: () => const EmployeeOfferLetterView(),
    ),
    GetPage(
      name: AppRoutes.employeeAnnouncements,
      page: () => const EmployeeAnnouncementsView(),
    ),
    GetPage(
      name: AppRoutes.adminDashboard,
      page: () => const AdminHomeView(),
    ),
    GetPage(
      name: AppRoutes.adminAddEmployee,
      page: () => const AdminAddEmployeeView(),
    ),
    GetPage(
      name: AppRoutes.adminAttendance,
      page: () => const AdminAttendanceView(),
    ),
    GetPage(
      name: AppRoutes.adminCompanySettings,
      page: () => const AdminCompanySettingsView(),
    ),
    GetPage(
      name: AppRoutes.superDashboard,
      page: () => const SuperAdminDashboardView(),
    ),
    GetPage(
      name: AppRoutes.superTalentManagement,
      page: () => const SuperAdminTalentManagementView(),
    ),
    GetPage(
      name: AppRoutes.superSubscriptions,
      page: () => const SuperAdminSubscriptionsView(),
    ),
    GetPage(
      name: AppRoutes.superBilling,
      page: () => const SuperAdminBillingView(),
    ),
    GetPage(
      name: AppRoutes.designSystem,
      page: () => const DesignSystemView(),
      binding: DesignSystemBinding(),
    ),
  ];
}
