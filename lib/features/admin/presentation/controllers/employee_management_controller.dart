import 'package:get/get.dart';

import '../../../../data/repositories/employee_directory_repository.dart';
import '../../../employee/data/models/employee_model.dart';

class EmployeeManagementController extends GetxController {
  final query = ''.obs;
  final statusFilter = 'All'.obs;

  EmployeeDirectoryRepository get directory =>
      Get.find<EmployeeDirectoryRepository>();

  List<String> get statuses => const [
        'All',
        'Active',
        'Inactive',
        'On Leave',
        'Probation',
        'Invited',
      ];

  List<Employee> get filtered {
    final q = query.value.trim().toLowerCase();
    return directory.employees.where((employee) {
      final matchesQuery = q.isEmpty ||
          employee.name.toLowerCase().contains(q) ||
          employee.loginEmail.toLowerCase().contains(q) ||
          employee.id.toLowerCase().contains(q);
      final matchesStatus =
          statusFilter.value == 'All' || employee.status == statusFilter.value;
      return matchesQuery && matchesStatus;
    }).toList();
  }

  void addEmployee({
    required String name,
    required String email,
    required String department,
    required String designation,
  }) {
    final id = 'EMP-${1000 + directory.employees.length + 1}';
    directory.upsert(
      Employee(
        id: id,
        name: name,
        loginEmail: email,
        phone: '',
        personalEmail: email,
        dateOfBirth: DateTime(1998, 1, 1),
        gender: 'Not specified',
        bloodGroup: '—',
        designation: designation,
        department: department,
        location: 'Noida',
        status: 'Invited',
        employmentType: 'Full Time',
        joiningDate: DateTime.now(),
        reportingManager: 'Meera Kapoor',
        workShift: '10:00 AM – 7:00 PM',
        emergencyContact: const EmergencyContact(
          name: '—',
          relationship: '—',
          phone: '—',
        ),
        bank: const BankDetails(
          bankName: '—',
          accountHolder: '—',
          accountNumber: '0000',
          ifsc: '—',
          branch: '—',
        ),
        profileComplete: false,
      ),
    );
  }

  void toggleActive(Employee employee) {
    directory.setStatus(
      employee.id,
      employee.status == 'Inactive' ? 'Active' : 'Inactive',
    );
  }

  void deleteEmployee(String id) => directory.remove(id);
}
