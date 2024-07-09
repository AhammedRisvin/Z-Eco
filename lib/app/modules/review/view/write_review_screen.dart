import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/review/view%20model/review_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../widgets/review_user_captured_product_image_widget.dart';

class WriteReviewScreen extends StatefulWidget {
  final String? productId;
  const WriteReviewScreen({super.key, this.productId});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ReviewProvider>().clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: Container(
          color: Colors.amber,
          width: Responsive.width * 100,
          height: 80,
          child: const CustomAppBarWidget(
            isLeadingIconBorder: true,
            title: 'Write Review',
          ),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Divider(
              color: Theme.of(context).dividerTheme.color,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizeBoxH(20),
            CustomTextWidgets(
                overflow: TextOverflow.clip,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                text:
                    "Please write Overall level of satisfacion with your shipping/ Delivery Service"),
            const SizeBoxH(20),
            Selector<ReviewProvider, int>(
              selector: (p0, provider) => provider.selectedRate,
              builder: (context, value, child) => Row(
                children: [
                  CommonInkwell(
                    onTap: () {
                      context.read<ReviewProvider>().updateRate(1);
                    },
                    child: Icon(
                      value >= 1 ? Icons.star : Icons.star_border_outlined,
                      size: 37,
                      color: value >= 1
                          ? AppConstants.reviewStarColor
                          : AppConstants.darkappDiscriptioGreyColor,
                    ),
                  ),
                  const SizeBoxV(5),
                  CommonInkwell(
                    onTap: () {
                      context.read<ReviewProvider>().updateRate(2);
                    },
                    child: Icon(
                      value >= 2 ? Icons.star : Icons.star_border_outlined,
                      size: 37,
                      color: value >= 2
                          ? AppConstants.reviewStarColor
                          : AppConstants.darkappDiscriptioGreyColor,
                    ),
                  ),
                  const SizeBoxV(5),
                  CommonInkwell(
                    onTap: () {
                      context.read<ReviewProvider>().updateRate(3);
                    },
                    child: Icon(
                      value >= 3 ? Icons.star : Icons.star_border_outlined,
                      size: 37,
                      color: value >= 3
                          ? AppConstants.reviewStarColor
                          : AppConstants.darkappDiscriptioGreyColor,
                    ),
                  ),
                  const SizeBoxV(5),
                  CommonInkwell(
                    onTap: () {
                      context.read<ReviewProvider>().updateRate(4);
                    },
                    child: Icon(
                      value >= 4 ? Icons.star : Icons.star_border_outlined,
                      size: 37,
                      color: value >= 4
                          ? AppConstants.reviewStarColor
                          : AppConstants.darkappDiscriptioGreyColor,
                    ),
                  ),
                  const SizeBoxV(5),
                  CommonInkwell(
                    onTap: () {
                      context.read<ReviewProvider>().updateRate(5);
                    },
                    child: Icon(
                      value >= 5 ? Icons.star : Icons.star_border_outlined,
                      size: 37,
                      color: value >= 5
                          ? AppConstants.reviewStarColor
                          : AppConstants.darkappDiscriptioGreyColor,
                    ),
                  ),
                  const SizeBoxV(5),
                  CustomTextWidgets(
                      overflow: TextOverflow.clip,
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                      text: "$value "),
                ],
              ),
            ),
            const SizeBoxH(20),
            CustomTextWidgets(
                overflow: TextOverflow.clip,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                text: "Write Your Review"),
            const SizeBoxH(15),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppConstants.appBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              height: 160,
              child: CustomTextFormFieldWidget(
                maxLines: 8,
                keyboardType: TextInputType.emailAddress,
                controller: context.read<ReviewProvider>().reviewController,
                hintText: 'Write here',
              ),
            ),
            const SizeBoxH(15),
            CustomTextWidgets(
                overflow: TextOverflow.clip,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                text: "Add Photo"),
            const SizeBoxH(15),
            SizedBox(
              height: 72,
              child: Selector<ReviewProvider, int>(
                selector: (p0, p1) => p1.item,
                builder: (context, item, child) =>
                    Selector<ReviewProvider, List<String>>(
                  selector: (p0, p1) => p1.addedImageList,
                  builder: (context, value, child) => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (index < item) {
                          var data = value[index];
                          return ReviewUserCaptureProductimageWidget(
                            reviewImage: data,
                          );
                        } else {
                          return Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppConstants.appBorderColor,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: () {
                                  context
                                      .read<ReviewProvider>()
                                      .addImage(false, context);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  color: AppConstants.appMainGreyColor,
                                  size: 40,
                                )),
                          );
                        }
                      },
                      separatorBuilder: (context, index) => const SizeBoxV(10),
                      itemCount: item + 1),
                ),
              ),
            ),
            const Spacer(),
            CommonButton(
              btnName: "Submit",
              ontap: () {
                context.read<ReviewProvider>().postReviewFn(
                      context: context,
                      productId: widget.productId ?? '',
                    );
              },
            ),
            const SizeBoxH(15)
          ],
        ),
      ),
    );
  }
}
