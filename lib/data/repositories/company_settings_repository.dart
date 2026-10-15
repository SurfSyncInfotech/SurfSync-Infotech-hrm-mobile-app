import 'package:get/get.dart';

import '../models/company_settings_model.dart';

class CompanySettingsRepository extends GetxService {
  final settings = CompanySettingsModel().obs;
}
