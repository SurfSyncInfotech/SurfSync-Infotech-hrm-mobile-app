import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:hrms_app/app/theme/app_dimensions.dart';
import 'package:hrms_app/app/theme/app_text_styles.dart';
import 'package:hrms_app/core/widgets/app_button.dart';
import 'package:hrms_app/core/widgets/app_text_field.dart';
import 'package:hrms_app/data/models/leave_models.dart';
import 'package:hrms_app/features/employee/presentation/leave_screen/presentation/controllers/leave_controller.dart';

class LeaveRequestForm extends GetView<LeaveController> {
  const LeaveRequestForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final repository = controller.repository;
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('New leave request', style: AppTextStyles.heading3),
              const SizedBox(height: 16),
              DropdownButtonFormField<LeaveType>(
                initialValue: controller.selectedType.value,
                isExpanded: true,
                items: [
                  for (final type in LeaveType.values)
                    DropdownMenuItem(
                      value: type,
                      child: Text(type.label),
                    ),
                ],
                onChanged: (value) {
                  if (value != null) controller.selectedType.value = value;
                },
                decoration: const InputDecoration(labelText: 'Leave type'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Start date'),
                      subtitle: Text(
                        DateFormat('MM/dd/yyyy')
                            .format(controller.startDate.value),
                      ),
                      onTap: () => controller.pickStart(context),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('End date'),
                      subtitle: Text(
                        DateFormat('MM/dd/yyyy')
                            .format(controller.endDate.value),
                      ),
                      onTap: () => controller.pickEnd(context),
                    ),
                  ),
                ],
              ),
              InputDecorator(
                decoration: const InputDecoration(labelText: 'Days'),
                child: Text('${controller.calculatedDays}'),
              ),
              const SizedBox(height: 12),
              AppTextField(
                label: 'Reason',
                hint: 'Optional reason for leave',
                controller: controller.reasonController,
                maxLines: 3,
              ),
              if (controller.formError.value != null) ...[
                const SizedBox(height: 8),
                Text(
                  controller.formError.value!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 16),
              AppButton(
                label: 'Submit leave request',
                fullWidth: true,
                loading: repository.isSubmitting.value,
                onPressed: controller.submit,
              ),
            ],
          ),
        ),
      );
    });
  }
}
