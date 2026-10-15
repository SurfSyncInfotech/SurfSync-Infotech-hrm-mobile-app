import 'package:get/get.dart';

import '../../features/employee/data/models/employee_model.dart';
import '../mock/mock_employee_data.dart';

class EmployeeDirectoryRepository extends GetxService {
  final employees = <Employee>[].obs;

  @override
  void onInit() {
    super.onInit();
    employees.assignAll(List<Employee>.from(MockEmployeeData.employees));
  }

  Employee get current => employees.firstWhere(
        (e) => e.id == MockEmployeeData.currentEmployee.id,
        orElse: () => MockEmployeeData.currentEmployee,
      );

  void upsert(Employee employee) {
    final index = employees.indexWhere((e) => e.id == employee.id);
    if (index >= 0) {
      employees[index] = employee;
    } else {
      employees.add(employee);
    }
    employees.refresh();
  }

  void remove(String id) {
    employees.removeWhere((e) => e.id == id);
  }

  void setStatus(String id, String status) {
    final index = employees.indexWhere((e) => e.id == id);
    if (index < 0) return;
    employees[index] = employees[index].copyWith(status: status);
  }
}
