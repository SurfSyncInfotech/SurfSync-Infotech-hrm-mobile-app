import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hrms_app/app/bindings/initial_binding.dart';
import 'package:hrms_app/app/routes/app_pages.dart';
import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/app/theme/app_theme.dart';
import 'package:hrms_app/data/repositories/hr_records_repository.dart';
import 'package:hrms_app/features/employee/presentation/offer_letter_screen/presentation/views/employee_offer_letter_view.dart';
import 'package:hrms_app/features/employee/presentation/settings_screen/presentation/controllers/settings_controller.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    Get.reset();
    InitialBinding().dependencies();
  });

  testWidgets('offer letter screen shows employee offer details on mobile',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const EmployeeOfferLetterView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Offer Letter'), findsOneWidget);
    expect(find.text('Android Developer'), findsWidgets);
    expect(find.text('Offer details'), findsOneWidget);
    expect(find.text('Reporting manager'), findsOneWidget);
    expect(find.text('Your response'), findsOneWidget);
    expect(tester.takeException(), isNull);

    tester.view.physicalSize = const Size(1440, 900);
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const EmployeeOfferLetterView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Offer Letter'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('offer letter screen shows an empty state without an offer',
      (WidgetTester tester) async {
    Get.find<HrRecordsRepository>().offerLetters.clear();

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const EmployeeOfferLetterView(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No offer letter available'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('offer letter route is registered and reachable from settings', () {
    expect(
      AppPages.pages.any((page) => page.name == AppRoutes.employeeOfferLetter),
      isTrue,
    );
    expect(
      SettingsController().sections.expand((section) => section.items).any(
          (item) =>
              item.title == 'Offer Letter' &&
              item.route == AppRoutes.employeeOfferLetter),
      isTrue,
    );
  });
}
