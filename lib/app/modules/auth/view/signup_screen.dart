import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/auth/view_model/auth_provider.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../widgets/auth_using_phone_widget.dart';
import '../widgets/email_phone_tab.dart';
import '../widgets/signup_using_email_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthProviders? authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProviders>();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthProviders>(
          builder: (context, valueProvider, child) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizeBoxH(70),
                CustomTextWidgets(
                  text: 'Create your\nAccount',
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 28,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                ),
                const SizeBoxH(40),

                /*signup method widget*/
                const EmailPhoneTab(),
                /*signup method widget end*/
                const SizeBoxH(15),
                valueProvider.isAuthUsingEmail == true
                    ? SignupUsingEmailWidget(formKey: _formKey)
                    : const AuthUsingPhoneWidget(),
                SizeBoxH(Responsive.height * 8),
                CommonButton(
                  btnName: "Sign up",
                  ontap: () {
                    if (valueProvider.isAuthUsingEmail == true) {
                      if (_formKey.currentState!.validate()) {
                        valueProvider.checkovVerificationScenarioFn('email');
                        valueProvider.emailSignupFun(context: context);
                      }
                    } else {
                      if (valueProvider.signupPhoneNumberTextEditingController
                          .text.isNotEmpty) {
                        valueProvider.checkovVerificationScenarioFn('phone');

                        valueProvider.signin(context: context);
                      } else {
                        toast(context,
                            backgroundColor: Colors.red,
                            title: 'Please add your number');
                      }
                    }
                    //
                  },
                ),
                const SizeBoxH(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonInkwell(
                      onTap: () => context.pushReplacementNamed(
                        AppRouter.login,
                      ),
                      child: CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 14,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                        text: 'Already have an account? ',
                      ),
                    ),
                    CommonInkwell(
                      onTap: () {
                        valueProvider.checkovVerificationScenarioFn('email');
                        context.pushReplacementNamed(
                          AppRouter.login,
                        );
                      },
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
      ),
    );
  }
}
