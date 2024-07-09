import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../../widgets/view_model/bottom_nav_bar_provider.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({
    super.key,
  });

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
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
              "assets/images/orderSuccess.png",
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
              text: "  Order placed Successfully ",
            ),
            SizeBoxH(Responsive.height * 2),
            CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF8390A1),
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w400,
                  ),
              text:
                  "Your items has been placed and is\n    on it’s way to being processed",
            ),
            SizeBoxH(Responsive.height * 6),
            CommonButton(
              btnName: "Track order",
              ontap: () {
                context.read<BottomBarProvider>().onItemTapped(index: 3);
                context.pushReplacementNamed(AppRouter.tab);
              },
            ),
            SizeBoxH(Responsive.height * 1),
            TextButton(
              onPressed: () {
                context.pushReplacementNamed(AppRouter.tab);
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
