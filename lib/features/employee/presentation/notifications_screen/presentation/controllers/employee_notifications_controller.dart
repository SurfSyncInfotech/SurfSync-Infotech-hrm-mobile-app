import 'package:get/get.dart';

class EmployeeNotificationItem {
  EmployeeNotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });

  final String title;
  final String message;
  final String time;
  final bool isRead;

  EmployeeNotificationItem copyWith({bool? isRead}) {
    return EmployeeNotificationItem(
      title: title,
      message: message,
      time: time,
      isRead: isRead ?? this.isRead,
    );
  }
}

class EmployeeNotificationsController extends GetxController {
  final RxList<EmployeeNotificationItem> notifications =
      <EmployeeNotificationItem>[
    EmployeeNotificationItem(
      title: 'Leave request approved',
      message:
          'Your leave request for Oct 12 - 14 has been approved by your manager.',
      time: '10 mins ago',
    ),
    EmployeeNotificationItem(
      title: 'Payslip ready',
      message: 'Your October payslip is now available to download.',
      time: '2 hours ago',
      isRead: true,
    ),
    EmployeeNotificationItem(
      title: 'Policy update',
      message:
          'A new employee policy has been published in the company portal.',
      time: 'Yesterday',
      isRead: true,
    ),
  ].obs;

  int get unreadCount => notifications.where((item) => !item.isRead).length;

  void markAsRead(int index) {
    if (index < 0 || index >= notifications.length) return;
    notifications[index] = notifications[index].copyWith(isRead: true);
  }

  void markAllAsRead() {
    notifications.assignAll(
      notifications.map((item) => item.copyWith(isRead: true)).toList(),
    );
  }

  void clearAll() {
    notifications.clear();
  }
}
