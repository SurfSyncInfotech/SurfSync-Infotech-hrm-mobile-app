import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimensions.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/login_controller.dart';

/// Login screen for Employee and Admin/HR. Colours, radii, fonts, inputs and
/// buttons all come from the shared theme and core widgets.
class LoginView extends GetView<LoginController> {
  const LoginView({super.key, this.isAdmin = false});

  final bool isAdmin;

  Widget _label(String text, Color color) => Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.spaceXs + 2),
        child: Text(
          text,
          style: AppTextStyles.bodyBold.copyWith(
            fontSize: 13.5,
            color: color,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final fieldStyle = AppTextStyles.body.copyWith(
      fontSize: 15,
      color: colors.onSurface,
    );

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
        child: Stack(
          children: [
            const Positioned(top: -90, left: -70, child: _Circle(size: 260)),
            const Positioned(
                bottom: -120, right: -90, child: _Circle(size: 320)),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceMd + 4,
                    vertical: AppDimensions.spaceLg,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 380),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(26, 30, 26, 24),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusLg),
                        border: Border.all(color: colors.outline),
                        boxShadow: [
                          BoxShadow(
                            color: colors.shadow.withValues(alpha: 0.14),
                            blurRadius: 36,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Center(child: _LogoMark()),
                            const SizedBox(height: AppDimensions.spaceSm - 2),
                            Text(
                              AppConstants.companyName,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.heading1.copyWith(
                                fontSize: 22,
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spaceXs),
                            Text(
                              isAdmin
                                  ? 'Sign in to the Admin / HR portal'
                                  : 'Sign in to your employee portal',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMuted.copyWith(
                                fontSize: 13.5,
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spaceMd + 2),

                            // Email — decoration comes from AppTheme
                            _label('Email', colors.onSurface),
                            TextFormField(
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              validator: controller.validateEmail,
                              style: fieldStyle,
                              decoration: InputDecoration(
                                hintText: 'you@company.com',
                                prefixIcon: Icon(
                                  Icons.mail_outline_rounded,
                                  size: 20,
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spaceMd),

                            // Password
                            _label('Password', colors.onSurface),
                            Obx(
                              () => TextFormField(
                                controller: controller.passwordController,
                                obscureText: controller.obscurePassword.value,
                                textInputAction: TextInputAction.done,
                                validator: controller.validatePassword,
                                onFieldSubmitted: (_) =>
                                    controller.submit(isAdmin: isAdmin),
                                style: fieldStyle,
                                decoration: InputDecoration(
                                  hintText: 'Enter your password',
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    size: 20,
                                    color: colors.onSurfaceVariant,
                                  ),
                                  suffixIcon: IconButton(
                                    tooltip: controller.obscurePassword.value
                                        ? 'Show password'
                                        : 'Hide password',
                                    onPressed:
                                        controller.togglePasswordVisibility,
                                    icon: Icon(
                                      controller.obscurePassword.value
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      size: 20,
                                      color: colors.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),

                            Obx(
                              () => AppButton(
                                label: 'Sign In',
                                fullWidth: true,
                                loading: controller.isLoading.value,
                                onPressed: () =>
                                    controller.submit(isAdmin: isAdmin),
                              ),
                            ),
                            const SizedBox(height: 18),

                            Row(
                              children: [
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text('or',
                                      style: AppTextStyles.bodyMuted.copyWith(
                                        fontSize: 12.5,
                                        color: colors.onSurfaceVariant,
                                      )),
                                ),
                                const Expanded(child: Divider()),
                              ],
                            ),
                            const SizedBox(height: 14),
                            AppButton(
                              label: isAdmin
                                  ? 'Employee? Sign in here'
                                  : 'Admin or HR? Sign in here',
                              type: AppButtonType.outline,
                              fullWidth: true,
                              onPressed: () => Get.offNamed(isAdmin
                                  ? AppRoutes.login
                                  : AppRoutes.adminLogin),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  const _LogoMark();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      width: 140,
      child: Image.asset(
        'assets/images/surfsync_logo.png',
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.10),
      ),
    );
  }
}
