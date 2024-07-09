import 'package:flutter/material.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/extentions.dart';

class RatingContainerWidget extends StatelessWidget {
  final double width;
  final int count;
  final void Function() onTap;
  final Color borderColor;
  const RatingContainerWidget(
      {super.key,
      required this.width,
      required this.count,
      required this.onTap,
      this.borderColor = const Color(0xFFDCE4F2)});

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        width: width,
        height: Responsive.height * 5.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: Responsive.height * 2.5,
                );
              },
              itemCount: count,
            ),
            CustomTextWidgets(
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                  ),
              text: "&UP",
            )
          ],
        ),
      ),
    );
  }
}
