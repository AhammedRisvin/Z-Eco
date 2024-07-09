import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/auth/view_model/auth_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../widgets/auth_using_phone_widget.dart';
import '../widgets/email_phone_tab.dart';
import '../widgets/login_using_email_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<AuthProviders>(
            builder: (context, valueProvider, child) => Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeBoxH(
                    Responsive.height * 3,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.pushReplacement(AppRouter.tab);
                      },
                      child: CustomTextWidgets(
                        text: 'Skip',
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                  fontSize: 18,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                      ),
                    ),
                  ),
                  const SizeBoxH(30),
                  CustomTextWidgets(
                    text: 'Login',
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 28,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                  ),
                  const SizeBoxH(10),
                  CustomTextWidgets(
                    text: 'Welcome back to the app',
                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppConstants.appMainGreyColor,
                          fontSize: 16,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                  ),
                  const SizeBoxH(35),
                  const EmailPhoneTab(),
                  const SizeBoxH(15),
                  valueProvider.isAuthUsingEmail == true
                      ? const LoginUsingEmailWidget()
                      : const AuthUsingPhoneWidget(),
                  valueProvider.isAuthUsingEmail == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CommonInkwell(
                              onTap: () => context.pushNamed(
                                AppRouter.forgotPassword,
                              ),
                              child: CustomTextWidgets(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 13,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                text: 'forgot password?',
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  SizeBoxH(Responsive.height * 10),
                  CommonButton(
                    btnName: "Login",
                    ontap: () {
                      if (valueProvider.isAuthUsingEmail == true) {
                        if (_formKey.currentState!.validate()) {
                          valueProvider.signin(context: context);
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
                    },
                  ),
                  const SizeBoxH(20),
                  Center(
                    child: CommonInkwell(
                      onTap: () {
                        valueProvider.checkovVerificationScenarioFn('email');
                        context.pushReplacementNamed(
                          AppRouter.register,
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
                        text: 'Create an account',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
