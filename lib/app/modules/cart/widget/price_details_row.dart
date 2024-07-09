import 'package:flutter/material.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/app_constants.dart';

class PriceDetailsRowWidget extends StatelessWidget {
  final String title;
  final String price;
  final Color? titleColor;
  const PriceDetailsRowWidget({
    super.key,
    required this.title,
    required this.price,
    this.titleColor = AppConstants.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextWidgets(
          textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
          text: title,
        ),
        CustomTextWidgets(
          textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
          text: price,
        ),
      ],
    );
  }
}
