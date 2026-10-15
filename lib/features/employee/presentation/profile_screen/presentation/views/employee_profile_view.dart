import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';

import '../controllers/employee_profile_controller.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_cards.dart';

class EmployeeProfileView extends GetView<EmployeeProfileController> {
  const EmployeeProfileView({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final e = controller.employee;
    const gap = SizedBox(height: 20);

    final personal = PersonalInfoCard(employee: e);
    final emergency = EmergencyContactCard(contact: e.emergencyContact);
    final bank = BankDetailsCard(bank: e.bank);
    final employment = EmploymentInfoCard(employee: e);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProfileHeader(employee: e),
        gap,
        LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth >= 820) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(children: [personal, gap, employment]),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(children: [emergency, gap, bank]),
                ),
              ],
            );
          }
          return Column(children: [
            personal,
            gap,
            emergency,
            gap,
            bank,
            gap,
            employment,
          ]);
        }),
      ],
    );

    if (embedded) return SingleChildScrollView(child: content);
    return EmployeeLayout(
      currentRoute: AppRoutes.employeeProfile,
      child: content,
    );
  }
}
