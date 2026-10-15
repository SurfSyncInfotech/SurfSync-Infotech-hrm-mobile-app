import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hrms_app/app/theme/app_dimensions.dart';
import 'package:hrms_app/data/services/activity_session_service.dart';

import 'home_style.dart';

class LiveSessionTrackingCard extends StatelessWidget {
  const LiveSessionTrackingCard({super.key});

  String _format(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    if (h > 0) return '${h}h ${m.toString().padLeft(2, '0')}m';
    return '${m}m ${s.toString().padLeft(2, '0')}s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final service = Get.find<ActivitySessionService>();
    final dark = HomeStyle.isDark(context);
    final onHero = HomeStyle.onHero(context);

    return Obx(() {
      final enabled = service.trackingEnabled.value;
      final active = enabled && service.isAppActive.value;
      final synced = service.lastSyncedAt.value;

      final statusText = !enabled ? 'Off' : (active ? 'Active' : 'Idle');

      return Container(
        decoration: HomeStyle.card(context),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Hero header ─────────────────────────────────
            Container(
              padding: const EdgeInsets.all(AppDimensions.spaceLg),
              decoration:
                  BoxDecoration(gradient: HomeStyle.heroGradient(context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: onHero.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(Icons.sensors_rounded, color: onHero),
                      ),
                      Positioned(
                        top: -3,
                        right: -3,
                        child: _LiveDot(on: active),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Live session tracking',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: onHero,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Counts as active while the app is open. '
                          'Goes idle when it moves to the background.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: onHero.withValues(alpha: 0.8),
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: onHero.withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      statusText,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: onHero,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Permission notice ───────────────────────────
            if (!enabled)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceLg,
                  vertical: 12,
                ),
                color: dark ? const Color(0xFF3A3217) : const Color(0xFFFFF8DC),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 20,
                      color: dark
                          ? const Color(0xFFF2D675)
                          : const Color(0xFF8A6D00),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tracking is off. Turn it on to record your active time.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: dark
                              ? const Color(0xFFF2D675)
                              : const Color(0xFF6B5500),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: service.enableTracking,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.onSurface,
                        backgroundColor: colors.surface,
                        side: BorderSide(color: colors.outlineVariant),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Allow'),
                    ),
                  ],
                ),
              ),

            // ── Metrics ─────────────────────────────────────
            if (enabled)
              Padding(
                padding: const EdgeInsets.all(AppDimensions.spaceMd),
                child: Row(
                  children: [
                    Expanded(
                      child: _Metric(
                        icon: Icons.timer_outlined,
                        label: 'Active',
                        value: _format(service.activeSeconds.value),
                        caption: 'working',
                        tint: colors.primary,
                        tintBg: colors.primary.withValues(alpha: 0.12),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _Metric(
                        icon: Icons.pause_rounded,
                        label: 'Idle',
                        value: _format(service.idleSeconds.value),
                        caption: 'away',
                        tint: dark
                            ? const Color(0xFFFF9B7A)
                            : const Color(0xFFD9542C),
                        tintBg: (dark
                                ? const Color(0xFFFF9B7A)
                                : const Color(0xFFD9542C))
                            .withValues(alpha: 0.13),
                      ),
                    ),
                  ],
                ),
              ),

            // ── Footer ──────────────────────────────────────
            if (synced != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spaceLg,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: colors.outlineVariant),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sync_rounded,
                        size: 16, color: colors.onSurfaceVariant),
                    const SizedBox(width: 6),
                    Text(
                      'Last synced at ${DateFormat('hh:mm a').format(synced)}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: colors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}

class _Metric extends StatelessWidget {
  const _Metric({
    required this.icon,
    required this.label,
    required this.value,
    required this.caption,
    required this.tint,
    required this.tintBg,
  });

  final IconData icon;
  final String label;
  final String value;
  final String caption;
  final Color tint;
  final Color tintBg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: tintBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: tint, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
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
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  caption,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: colors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small green dot that softly pulses while the session is active.
class _LiveDot extends StatefulWidget {
  const _LiveDot({required this.on});
  final bool on;

  @override
  State<_LiveDot> createState() => _LiveDotState();
}

class _LiveDotState extends State<_LiveDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.on ? const Color(0xFF4ADE80) : Colors.white54;
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => Container(
        height: 11,
        width: 11,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: widget.on
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.55 * _c.value),
                    blurRadius: 8,
                    spreadRadius: 3 * _c.value,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
