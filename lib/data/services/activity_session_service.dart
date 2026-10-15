import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ActivitySessionService extends GetxService with WidgetsBindingObserver {
  final trackingEnabled = false.obs;
  final isAppActive = true.obs;
  final activeSeconds = 0.obs;
  final idleSeconds = 0.obs;
  final lastSyncedAt = Rxn<DateTime>();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  void enableTracking() {
    trackingEnabled.value = true;
    lastSyncedAt.value = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!trackingEnabled.value) return;
      if (isAppActive.value) {
        activeSeconds.value++;
      } else {
        idleSeconds.value++;
      }
      if (activeSeconds.value % 15 == 0) {
        lastSyncedAt.value = DateTime.now();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    isAppActive.value = state == AppLifecycleState.resumed;
    if (trackingEnabled.value) {
      lastSyncedAt.value = DateTime.now();
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    super.onClose();
  }
}
