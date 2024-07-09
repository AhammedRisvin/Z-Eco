import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/auth/view_model/auth_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';

import '../../../helpers/common_widgets.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizeBoxH(10),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppConstants.black,
              ),
            ),
            const SizeBoxH(60),
            const SizeBoxH(70),
            CustomTextWidgets(
              text: 'OTP Verification',
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
                  'Enter the verification code we just sent on \nyour ${context.read<AuthProviders>().isAuthUsingEmail == true ? "email address" : "phone number"}.',
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(0xFF8390A1),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizeBoxH(35),
            Center(
              child: Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                length: 6,
                focusedPinTheme: PinTheme(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppConstants.appPrimaryColor.withOpacity(0.1),
                    border: Border.all(
                      color: AppConstants.appPrimaryColor.withOpacity(.4),
                    ),
                  ),
                ),
                defaultPinTheme: PinTheme(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppConstants.appPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  context.read<AuthProviders>().otpController = pin;
                },
                errorPinTheme: PinTheme(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppConstants.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppConstants.red.withOpacity(.4),
                    ),
                  ),
                ),
                errorText: 'Entered pin is incorrect',
                errorTextStyle: const TextStyle(
                  color: AppConstants.red,
                  fontSize: 12,
                ),
                onTapOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                pinAnimationType: PinAnimationType.fade,
                submittedPinTheme: PinTheme(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.green.withOpacity(.4),
                    ),
                  ),
                ),
              ),
            ),
            const SizeBoxH(30),
            CommonButton(
              btnName: "Verify",
              ontap: () {
                if (context.read<AuthProviders>().otpController?.isNotEmpty ==
                    true) {
                  if (context.read<AuthProviders>().otpVerificationScenario ==
                      'email') {
                    context.read<AuthProviders>().validateOtpFun(
                          context: context,
                        );
                  } else if (context
                          .read<AuthProviders>()
                          .otpVerificationScenario ==
                      'phone') {
                    context.read<AuthProviders>().validateOtpFun(
                          context: context,
                        );
                  } else if (context
                          .read<AuthProviders>()
                          .otpVerificationScenario ==
                      'forgotPassword') {
                    context.read<AuthProviders>().validateOtpFun(
                          context: context,
                        );
                  }
                } else {
                  toast(
                    context,
                    title: 'Please enter the OTP',
                    duration: 1,
                    backgroundColor: AppConstants.red,
                  );
                }
              },
            ),
            const SizeBoxH(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidgets(
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 14,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                  text: 'Didn’t received code? ',
                ),
                CommonInkwell(
                  onTap: () {
                    context
                        .read<AuthProviders>()
                        .resendOtpFun(context: context);
                  },
                  child: CustomTextWidgets(
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                    text: 'Resend',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
