import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key, this.isAdmin = false});

  /// `true` for the Admin / HR sign-in variant.
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.loginGradient,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(36, 40, 36, 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.14),
                        blurRadius: 32,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _BrandMark(),
                        const SizedBox(height: 20),
                        Text(
                          AppConstants.companyName,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading1
                              .copyWith(fontSize: 24, color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          isAdmin
                              ? 'Admin / HR sign in'
                              : 'Welcome to ${AppConstants.companyName}',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMuted,
                        ),
                        const SizedBox(height: 28),
                        AppTextField(
                          label: 'Email',
                          prefixIcon: Icons.mail_outline_rounded,
                          hint: isAdmin
                              ? 'admin@company.com'
                              : 'you@company.com',
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: controller.validateEmail,
                        ),
                        const SizedBox(height: 18),
                        Obx(
                          () => AppTextField(
                            label: 'Password',
                            prefixIcon: Icons.lock_outline_rounded,
                            hint: 'Enter your password',
                            controller: controller.passwordController,
                            obscureText: controller.obscurePassword.value,
                            textInputAction: TextInputAction.done,
                            validator: controller.validatePassword,
                            onSubmitted: (_) =>
                                controller.submit(isAdmin: isAdmin),
                            suffix: IconButton(
                              tooltip: controller.obscurePassword.value
                                  ? 'Show password'
                                  : 'Hide password',
                              onPressed: controller.togglePasswordVisibility,
                              icon: Icon(
                                controller.obscurePassword.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Obx(
                          () => AppButton(
                            label: 'Sign In',
                            fullWidth: true,
                            loading: controller.isLoading.value,
                            onPressed: () =>
                                controller.submit(isAdmin: isAdmin),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextButton(
                          onPressed: () => Get.offNamed(
                              isAdmin ? AppRoutes.login : AppRoutes.adminLogin),
                          child: Text(
                            isAdmin
                                ? 'Employee? Sign in here'
                                : 'Admin or HR? Sign in here',
                            style: AppTextStyles.body
                                .copyWith(color: AppColors.forest, fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Demo mode: any valid email and a 6+ character password.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyMuted.copyWith(fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(AppRoutes.designSystem),
                          child: Text('View UI kit',
                              style: AppTextStyles.bodyMuted
                                  .copyWith(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          color: AppColors.warningBg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.wb_sunny_rounded,
            size: 34, color: AppColors.orange),
      ),
    );
  }
}
