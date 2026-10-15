import 'package:flutter/widgets.dart';

import '../../app/theme/app_dimensions.dart';

abstract class Responsive {
  Responsive._();

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isMobile(BuildContext context) =>
      width(context) < AppDimensions.mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final w = width(context);
    return w >= AppDimensions.mobileBreakpoint &&
        w < AppDimensions.desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      width(context) >= AppDimensions.desktopBreakpoint;
}
