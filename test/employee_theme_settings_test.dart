import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hrms_app/app/bindings/initial_binding.dart';
import 'package:hrms_app/app/routes/app_pages.dart';
import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/app/theme/theme_controller.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    Get.reset();
  });

  testWidgets('Dark Mode setting opens explicit theme choices',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        initialRoute: AppRoutes.employeeSettings,
        getPages: AppPages.pages,
        initialBinding: InitialBinding(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Dark Mode').last);
    await tester.tap(find.text('Dark Mode').last);
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.employeeThemeSettings);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('System default'), findsOneWidget);
    expect(find.text('Light'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    expect(Get.find<ThemeController>().themeMode, ThemeMode.dark);
    expect(
      Theme.of(tester.element(find.text('Appearance'))).brightness,
      Brightness.dark,
    );

    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();
    expect(Get.find<ThemeController>().themeMode, ThemeMode.light);
    expect(
      Theme.of(tester.element(find.text('Appearance'))).brightness,
      Brightness.light,
    );

    await tester.tap(find.text('System default'));
    await tester.pumpAndSettle();
    expect(Get.find<ThemeController>().themeMode, ThemeMode.system);
    expect(tester.takeException(), isNull);
  });
}
