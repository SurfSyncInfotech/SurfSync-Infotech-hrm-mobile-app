import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_constants.dart';
import 'bindings/initial_binding.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'theme/theme_controller.dart';

class HrmsApp extends StatelessWidget {
  const HrmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: Get.isRegistered<ThemeController>()
          ? Get.find<ThemeController>()
          : ThemeController(),
      builder: (themeController) => GetMaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeController.themeMode,
        initialBinding: InitialBinding(),
        initialRoute: AppRoutes.login,
        getPages: AppPages.pages,
        defaultTransition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 180),
      ),
    );
  }
}
