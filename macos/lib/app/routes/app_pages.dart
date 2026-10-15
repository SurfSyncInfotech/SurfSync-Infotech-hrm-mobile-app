import 'package:get/get.dart';

import '../../features/auth/presentation/bindings/login_binding.dart';
import '../../features/auth/presentation/views/login_view.dart';
import '../../features/design_system/presentation/bindings/design_system_binding.dart';
import '../../features/design_system/presentation/views/design_system_view.dart';
import '../../features/employee/presentation/bindings/employee_profile_binding.dart';
import '../../features/employee/presentation/views/employee_profile_view.dart';
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
      name: AppRoutes.employeeProfile,
      page: () => const EmployeeProfileView(),
      binding: EmployeeProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.designSystem,
      page: () => const DesignSystemView(),
      binding: DesignSystemBinding(),
    ),
  ];
}
