import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/routes/app_routes.dart';

enum UserRole { employee, hrAdmin, superAdmin }

class SessionController extends GetxController {
  static const _roleKey = 'session_role';
  static const _emailKey = 'session_email';
  static const _nameKey = 'session_name';

  final Rxn<UserRole> role = Rxn<UserRole>();
  final email = ''.obs;
  final displayName = ''.obs;

  bool get isSignedIn => role.value != null;

  String get homeRoute => switch (role.value) {
        UserRole.employee => AppRoutes.employeeDashboard,
        UserRole.hrAdmin => AppRoutes.adminDashboard,
        UserRole.superAdmin => AppRoutes.superDashboard,
        null => AppRoutes.login,
      };

  @override
  void onInit() {
    super.onInit();
    _restore();
  }

  Future<void> signIn({
    required UserRole value,
    required String userEmail,
    required String name,
  }) async {
    role.value = value;
    email.value = userEmail;
    displayName.value = name;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_roleKey, value.name);
    await prefs.setString(_emailKey, userEmail);
    await prefs.setString(_nameKey, name);
  }

  Future<void> signOut() async {
    role.value = null;
    email.value = '';
    displayName.value = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_roleKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_nameKey);
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_roleKey);
    role.value = switch (saved) {
      'employee' => UserRole.employee,
      'hrAdmin' => UserRole.hrAdmin,
      'superAdmin' => UserRole.superAdmin,
      _ => null,
    };
    email.value = prefs.getString(_emailKey) ?? '';
    displayName.value = prefs.getString(_nameKey) ?? '';
  }
}
