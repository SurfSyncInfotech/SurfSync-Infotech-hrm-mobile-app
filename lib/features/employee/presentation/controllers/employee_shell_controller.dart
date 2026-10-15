import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class EmployeeShellController extends GetxController {
  static const tabRoutes = [
    AppRoutes.employeeDashboard,
    AppRoutes.employeeProfile,
    AppRoutes.employeeDailyReport,
    AppRoutes.employeeLeave,
    AppRoutes.employeeSettings,
  ];

  int tabIndex = 0;

  String get currentRoute => tabRoutes[tabIndex];

  void selectTab(int index) {
    if (index < 0 || index >= tabRoutes.length) return;
    if (tabIndex == index) return;
    tabIndex = index;
    update();
  }

  void selectRoute(String route) {
    final index = tabRoutes.indexOf(route);
    if (index >= 0) selectTab(index);
  }
}
