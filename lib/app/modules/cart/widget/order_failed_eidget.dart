import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';

class OrderFailedScreen extends StatefulWidget {
  const OrderFailedScreen({
    super.key,
  });

  @override
  State<OrderFailedScreen> createState() => _OrderFailedScreenState();
}

class _OrderFailedScreenState extends State<OrderFailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        color: context.watch<ThemeProvider>().isDarkMode == true
            ? AppConstants.black
            : Colors.white,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 10),
            Image.asset(
              AppImages.paymentFailed404,
              height: Responsive.height * 45,
              width: Responsive.width * 90,
            ),
            CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 24,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
              text: "OOPS!! Your\nOrder is failed",
            ),
            SizeBoxH(Responsive.height * 2),
            CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF8390A1),
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w400,
                  ),
              text: "Something went wrong!!",
            ),
            SizeBoxH(Responsive.height * 6),
            CommonButton(
              btnName: "Try again",
              ontap: () {
                context.pushNamed(AppRouter.yourcartscreen);
              },
            ),
            SizeBoxH(Responsive.height * 1),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRouter.tab);
              },
              child: CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                text: "Back to Home",
              ),
            )
          ],
        ),
      ),
    );
  }
}
