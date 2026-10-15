import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrms_app/app/routes/app_routes.dart';
import 'package:hrms_app/data/repositories/employee_directory_repository.dart';
import 'package:hrms_app/features/employee/data/models/employee_model.dart';
import 'package:hrms_app/shared/layouts/employee_layout.dart';
import 'package:intl/intl.dart';

class EmployeeAnnouncementsView extends StatelessWidget {
  const EmployeeAnnouncementsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final birthdays = Get.find<EmployeeDirectoryRepository>()
        .employees
        .where((employee) => employee.status != 'Inactive')
        .map((employee) => _BirthdayAnnouncement(
              employee: employee,
              date: _nextBirthday(employee.dateOfBirth, todayOnly),
            ))
        .toList()
      ..sort((first, second) => first.date.compareTo(second.date));

    final content = ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Text(
          'Announcements',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: colors.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
        // const SizedBox(height: 4),
        // Text(
        //   'Company notices, events, birthday wishes, and alerts.',
        //   style: theme.textTheme.bodyMedium?.copyWith(
        //     color: colors.onSurfaceVariant,
        //   ),
        // ),
        const SizedBox(height: 20),
        Row(
          children: [
            Icon(Icons.campaign_outlined, color: colors.primary),
            const SizedBox(width: 8),
            Text(
              'Upcoming birthdays',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (birthdays.isEmpty)
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.event_note_outlined,
                    size: 38,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'No upcoming birthdays',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'New company announcements will appear here.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...birthdays.map(
            (birthday) => _BirthdayAnnouncementCard(announcement: birthday),
          ),
      ],
    );

    return EmployeeLayout(
      currentRoute: AppRoutes.employeeAnnouncements,
      scrollBody: false,
      child: content,
    );
  }
}

DateTime _nextBirthday(DateTime birthday, DateTime today) {
  var next = DateTime(today.year, birthday.month, birthday.day);
  if (next.isBefore(today)) {
    next = DateTime(today.year + 1, birthday.month, birthday.day);
  }
  return next;
}

class _BirthdayAnnouncement {
  const _BirthdayAnnouncement({
    required this.employee,
    required this.date,
  });

  final Employee employee;
  final DateTime date;
}

class _BirthdayAnnouncementCard extends StatelessWidget {
  const _BirthdayAnnouncementCard({required this.announcement});

  final _BirthdayAnnouncement announcement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final name = announcement.employee.name;
    final displayName = name.trim().split(RegExp(r'\s+')).first;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.secondary.withValues(alpha: 0.55)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.cake_outlined,
                    color: colors.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Happy Birthday, $name!',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 10,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'BIRTHDAY',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            DateFormat('d MMM yyyy').format(announcement.date),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              "Let's wish $displayName a wonderful birthday!",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
