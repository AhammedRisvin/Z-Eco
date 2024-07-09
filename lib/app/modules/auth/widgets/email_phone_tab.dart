import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../view_model/auth_provider.dart';

class EmailPhoneTab extends StatelessWidget {
  const EmailPhoneTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Selector<AuthProviders, bool>(
      selector: (p0, p1) => p1.isAuthUsingEmail,
      builder: (context, value, child) => Row(
        children: [
          TextButton(
            style: const ButtonStyle(
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                padding: WidgetStatePropertyAll(EdgeInsets.zero)),
            onPressed: () =>
                context.read<AuthProviders>().changeSignupTypeFn(true),
            child: Column(
              children: [
                CustomTextWidgets(
                  textAlign: TextAlign.start,
                  text: 'Email',
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: value == true
                          ? AppConstants.appPrimaryColor
                          : AppConstants.appMainGreyColor,
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500,
                      height: 0.1),
                ),
                const SizeBoxH(8),
                value == true
                    ? SizedBox(
                        width: 20,
                        child: Divider(
                          color: Theme.of(context).primaryColor,
                          thickness: 1.8,
                        ),
                      )
                    : const SizedBox(
                        height: 20,
                      )
              ],
            ),
          ),
          const SizeBoxV(30),
          TextButton(
            style: const ButtonStyle(
                overlayColor: WidgetStatePropertyAll(Colors.transparent),
                padding: WidgetStatePropertyAll(EdgeInsets.zero)),
            onPressed: () =>
                context.read<AuthProviders>().changeSignupTypeFn(false),
            child: Column(
              children: [
                CustomTextWidgets(
                  text: 'Phone number',
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: value == false
                          ? AppConstants.appPrimaryColor
                          : AppConstants.appMainGreyColor,
                      fontSize: 16,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500,
                      height: 0.1),
                ),
                const SizeBoxH(8),
                value == false
                    ? SizedBox(
                        width: 20,
                        child: Divider(
                          color: Theme.of(context).primaryColor,
                          thickness: 1.8,
                        ),
                      )
                    : const SizedBox(
                        height: 20,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
