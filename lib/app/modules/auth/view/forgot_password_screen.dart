import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/auth/view_model/auth_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60), child: CustomAppBarWidget()),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizeBoxH(50),
              CustomTextWidgets(
                text: 'Forgot Password?',
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
                    '''Don't worry! It occurs. Please enter the \nemail address linked with your account.''',
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF8390A1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizeBoxH(35),
              CustomTextFormFieldWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    } else {
                      return null;
                    }
                  },
                  controller: context
                      .read<AuthProviders>()
                      .forgotEmailTextEditingController,
                  hintText: "Enter your email"),
              const SizeBoxH(30),
              CommonButton(
                btnName: "Send Code",
                ontap: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<AuthProviders>()
                        .checkovVerificationScenarioFn('forgotPassword');

                    context
                        .read<AuthProviders>()
                        .forgotPasswordFn(context: context);
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
                    text: 'Remember Password? ',
                  ),
                  CommonInkwell(
                    onTap: () => context.goNamed(
                      AppRouter.login,
                    ),
                    child: CustomTextWidgets(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                      text: 'Log in',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
