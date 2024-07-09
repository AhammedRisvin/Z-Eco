import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import 'review_all_progress_widget.dart';
import 'review_widget.dart';

class ReviewScreenShimmerWidget extends StatelessWidget {
  const ReviewScreenShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 110,
                width: Responsive.width * 100,
                child: Row(
                  children: [
                    SizedBox(
                      height: 110,
                      width: Responsive.width * 28,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextWidgets(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800),
                                  text: '4.6'),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CustomTextWidgets(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 14,
                                            // height: 2,
                                            fontWeight: FontWeight.w400),
                                    text: '/5'),
                              )
                            ],
                          ),
                          CustomTextWidgets(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                              text: '86 Reviews')
                        ],
                      ),
                    ),
                    const VerticalDivider(thickness: 1, width: 5),
                    SizedBox(
                      height: 110,
                      width: Responsive.width * 63,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReviewProgressWidget(
                            reviewedColorCount: 5,
                            progressBarValue: 1,
                            reviewCount: 10,
                          ),
                          SizeBoxH(5),
                          ReviewProgressWidget(
                            reviewedColorCount: 5,
                            progressBarValue: 1,
                            reviewCount: 10,
                          ),
                          SizeBoxH(5),
                          ReviewProgressWidget(
                            reviewedColorCount: 5,
                            progressBarValue: 1,
                            reviewCount: 10,
                          ),
                          SizeBoxH(5),
                          ReviewProgressWidget(
                            reviewedColorCount: 5,
                            progressBarValue: 1,
                            reviewCount: 10,
                          ),
                          SizeBoxH(5),
                          ReviewProgressWidget(
                            reviewedColorCount: 5,
                            progressBarValue: 1,
                            reviewCount: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizeBoxH(20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 7,
                separatorBuilder: (context, index) => const SizeBoxH(15),
                itemBuilder: (context, index) {
                  return const ReviewWidget();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
