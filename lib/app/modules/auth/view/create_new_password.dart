import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/auth/view_model/auth_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_images.dart';

class CreateNewPasswordScreen extends StatelessWidget {
  CreateNewPasswordScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBarWidget()),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizeBoxH(50),
            CustomTextWidgets(
              text: 'Create new password',
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    height: 0.05,
                  ),
            ),
            const SizeBoxH(20),
            CustomTextWidgets(
              text:
                  '''Your new password must be unique from \nthose previously used.''',
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(0xFF8390A1),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizeBoxH(35),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Selector<AuthProviders, bool>(
                    selector: (p0, p1) => p1.isSignUnhiddenPassword,
                    builder: (context, value, child) =>
                        CustomTextFormFieldWidget(
                            keyboardType: TextInputType.text,
                            isobsecureTrue: value,
                            controller: context
                                .read<AuthProviders>()
                                .forgotPasswordTextEditingController,
                            suffix: IconButton(
                                onPressed: () {
                                  context
                                      .read<AuthProviders>()
                                      .signPasswordVisibility();
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a password';
                              } else {
                                return null;
                              }
                            },
                            hintText: "New password"),
                  ),
                  const SizeBoxH(20),
                  Selector<AuthProviders, bool>(
                    selector: (p0, p1) => p1.isSignUnhiddenConfirmPassword,
                    builder: (context, value, child) =>
                        CustomTextFormFieldWidget(
                            keyboardType: TextInputType.text,
                            isobsecureTrue: value,
                            controller: context
                                .read<AuthProviders>()
                                .forgotConfirmPasswordTextEditingController,
                            suffix: IconButton(
                                onPressed: () {
                                  context
                                      .read<AuthProviders>()
                                      .signConfirmPasswordVisibility();
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your confirm password';
                              } else if (value !=
                                  context
                                      .read<AuthProviders>()
                                      .forgotPasswordTextEditingController
                                      .text) {
                                return 'Passwords do not match';
                              } else {
                                return null;
                              }
                            },
                            hintText: "Confirm password"),
                  ),
                ],
              ),
            ),
            const SizeBoxH(30),
            CommonButton(
              btnName: "Resset Password",
              ontap: () {
                if (_formKey.currentState!.validate()) {
                  context
                      .read<AuthProviders>()
                      .createNewPasswordFn(context: context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
