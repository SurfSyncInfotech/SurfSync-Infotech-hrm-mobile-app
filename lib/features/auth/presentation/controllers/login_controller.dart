import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  Future<void> submit({required bool isAdmin}) async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final email = emailController.text.trim().toLowerCase();
    final local = email.split('@').first;
    final name = local
        .split(RegExp(r'[._-]'))
        .where((part) => part.isNotEmpty)
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .join(' ');

    final UserRole role;
    if (!isAdmin) {
      role = UserRole.employee;
    } else if (email.startsWith('superadmin')) {
      role = UserRole.superAdmin;
    } else {
      role = UserRole.hrAdmin;
    }

    final session = Get.find<SessionController>();
    await session.signIn(
      value: role,
      userEmail: email,
      name: name.isEmpty ? 'Team member' : name,
    );

    isLoading.value = false;
    passwordController.clear();
    obscurePassword.value = true;
    AppNav.goAll(session.homeRoute);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
