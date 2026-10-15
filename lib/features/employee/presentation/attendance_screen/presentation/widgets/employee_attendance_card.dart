import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_app/app/theme/app_dimensions.dart';
import 'package:hrms_app/data/models/attendance_record.dart';
import 'package:hrms_app/features/employee/presentation/home_screen/presentation/widgets/home_style.dart';

import '../controllers/attendance_controller.dart';

class EmployeeAttendanceCard extends GetView<AttendanceController> {
  const EmployeeAttendanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceController = controller;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Obx(() {
      final today = attendanceController.today;
      final state = today.punchState;
      final busy = attendanceController.attendance.isBusy.value ||
          attendanceController.capturing.value;
      attendanceController.attendance.records.length;

      final hasLocation = today.latitude != null && today.longitude != null;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimensions.spaceLg),
        decoration: HomeStyle.card(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title + status ────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Attendance',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                _StatusPill(state: state),
              ],
            ),
            const SizedBox(height: 16),

            // ── Metrics ───────────────────────────────────────
            LayoutBuilder(builder: (context, constraints) {
              const gap = 16.0;
              final columns = constraints.maxWidth >= 640 ? 4 : 2;
              final w = (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: 18,
                children: [
                  _Metric(
                    width: w,
                    label: 'Today',
                    value: attendanceController.todayLabel,
                    big: true,
                  ),
                  _Metric(
                    width: w,
                    label: 'Check in',
                    value: attendanceController.formatTime(today.checkIn),
                    accent: today.checkIn != null,
                    trailing: _PhotoThumb(
                      path: today.photoPath,
                      label: 'Check-in photo',
                    ),
                  ),
                  _Metric(
                    width: w,
                    label: 'Check out',
                    value: attendanceController.formatTime(today.checkOut),
                    trailing: _PhotoThumb(
                      path: today.checkOutPhotoPath,
                      label: 'Check-out photo',
                    ),
                  ),
                  _Metric(
                    width: w,
                    label: 'Current period',
                    value: attendanceController.periodLabel ?? '—',
                    accent: attendanceController.periodLabel != null,
                  ),
                ],
              );
            }),
            const SizedBox(height: 18),

            // ── Location ──────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
              decoration: BoxDecoration(
                color: colors.surfaceContainerHighest.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 20, color: colors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      today.locationLabel ??
                          'Location is saved when you check in',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        height: 1.3,
                      ),
                    ),
                  ),
                  if (hasLocation)
                    TextButton(
                      onPressed: () => Get.snackbar(
                        'Check-in location',
                        '${today.latitude}, ${today.longitude}',
                        snackPosition: SnackPosition.BOTTOM,
                      ),
                      child: const Text('Map'),
                    ),
                ],
              ),
            ),

            if (attendanceController.errorMessage.value != null) ...[
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.error_outline_rounded,
                      size: 18, color: colors.error),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      attendanceController.errorMessage.value!,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: colors.error),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),

            // ── Punch button ──────────────────────────────────
            _PunchButton(
              state: state,
              busy: busy,
              onPressed: attendanceController.punch,
            ),
            const SizedBox(height: 10),
            Text(
              'A live photo and your GPS position are saved with each punch. '
              'This is not a biometric identity match.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
                fontSize: 11.5,
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ───────────────────────────── widgets ─────────────────────────────

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.state});
  final AttendancePunchState state;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final (label, bg, fg) = switch (state) {
      AttendancePunchState.notCheckedIn => (
          'Not checked in',
          colors.surfaceContainerHighest,
          colors.onSurfaceVariant,
        ),
      AttendancePunchState.checkedIn => (
          'Working',
          colors.primaryContainer,
          colors.onPrimaryContainer,
        ),
      AttendancePunchState.checkedOut => (
          'Done for today',
          colors.secondaryContainer,
          colors.onSecondaryContainer,
        ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: fg,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({required this.path, required this.label});
  final String? path;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Tooltip(
      message: label,
      child: Container(
        height: 40,
        width: 40,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colors.outlineVariant, width: 1.5),
          color: colors.surfaceContainerHighest,
        ),
        child: path == null
            ? Icon(
                Icons.photo_camera_back_outlined,
                size: 19,
                color: colors.onSurfaceVariant,
              )
            : Image.file(
                File(path!),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image_outlined,
                  size: 19,
                  color: colors.onSurfaceVariant,
                ),
              ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.width,
    required this.label,
    required this.value,
    this.big = false,
    this.accent = false,
    this.trailing,
  });

  final double width;
  final String label;
  final String value;
  final bool big;
  final bool accent;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final valueStyle =
        (big ? theme.textTheme.titleLarge : theme.textTheme.titleMedium)
            ?.copyWith(
      color: accent ? colors.primary : colors.onSurface,
      fontWeight: FontWeight.w800,
    );

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Flexible(
                child: Text(value,
                    overflow: TextOverflow.ellipsis, style: valueStyle),
              ),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          ),
        ],
      ),
    );
  }
}

class _PunchButton extends StatelessWidget {
  const _PunchButton({
    required this.state,
    required this.busy,
    required this.onPressed,
  });

  final AttendancePunchState state;
  final bool busy;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final dark = HomeStyle.isDark(context);

    final (label, icon, bg, fg) = switch (state) {
      AttendancePunchState.notCheckedIn => (
          'Check in with face scan',
          Icons.photo_camera_outlined,
          colors.primary,
          colors.onPrimary,
        ),
      AttendancePunchState.checkedIn => (
          'Check out with face scan',
          Icons.photo_camera_outlined,
          dark ? colors.error.withValues(alpha: 0.22) : colors.errorContainer,
          dark ? colors.error : colors.onErrorContainer,
        ),
      AttendancePunchState.checkedOut => (
          'Attendance completed',
          Icons.check_circle_outline_rounded,
          colors.surfaceContainerHighest,
          colors.onSurfaceVariant,
        ),
    };
    final disabled = state == AttendancePunchState.checkedOut || busy;

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: disabled ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: busy ? bg : colors.surfaceContainerHighest,
          disabledForegroundColor: busy ? fg : colors.onSurfaceVariant,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: busy
              ? SizedBox(
                  key: const ValueKey('busy'),
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.4, color: fg),
                )
              : Row(
                  key: ValueKey(label),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        label,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
