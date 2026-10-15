import 'package:get/get.dart';

import 'package:hrms_app/data/repositories/employee_directory_repository.dart';

class HomeController extends GetxController {
  HomeController({EmployeeDirectoryRepository? directory})
      : _directory = directory;

  final EmployeeDirectoryRepository? _directory;

  EmployeeDirectoryRepository get directory =>
      _directory ?? Get.find<EmployeeDirectoryRepository>();

  String get firstName => directory.current.name.trim().split(' ').first;

  DateTime get today => DateTime.now();

  String get greeting {
    final hour = today.hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }
}
