import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hrms_app/core/extensions/date_extensions.dart';
import 'package:hrms_app/core/widgets/app_section_card.dart';
import 'package:hrms_app/features/employee/data/models/employee_model.dart';
import 'package:hrms_app/features/employee/presentation/profile_screen/presentation/controllers/employee_profile_controller.dart';

class PersonalInfoCard extends StatelessWidget {
  const PersonalInfoCard({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      title: 'Personal Information',
      child: Column(
        children: [
          AppKeyValueRow(label: 'Login Email', value: employee.loginEmail),
          AppKeyValueRow(label: 'Phone', value: employee.phone),
          AppKeyValueRow(
              label: 'Personal Email', value: employee.personalEmail),
          AppKeyValueRow(
              label: 'Date of Birth', value: employee.dateOfBirth.dMMMy),
          AppKeyValueRow(label: 'Gender', value: employee.gender),
          AppKeyValueRow(
              label: 'Blood Group',
              value: employee.bloodGroup,
              showDivider: false),
        ],
      ),
    );
  }
}

class EmergencyContactCard extends StatelessWidget {
  const EmergencyContactCard({super.key, required this.contact});

  final EmergencyContact contact;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      title: 'Emergency Contact',
      child: Column(
        children: [
          AppKeyValueRow(label: 'Name', value: contact.name),
          AppKeyValueRow(label: 'Relationship', value: contact.relationship),
          AppKeyValueRow(
              label: 'Phone', value: contact.phone, showDivider: false),
        ],
      ),
    );
  }
}

class BankDetailsCard extends GetView<EmployeeProfileController> {
  const BankDetailsCard({super.key, required this.bank});

  final BankDetails bank;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AppSectionCard(
      title: 'Bank Details',
      child: Column(
        children: [
          AppKeyValueRow(label: 'Bank Name', value: bank.bankName),
          AppKeyValueRow(label: 'Account Holder', value: bank.accountHolder),
          Obx(
            () => AppKeyValueRow(
              label: 'Account Number',
              value: controller.showAccountNumber.value
                  ? bank.accountNumber
                  : bank.maskedAccountNumber,
              trailing: IconButton(
                tooltip: controller.showAccountNumber.value ? 'Hide' : 'Show',
                visualDensity: VisualDensity.compact,
                onPressed: controller.toggleAccountNumber,
                icon: Icon(
                  controller.showAccountNumber.value
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
          AppKeyValueRow(label: 'IFSC', value: bank.ifsc),
          AppKeyValueRow(
              label: 'Branch', value: bank.branch, showDivider: false),
        ],
      ),
    );
  }
}

class EmploymentInfoCard extends StatelessWidget {
  const EmploymentInfoCard({super.key, required this.employee});

  final Employee employee;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      title: 'Employment Information',
      child: Column(
        children: [
          AppKeyValueRow(label: 'Employee ID', value: employee.id),
          AppKeyValueRow(label: 'Designation', value: employee.designation),
          AppKeyValueRow(label: 'Department', value: employee.department),
          AppKeyValueRow(
              label: 'Reporting Manager', value: employee.reportingManager),
          AppKeyValueRow(label: 'Work Shift', value: employee.workShift),
          AppKeyValueRow(
              label: 'Date of Joining',
              value: employee.joiningDate.dMMMy,
              showDivider: false),
        ],
      ),
    );
  }
}
