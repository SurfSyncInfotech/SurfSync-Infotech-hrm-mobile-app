import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hrms_app/app/bindings/initial_binding.dart';
import 'package:hrms_app/app/routes/app_pages.dart';
import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/app/theme/app_theme.dart';
import 'package:hrms_app/features/employee/presentation/announcements_screen/presentation/views/employee_announcements_view.dart';
import 'package:hrms_app/features/employee/presentation/payslips_screen/presentation/views/employee_payslips_view.dart';
import 'package:hrms_app/features/employee/presentation/settings_screen/presentation/controllers/settings_controller.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    Get.reset();
    InitialBinding().dependencies();
  });

  testWidgets('payslips screen follows theme and shows unpublished state',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const EmployeePayslipsView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Payslips'), findsOneWidget);
    expect(find.text('YTD GROSS'), findsOneWidget);
    expect(find.text('YTD DEDUCTIONS'), findsOneWidget);
    expect(find.text('YTD NET'), findsOneWidget);
    expect(find.text('No published payslips yet'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('announcements screen shows birthday cards and settings link',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const EmployeeAnnouncementsView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Announcements'), findsOneWidget);
    expect(find.text('Upcoming birthdays'), findsOneWidget);
    expect(find.textContaining('Happy Birthday,'), findsWidgets);
    expect(
      SettingsController().sections.expand((section) => section.items).any(
          (item) =>
              item.title == 'Announcements' &&
              item.route == AppRoutes.employeeAnnouncements),
      isTrue,
    );
    expect(
      AppPages.pages.any((page) => page.name == AppRoutes.employeePayslips),
      isTrue,
    );
    expect(
      AppPages.pages
          .any((page) => page.name == AppRoutes.employeeAnnouncements),
      isTrue,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('settings announcements item opens the announcements screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        initialRoute: AppRoutes.employeeSettings,
        getPages: AppPages.pages,
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Announcements'));
    await tester.tap(find.text('Announcements'));
    await tester.pumpAndSettle();

    expect(Get.currentRoute, AppRoutes.employeeAnnouncements);
    expect(find.text('Upcoming birthdays'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
