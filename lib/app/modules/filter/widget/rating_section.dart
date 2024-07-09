import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../../sections and details/view model/section_provider.dart';
import 'rating_container.dart';

class RatingSectionWidget extends StatelessWidget {
  const RatingSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      height: Responsive.height * 100,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width * 2,
        vertical: Responsive.height * 2,
      ),
      child: Selector<SectionProvider, String>(
        selector: (p0, p1) => p1.rating,
        builder: (context, data, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextWidgets(
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              text: "Customer Reviews",
            ),
            SizeBoxH(Responsive.height * 2),
            RatingContainerWidget(
              onTap: () {
                context.read<SectionProvider>().selecteRatingFn('4');
              },
              count: 4,
              width: Responsive.width * 40,
              borderColor: data == '4'
                  ? const Color(0xff2F4EFF)
                  : const Color(0xFFDCE4F2),
            ),
            SizeBoxH(Responsive.height * 2),
            Row(
              children: [
                RatingContainerWidget(
                  onTap: () {
                    context.read<SectionProvider>().selecteRatingFn('3');
                  },
                  count: 3,
                  width: Responsive.width * 32,
                  borderColor: data == '3'
                      ? const Color(0xff2F4EFF)
                      : const Color(0xFFDCE4F2),
                ),
                SizeBoxV(Responsive.width * 2),
                RatingContainerWidget(
                  onTap: () {
                    context.read<SectionProvider>().selecteRatingFn('2');
                  },
                  count: 2,
                  width: Responsive.width * 25,
                  borderColor: data == '2'
                      ? const Color(0xff2F4EFF)
                      : const Color(0xFFDCE4F2),
                ),
              ],
            ),
            SizeBoxH(Responsive.height * 2),
            RatingContainerWidget(
              onTap: () {
                context.read<SectionProvider>().selecteRatingFn('1');
              },
              count: 1,
              width: Responsive.width * 20,
              borderColor: data == '1'
                  ? const Color(0xff2F4EFF)
                  : const Color(0xFFDCE4F2),
            ),
          ],
        ),
      ),
    );
  }
}
