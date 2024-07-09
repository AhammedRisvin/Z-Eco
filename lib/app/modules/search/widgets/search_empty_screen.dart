import 'package:flutter/material.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../utils/app_images.dart';

class SearchEmptyScreen extends StatelessWidget {
  const SearchEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizeBoxH(Responsive.height * 16),
          Image.asset(AppImages.productNotFound),
          CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
              text: 'Product Not Found'),
          SizeBoxH(Responsive.height * 2.2),
          CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w400,
                    height: 0,
                    color: const Color(0xFF8390A1),
                  ),
              text: 'thank you for shopping using app'),
          SizeBoxH(Responsive.height * 2),
          CommonButton(btnName: 'Back to Home', ontap: () {})
        ],
      ),
    );
  }
}
