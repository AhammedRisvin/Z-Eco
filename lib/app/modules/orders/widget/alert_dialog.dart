import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';

import '../../../helpers/common_widgets.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../view model/order_provider.dart';

class AlertDialogBox extends StatelessWidget {
  const AlertDialogBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.watch<ThemeProvider>().isDarkMode == true
          ? AppConstants.containerColor
          : AppConstants.white,
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      title: CustomTextWidgets(
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
        textAlign: TextAlign.center,
        text: "Are you sure you want to cancel\n your order?",
      ),
      content: CustomTextWidgets(
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
        textAlign: TextAlign.center,
        text:
            "If you cancel now, you may not\n be to avail this deal again.\ndo you still want to cancel",
      ),
      actions: const <Widget>[
        AlertDialogContainer(),
        AlertDialogContainer(isFromConfirm: true),
      ],
    );
  }
}

class AlertDialogContainer extends StatelessWidget {
  final bool isFromConfirm;

  const AlertDialogContainer({
    super.key,
    this.isFromConfirm = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.height * 6,
      width: Responsive.width * 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isFromConfirm
            ? AppConstants.appPrimaryColor
            : context.watch<ThemeProvider>().isDarkMode == true
                ? AppConstants.containerColor
                : AppConstants.white,
        border: Border.all(
          color: AppConstants.appPrimaryColor,
          width: 1,
        ),
      ),
      child: Center(
        child: TextButton(
          onPressed: () {
            if (isFromConfirm == true) {
              context.read<OrderProvider>().canceledOrderFn(
                  bookingId: context
                      .read<OrderProvider>()
                      .orderPrdoct
                      .orderDatas
                      ?.first
                      .bookingId);
              context.pushNamed(AppRouter.returnPaymentSelectingScreen);
            } else {
              context.pop();
            }
          },
          child: CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isFromConfirm
                      ? AppConstants.white
                      : context.watch<ThemeProvider>().isDarkMode == true
                          ? AppConstants.white
                          : AppConstants.black,
                ),
            textAlign: TextAlign.center,
            text: isFromConfirm ? "Yes, Confirm" : "No",
          ),
        ),
      ),
    );
  }
}
