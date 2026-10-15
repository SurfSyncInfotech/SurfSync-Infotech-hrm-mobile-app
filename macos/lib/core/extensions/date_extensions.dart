import 'package:intl/intl.dart';

extension DateFormatting on DateTime {
  /// e.g. 12 Oct 2026
  String get dMMMy => DateFormat('d MMM yyyy').format(this);
}
