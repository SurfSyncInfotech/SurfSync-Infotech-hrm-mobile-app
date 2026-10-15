import 'package:flutter_test/flutter_test.dart';
import 'package:hrms_app/app/routes/app_pages.dart';
import 'package:hrms_app/app/routes/app_routes.dart';

void main() {
  test('role-based routes are registered for employee, admin and super admin', () {
    expect(AppRoutes.employeeProfile, isNotEmpty);
    expect(AppRoutes.employeeAttendance, isNotEmpty);
    expect(AppRoutes.employeeLeave, isNotEmpty);
    expect(AppRoutes.employeeAlertSettings, isNotEmpty);

    expect(AppRoutes.adminDashboard, isNotEmpty);
    expect(AppRoutes.adminAddEmployee, isNotEmpty);
    expect(AppRoutes.adminAttendance, isNotEmpty);
    expect(AppRoutes.adminCompanySettings, isNotEmpty);

    expect(AppRoutes.superDashboard, isNotEmpty);
    expect(AppRoutes.superTalentManagement, isNotEmpty);
    expect(AppRoutes.superSubscriptions, isNotEmpty);
    expect(AppRoutes.superBilling, isNotEmpty);

    final registered = AppPages.pages.map((page) => page.name).toSet();
    expect(registered, containsAll({
      AppRoutes.employeeProfile,
      AppRoutes.employeeAttendance,
      AppRoutes.employeeLeave,
      AppRoutes.employeeAlertSettings,
      AppRoutes.adminDashboard,
      AppRoutes.adminAddEmployee,
      AppRoutes.adminAttendance,
      AppRoutes.adminCompanySettings,
      AppRoutes.superDashboard,
      AppRoutes.superTalentManagement,
      AppRoutes.superSubscriptions,
      AppRoutes.superBilling,
    }));
  });
}
