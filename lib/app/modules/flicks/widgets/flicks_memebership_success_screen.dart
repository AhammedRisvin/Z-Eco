import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';

class FlicksSubSuccessScreen extends StatefulWidget {
  const FlicksSubSuccessScreen({
    super.key,
  });

  @override
  State<FlicksSubSuccessScreen> createState() => _FlicksSubSuccessScreenState();
}

class _FlicksSubSuccessScreenState extends State<FlicksSubSuccessScreen> {
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
              text: "Flicks Subscribed Successfully",
            ),
            SizeBoxH(Responsive.height * 2),
            CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF8390A1),
                    fontSize: 16,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w400,
                  ),
              text: "Enjoy the flicks",
            ),
            SizeBoxH(Responsive.height * 6),
            TextButton(
              onPressed: () {
                context.pushReplacement(AppRouter.tab);
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
