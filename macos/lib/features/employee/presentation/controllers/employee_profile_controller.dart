import 'package:get/get.dart';

import '../../../../data/mock/mock_employee_data.dart';
import '../../data/models/employee_model.dart';

class EmployeeProfileController extends GetxController {
  final Employee employee = MockEmployeeData.currentEmployee;

  /// Bank account number is masked until the user chooses to reveal it.
  final showAccountNumber = false.obs;

  void toggleAccountNumber() => showAccountNumber.toggle();
}
