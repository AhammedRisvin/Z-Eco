import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/theme/theme_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';

class SettingsWishlistCommonContainer extends StatelessWidget {
  final double width;
  final String image;
  final String title;
  final MainAxisAlignment mainAxis;
  final void Function() onTap;
  const SettingsWishlistCommonContainer({
    super.key,
    required this.width,
    required this.image,
    required this.title,
    this.mainAxis = MainAxisAlignment.start,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        height: Responsive.height * 6.5,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: const Color(0xffDCE5F2),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: mainAxis,
          children: [
            SizeBoxV(Responsive.width * 2),
            Image.asset(
              image,
              height: 20,
              color: context.watch<ThemeProvider>().isDarkMode == true
                  ? const Color(0xffffffff)
                  : const Color(0x33333333),
            ),
            SizeBoxV(Responsive.width * 2),
            CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
              text: title,
            ),
          ],
        ),
      ),
    );
  }
}
