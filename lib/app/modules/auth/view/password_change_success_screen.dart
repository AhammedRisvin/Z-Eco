import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/utils/app_images.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';

class PasswordChangeSuccessScreen extends StatelessWidget {
  const PasswordChangeSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.successmark,
                height: 100,
                width: 100,
              ),
              const SizeBoxH(50),
              CustomTextWidgets(
                text: 'Password Changed!',
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      height: 0.05,
                    ),
              ),
              const SizeBoxH(20),
              CustomTextWidgets(
                text: '''Your password has been \nchanged successfully.''',
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF8390A1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizeBoxH(20),
              CommonButton(
                btnName: "Back to login",
                ontap: () {
                  context.goNamed(AppRouter.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
