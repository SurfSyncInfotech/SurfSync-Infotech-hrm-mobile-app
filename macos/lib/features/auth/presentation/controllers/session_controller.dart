import 'package:get/get.dart';

enum UserRole { employee, hrAdmin, superAdmin }

/// Holds the "signed in" role for this UI-only phase. No real authentication.
class SessionController extends GetxController {
  final Rxn<UserRole> role = Rxn<UserRole>();

  void signIn(UserRole value) => role.value = value;

  void signOut() => role.value = null;
}
