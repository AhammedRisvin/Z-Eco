import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_images.dart';
import '../view_model/auth_provider.dart';

class SignupUsingEmailWidget extends StatelessWidget {
  const SignupUsingEmailWidget({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormFieldWidget(
              keyboardType: TextInputType.emailAddress,
              controller: context
                  .read<AuthProviders>()
                  .signupEmailTextEditingController,
              hintText: 'Enter email address',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email address';
                  // } else if (!RegExp(
                  //         r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                  //     .hasMatch(value)) {
                  //   return 'Please enter a valid email address';
                } else {
                  return null;
                }
              },
            ),
            const SizeBoxH(20),
            Selector<AuthProviders, bool>(
              selector: (p0, p1) => p1.isSignUnhiddenPassword,
              builder: (context, value, child) => CustomTextFormFieldWidget(
                keyboardType: TextInputType.text,
                isobsecureTrue: value,
                controller: context
                    .read<AuthProviders>()
                    .signupPasswordTextEditingController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  } else {
                    return null;
                  }
                },
                suffix: IconButton(
                    onPressed: () {
                      context.read<AuthProviders>().signPasswordVisibility();
                    },
                    icon: value == true
                        ? Image.asset(
                            AppImages.passwordVisibilityOff,
                            width: 20,
                            height: 20,
                          )
                        : Image.asset(
                            AppImages.passwordEyevisibility,
                            width: 20,
                            height: 20,
                          )),
              ),
            ),
            const SizeBoxH(20),
            Selector<AuthProviders, bool>(
              selector: (p0, p1) => p1.isSignUnhiddenConfirmPassword,
              builder: (context, value, child) => CustomTextFormFieldWidget(
                keyboardType: TextInputType.text,
                isobsecureTrue: value,
                controller: context
                    .read<AuthProviders>()
                    .signupConfirmPasswordTextEditingController,
                hintText: 'Confirm password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your confirm password';
                  } else if (value !=
                      context
                          .read<AuthProviders>()
                          .signupPasswordTextEditingController
                          .text) {
                    return 'Passwords do not match';
                  } else {
                    return null;
                  }
                },
                suffix: IconButton(
                    onPressed: () {
                      context
                          .read<AuthProviders>()
                          .signConfirmPasswordVisibility();
                    },
                    icon: value == true
                        ? Image.asset(
                            AppImages.passwordVisibilityOff,
                            width: 20,
                            height: 20,
                          )
                        : Image.asset(
                            AppImages.passwordEyevisibility,
                            width: 20,
                            height: 20,
                          )),
              ),
            ),
            const SizeBoxH(15),
          ],
        ),
      ),
    );
  }
}
