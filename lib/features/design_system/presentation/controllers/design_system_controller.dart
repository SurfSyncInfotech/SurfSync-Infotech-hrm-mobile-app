import 'dart:math' as math;

import 'package:get/get.dart';

import '../../../../core/widgets/app_confirm_dialog.dart';
import '../../../../data/mock/mock_employee_data.dart';
import '../../../employee/data/models/employee_model.dart';

class DesignSystemController extends GetxController {
  static const pageSize = 4;

  final query = ''.obs;
  final page = 1.obs;

  List<Employee> get filtered {
    final q = query.value.trim().toLowerCase();
    return MockEmployeeData.employees
        .where((e) =>
            q.isEmpty ||
            e.name.toLowerCase().contains(q) ||
            e.department.toLowerCase().contains(q))
        .toList();
  }

  List<Employee> get pagedRows {
    final all = filtered;
    final start = (page.value - 1) * pageSize;
    if (start >= all.length) return [];
    return all.sublist(start, math.min(start + pageSize, all.length));
  }

  void setQuery(String value) {
    query.value = value;
    page.value = 1;
  }

  void setPage(int value) => page.value = value;

  Future<bool> confirmRemove(Employee employee) {
    return AppConfirmDialog.show(
      title: 'Remove employee?',
      message:
          '${employee.name} would be removed. This is a UI demo, so nothing is actually deleted.',
      confirmLabel: 'Remove',
      destructive: true,
    );
  }
}
