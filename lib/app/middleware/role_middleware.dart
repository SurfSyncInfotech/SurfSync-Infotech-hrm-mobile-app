import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/controllers/session_controller.dart';
import '../routes/app_routes.dart';

class RoleMiddleware extends GetMiddleware {
  RoleMiddleware({required this.allowed});

  final List<UserRole> allowed;

  @override
  RouteSettings? redirect(String? route) {
    if (!Get.isRegistered<SessionController>()) {
      return const RouteSettings(name: AppRoutes.login);
    }
    final session = Get.find<SessionController>();
    final role = session.role.value;
    if (role == null) {
      return const RouteSettings(name: AppRoutes.login);
    }
    if (!allowed.contains(role)) {
      return RouteSettings(name: session.homeRoute);
    }
    return null;
  }
}
