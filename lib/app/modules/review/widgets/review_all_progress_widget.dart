import 'package:flutter/material.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import 'revieew_star_list_widget.dart';

class ReviewProgressWidget extends StatelessWidget {
  final double reviewedColorCount;
  final double progressBarValue;
  final num reviewCount;
  const ReviewProgressWidget(
      {super.key,
      required this.reviewedColorCount,
      required this.progressBarValue,
      required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
            width: 120,
            child: ReviewStarListWidget(
              reviewedColorCount: reviewedColorCount,
              ignoreGestures: true,
            ),
          ),
          SizedBox(
              width: 90,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: LinearProgressIndicator(
                  color: AppConstants.reviewStarColor,
                  value: progressBarValue,
                ),
              )),
          const SizeBoxV(5),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: CustomTextWidgets(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
                text: '$reviewCount'),
          )
        ],
      ),
    );
  }
}
