import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/view%20model/section_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../../sections and details/model/get_product_details_model.dart';
import 'revieew_star_list_widget.dart';
import 'review_user_captured_product_image_widget.dart';

class ReviewWidget extends StatelessWidget {
  final Review? review;
  const ReviewWidget({super.key, this.review});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width * 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              radius: 35,
              child: CachedImageWidget(
                height: 50,
                width: 50,
                imageUrl: review?.user?.details?.profilePicture ?? "",
                borderRadius: BorderRadius.circular(35),
              ),
            ),
            title: CustomTextWidgets(
                textStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.w800),
                text: review?.user?.name ?? ''),
            subtitle: SizedBox(
                height: 10,
                child: ReviewStarListWidget(
                    ignoreGestures: true,
                    reviewedColorCount: review?.rating?.toDouble() ?? 0.0)),
          ),
          const SizeBoxH(10),
          CustomTextWidgets(
              overflow: TextOverflow.clip,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppConstants.darkappDiscriptioGreyColor),
              text: review?.review ?? ""),
          review?.images?.isEmpty ?? true
              ? const SizedBox.shrink()
              : Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 72,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var reviewData = review?.images?[index];
                        return ReviewUserCaptureProductimageWidget(
                          reviewImage: reviewData ?? '',
                        );
                      },
                      separatorBuilder: (context, index) => const SizeBoxV(10),
                      itemCount: review?.images?.length ?? 0),
                ),
          const SizeBoxH(10),
          CustomTextWidgets(
              overflow: TextOverflow.clip,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppConstants.darkappDiscriptioGreyColor),
              text: context.read<SectionProvider>().convertDateToMontFormate(
                  review?.date.toString() ?? '2023-04-18T12:34:56.789Z')),
          const SizeBoxH(10),
        ],
      ),
    );
  }
}
