// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hrms_app/app/app.dart';
import 'package:hrms_app/app/bindings/initial_binding.dart';
import 'package:hrms_app/app/routes/app_pages.dart';
import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/app/theme/app_theme.dart';
import 'package:hrms_app/app/theme/theme_controller.dart';
import 'package:hrms_app/data/models/attendance_record.dart';
import 'package:hrms_app/features/employee/presentation/attendance_screen/presentation/controllers/attendance_controller.dart';
import 'package:hrms_app/features/employee/presentation/attendance_screen/presentation/views/employee_attendance_view.dart';
import 'package:hrms_app/features/employee/presentation/bindings/employee_shell_binding.dart';
import 'package:hrms_app/features/employee/presentation/home_screen/presentation/views/employee_home_view.dart';
import 'package:hrms_app/features/employee/presentation/leave_screen/presentation/controllers/leave_controller.dart';
import 'package:hrms_app/features/employee/presentation/leave_screen/presentation/views/employee_leave_view.dart';
import 'package:hrms_app/features/employee/presentation/notifications_screen/presentation/controllers/employee_notifications_controller.dart';
import 'package:hrms_app/features/employee/presentation/profile_screen/presentation/controllers/employee_profile_controller.dart';
import 'package:hrms_app/features/employee/presentation/profile_screen/presentation/views/employee_profile_view.dart';
import 'package:hrms_app/features/employee/presentation/settings_screen/presentation/controllers/settings_controller.dart';
import 'package:hrms_app/features/employee/presentation/settings_screen/presentation/views/settings_view.dart';
import 'package:hrms_app/shared/layouts/app_top_bar.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    Get.reset();
  });

  testWidgets('app boots to the login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const HrmsApp());
    await tester.pumpAndSettle();

    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Sign in to your employee portal'), findsOneWidget);
  });

  testWidgets('app switches to dark mode', (WidgetTester tester) async {
    await tester.pumpWidget(const HrmsApp());
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.text('Sign In'))).brightness,
      Brightness.light,
    );

    Get.find<ThemeController>().toggleTheme();
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.text('Sign In'))).brightness,
      Brightness.dark,
    );
  });

  testWidgets('top bar omits the logo and floating action button',
      (WidgetTester tester) async {
    Get.put(ThemeController());
    Get.put(EmployeeNotificationsController());
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const Scaffold(
          body: AppTopBar(
            title: 'SurfSync Infotech',
            subtitle: 'Employee Portal',
            userName: 'Employee',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsNothing);
    expect(find.byType(FloatingActionButton), findsNothing);
    expect(find.byIcon(Icons.menu_rounded), findsNothing);
    expect(find.text('SurfSync Infotech'), findsOneWidget);
  });

  test('attendance record keeps separate check-in and check-out photos', () {
    final record = AttendanceRecord(
      employeeId: 'employee-1',
      employeeName: 'Employee',
      department: 'Engineering',
      date: DateTime(2026, 10, 14),
      photoPath: 'check-in.jpg',
      checkOutPhotoPath: 'check-out.jpg',
    );

    final restored = AttendanceRecord.fromJson(record.toJson());

    expect(restored.photoPath, 'check-in.jpg');
    expect(restored.checkOutPhotoPath, 'check-out.jpg');
  });

  testWidgets('attendance card shows check-in and check-out photo slots',
      (WidgetTester tester) async {
    InitialBinding().dependencies();
    EmployeeShellBinding().dependencies();
    Get.put(ThemeController());
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        home: const Scaffold(
          body: EmployeeAttendanceView(embedded: true),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byTooltip('Check-in photo'), findsOneWidget);
    expect(find.byTooltip('Check-out photo'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('saved theme is restored when the app is recreated',
      (WidgetTester tester) async {
    await tester.pumpWidget(const HrmsApp());
    await tester.pumpAndSettle();

    await Get.find<ThemeController>().changeThemeMode(ThemeMode.dark);
    await tester.pumpAndSettle();
    await tester.pumpWidget(const SizedBox.shrink());
    Get.reset();

    await tester.pumpWidget(const HrmsApp());
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.text('Sign In'))).brightness,
      Brightness.dark,
    );
  });

  testWidgets('system theme mode follows device brightness',
      (WidgetTester tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    await tester.pumpWidget(const HrmsApp());
    await tester.pumpAndSettle();
    await Get.find<ThemeController>().changeThemeMode(ThemeMode.system);
    await tester.pumpAndSettle();

    expect(
      Theme.of(tester.element(find.text('Sign In'))).brightness,
      Brightness.dark,
    );
  });

  testWidgets('settings appearance control changes theme immediately',
      (WidgetTester tester) async {
    Get.put(ThemeController());
    Get.put(EmployeeNotificationsController());
    Get.put(SettingsController());
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const Scaffold(body: SettingsView(embedded: true)),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.ensureVisible(find.text('Dark Mode'));
    await tester.tap(find.text('Dark Mode'));
    await tester.pumpAndSettle();

    expect(Get.find<ThemeController>().themeMode, ThemeMode.dark);
    expect(
      Theme.of(tester.element(find.text('Dark Mode'))).brightness,
      Brightness.dark,
    );
  });

  testWidgets('employee screens render in both themes and phone sizes',
      (WidgetTester tester) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    InitialBinding().dependencies();
    EmployeeShellBinding().dependencies();
    Get.put(ThemeController());
    final screens = <Widget>[
      const EmployeeHomeView(embedded: true),
      const EmployeeProfileView(embedded: true),
      const EmployeeAttendanceView(embedded: true),
      const EmployeeLeaveView(embedded: true),
      const SettingsView(embedded: true),
    ];

    for (final size in [const Size(320, 740), const Size(1440, 900)]) {
      tester.view.physicalSize = size;
      for (final mode in [ThemeMode.light, ThemeMode.dark]) {
        for (final screen in screens) {
          await tester.pumpWidget(
            GetMaterialApp(
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: mode,
              home: Scaffold(body: screen),
            ),
          );
          await tester.pump(const Duration(milliseconds: 500));
          expect(
            tester.takeException(),
            isNull,
            reason:
                '${screen.runtimeType} should render in $mode mode at $size.',
          );
        }
      }
    }
  });

  testWidgets('employee shell binds feature controllers and switches tabs',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        initialRoute: AppRoutes.employeeDashboard,
        getPages: AppPages.pages,
        initialBinding: BindingsBuilder(() {
          InitialBinding().dependencies();
          Get.put(ThemeController());
        }),
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    expect(tester.takeException(), isNull);
    expect(Get.isRegistered<EmployeeProfileController>(), isTrue);
    expect(Get.isRegistered<AttendanceController>(), isTrue);
    expect(Get.isRegistered<LeaveController>(), isTrue);

    final leaveTab = find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Leaves'),
    );
    await tester.tap(leaveTab);
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Apply leave'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
