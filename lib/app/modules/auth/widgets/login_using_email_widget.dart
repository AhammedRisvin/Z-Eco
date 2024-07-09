import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_images.dart';
import '../view_model/auth_provider.dart';

class LoginUsingEmailWidget extends StatelessWidget {
  const LoginUsingEmailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          CustomTextFormFieldWidget(
            keyboardType: TextInputType.emailAddress,
            controller:
                context.read<AuthProviders>().signingEmailTextEditingController,
            hintText: 'Enter email address',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                } else {
                  return null;
                }
              },
              isobsecureTrue: value,
              controller: context
                  .read<AuthProviders>()
                  .signingPasswordTextEditingController,
              hintText: 'Password',
              suffix: IconButton(
                  onPressed: () {
                    context.read<AuthProviders>().signPasswordVisibility();
                  },
                  icon: value == true
                      ? Image.asset(
                          AppImages.passwordEyevisibility,
                          width: 20,
                          height: 20,
                        )
                      : Image.asset(
                          AppImages.passwordVisibilityOff,
                          width: 20,
                          height: 20,
                        )),
            ),
          ),
          const SizeBoxH(15),
        ],
      ),
    );
  }
}
