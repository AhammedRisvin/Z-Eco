import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/review/model/get_review_model.dart';
import 'package:zoco/app/modules/review/view%20model/review_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../utils/app_images.dart';
import '../widgets/review_all_progress_widget.dart';
import '../widgets/review_screen_shimmer_widget.dart';
import '../widgets/review_widget.dart';

class AllReviewScreen extends StatefulWidget {
  final String? productId;
  const AllReviewScreen({super.key, this.productId});

  @override
  State<AllReviewScreen> createState() => _AllReviewScreenState();
}

class _AllReviewScreenState extends State<AllReviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context
          .read<ReviewProvider>()
          .getReviewFun(productId: widget.productId ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: Container(
          color: Colors.amber,
          width: Responsive.width * 100,
          height: 80,
          child: const CustomAppBarWidget(
            isLeadingIconBorder: true,
            title: 'Reviews',
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
        child: Selector<ReviewProvider, int>(
          selector: (p0, p1) => p1.getReviewStatus,
          builder: (context, value, child) => value != 1
              ? const ReviewScreenShimmerWidget()
              : SingleChildScrollView(
                  child: Selector<ReviewProvider, GetReviewsModel>(
                    selector: (p0, provider) => provider.getReviewsModel,
                    builder: (context, value, child) => Column(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomTextWidgets(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.w800),
                                            text:
                                                '${value.totalAvg?.toStringAsFixed(3).substring(0, 3) ?? 0}'),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      // height: 2,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                        text:
                                            '${value.totalReview ?? 0} Reviews')
                                  ],
                                ),
                              ),
                              const VerticalDivider(thickness: 1, width: 5),
                              SizedBox(
                                height: 110,
                                width: Responsive.width * 63,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ReviewProgressWidget(
                                      reviewedColorCount: 5,
                                      progressBarValue: context
                                          .read<ReviewProvider>()
                                          .reviewProgressBar(
                                              value.ratingsCount?.the5 ?? 0),
                                      reviewCount:
                                          value.ratingsCount?.the5 ?? 0,
                                    ),
                                    const SizeBoxH(5),
                                    ReviewProgressWidget(
                                      reviewedColorCount: 4,
                                      progressBarValue: context
                                          .read<ReviewProvider>()
                                          .reviewProgressBar(
                                              value.ratingsCount?.the4 ?? 0),
                                      reviewCount:
                                          value.ratingsCount?.the4 ?? 0,
                                    ),
                                    const SizeBoxH(5),
                                    ReviewProgressWidget(
                                      reviewedColorCount: 3,
                                      progressBarValue: context
                                          .read<ReviewProvider>()
                                          .reviewProgressBar(
                                              value.ratingsCount?.the3 ?? 0),
                                      reviewCount:
                                          value.ratingsCount?.the3 ?? 0,
                                    ),
                                    const SizeBoxH(5),
                                    ReviewProgressWidget(
                                      reviewedColorCount: 2,
                                      progressBarValue: context
                                          .read<ReviewProvider>()
                                          .reviewProgressBar(
                                              value.ratingsCount?.the2 ?? 0),
                                      reviewCount:
                                          value.ratingsCount?.the2 ?? 0,
                                    ),
                                    const SizeBoxH(5),
                                    ReviewProgressWidget(
                                      reviewedColorCount: 1,
                                      progressBarValue: context
                                          .read<ReviewProvider>()
                                          .reviewProgressBar(
                                              value.ratingsCount?.the1 ?? 0),
                                      reviewCount:
                                          value.ratingsCount?.the1 ?? 0,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizeBoxH(20),
                        value.reviews?.isEmpty ?? true
                            ? Center(
                                child: Image.asset(
                                  AppImages.noProductImage,
                                  fit: BoxFit.fill,
                                  height: Responsive.height * 25,
                                  width: Responsive.width * 40,
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.reviews?.length ?? 0,
                                separatorBuilder: (context, index) =>
                                    const SizeBoxH(15),
                                itemBuilder: (context, index) {
                                  var data = value.reviews?[index];
                                  return ReviewWidget(
                                    review: data,
                                  );
                                },
                              )
                      ],
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Selector<ReviewProvider, GetReviewsModel>(
        selector: (p0, provider) => provider.getReviewsModel,
        builder: (context, value, child) => value.hasPurchasedProduct == true
            ? Container(
                height: Responsive.height * 12,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppConstants.appBorderColor,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: CommonButton(
                      btnName: "Write Review",
                      ontap: () {
                        context.pushNamed(AppRouter.writeReviewScreen,
                            queryParameters: {
                              "productId": widget.productId ?? ''
                            });
                      },
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
