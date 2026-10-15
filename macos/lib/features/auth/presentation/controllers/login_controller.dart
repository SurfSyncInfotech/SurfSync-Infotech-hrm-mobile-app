import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/app_nav.dart';
import 'session_controller.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final obscurePassword = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() => obscurePassword.toggle();

  String? validateEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Email is required';
    if (!GetUtils.isEmail(v)) return 'Enter a valid email address';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  /// UI-only sign in: simulates a short delay, then routes by portal.
  /// Admin sign-in with an email starting "superadmin" opens the Super Admin portal.
  Future<void> submit({required bool isAdmin}) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 700));
    isLoading.value = false;
    final email = emailController.text.trim().toLowerCase();
    passwordController.clear();
    obscurePassword.value = true;

    final session = Get.find<SessionController>();
    if (!isAdmin) {
      session.signIn(UserRole.employee);
      AppNav.goAll(AppRoutes.employeeProfile);
      return;
    }

    final isSuper = email.startsWith('superadmin');
    session.signIn(isSuper ? UserRole.superAdmin : UserRole.hrAdmin);
    AppNav.goAll(isSuper ? AppRoutes.superDashboard : AppRoutes.hrDashboard);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
