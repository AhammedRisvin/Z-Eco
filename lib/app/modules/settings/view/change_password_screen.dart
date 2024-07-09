import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';
import '../view model/settings_provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: 'Change password',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          children: [
            Consumer<SettingsProvider>(
              builder: (context, value, child) => Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormFieldWidget(
                        keyboardType: TextInputType.text,
                        isobsecureTrue: value.isCurrentiddenPassword,
                        controller: value.currentpasswordTextEditingController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your current password';
                          } else {
                            return null;
                          }
                        },
                        suffix: IconButton(
                          onPressed: () {
                            value.currentpasswordVisibility();
                          },
                          icon: value.isCurrentiddenPassword == true
                              ? Image.asset(
                                  AppImages.passwordEyevisibility,
                                  width: 20,
                                  height: 20,
                                )
                              : Image.asset(
                                  AppImages.passwordVisibilityOff,
                                  width: 20,
                                  height: 20,
                                ),
                        ),
                        hintText: "Current password"),
                    const SizeBoxH(20),
                    CustomTextFormFieldWidget(
                        keyboardType: TextInputType.text,
                        isobsecureTrue: value.isSignUnhiddenPassword,
                        controller: value.passwordTextEditingController,
                        suffix: IconButton(
                          onPressed: () {
                            value.signPasswordVisibility();
                          },
                          icon: value.isSignUnhiddenPassword == true
                              ? Image.asset(
                                  AppImages.passwordEyevisibility,
                                  width: 20,
                                  height: 20,
                                )
                              : Image.asset(
                                  AppImages.passwordVisibilityOff,
                                  width: 20,
                                  height: 20,
                                ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          } else {
                            return null;
                          }
                        },
                        hintText: "New password"),
                    const SizeBoxH(20),
                    CustomTextFormFieldWidget(
                      keyboardType: TextInputType.text,
                      isobsecureTrue: value.isSignUnhiddenConfirmPassword,
                      controller: value.confirmPasswordTextEditingController,
                      suffix: IconButton(
                        onPressed: () {
                          value.signConfirmPasswordVisibility();
                        },
                        icon: value.isSignUnhiddenConfirmPassword == true
                            ? Image.asset(
                                AppImages.passwordEyevisibility,
                                width: 20,
                                height: 20,
                              )
                            : Image.asset(
                                AppImages.passwordVisibilityOff,
                                width: 20,
                                height: 20,
                              ),
                      ),
                      validator: (valued) {
                        if (valued?.isEmpty ?? true) {
                          return 'Please enter your confirm password';
                        } else if (valued !=
                            value.confirmPasswordTextEditingController.text) {
                          return 'Passwords do not match';
                        } else {
                          return null;
                        }
                      },
                      hintText: "Confirm password",
                    ),
                    SizeBoxH(Responsive.height * 10),
                  ],
                ),
              ),
            ),
            const Spacer(),
            CommonButton(
              btnName: "Submit",
              ontap: () {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomAlertDialog(
                        btntext: "Change",
                        cancel: () {
                          context.pop();
                        },
                        ok: () {
                          context
                              .read<SettingsProvider>()
                              .changePasswordFn(context: context);
                        },
                        heading: 'Change password?',
                        bodyText: 'Are you sure want to change\n the password?',
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String heading;
  final String bodyText;
  final String btntext;
  final bool isOkButtonColorRed;
  final void Function() cancel;
  final void Function() ok;

  const CustomAlertDialog(
      {super.key,
      required this.heading,
      required this.bodyText,
      required this.cancel,
      this.isOkButtonColorRed = true,
      this.btntext = "Confirm",
      required this.ok});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: Responsive.height * 25,
        width: Responsive.width * 90,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().isDarkMode == true
              ? AppConstants.containerColor
              : const Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextWidgets(
              textAlign: TextAlign.center,
              text: heading,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const Divider(
              color: Color(0xffDCE5F2),
            ),
            CustomTextWidgets(
              textAlign: TextAlign.center,
              text: bodyText,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AlertDialogContainer(
                  text: "Cancel",
                  onTap: cancel,
                  bgColor: const Color(0xffEFF2FC),
                  textColor: const Color(0xff8391A1),
                ),
                AlertDialogContainer(
                  text: btntext,
                  onTap: ok,
                  bgColor: isOkButtonColorRed
                      ? const Color(0xffEB000E)
                      : const Color(0xff2F4EFF),
                  textColor: const Color(0xffFFFFFF),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AlertDialogContainer extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final void Function() onTap;
  const AlertDialogContainer({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        height: Responsive.height * 4.5,
        width: Responsive.width * 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: bgColor,
        ),
        child: Center(
          child: CustomTextWidgets(
            text: text,
            textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 18,
                  fontFamily: 'Plus Jakarta Sans',
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}
