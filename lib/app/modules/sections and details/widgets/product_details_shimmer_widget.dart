import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/modules/sections%20and%20details/model/get_product_details_model.dart';
import 'package:zoco/app/modules/sections%20and%20details/model/get_secdtion_homescreen_model.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../../home/widgets/offer_tag_widget.dart';
import '../../review/widgets/revieew_star_list_widget.dart';
import '../../review/widgets/review_widget.dart';
import '../view model/section_provider.dart';
import 'dot_list_widget.dart';
import 'offer_related_product_widget.dart';
import 'product_color_widget.dart';
import 'product_details_expansionTileWidget.dart';
import 'product_details_icon_widget.dart';

class ProductDetailShimmerWidget extends StatelessWidget {
  const ProductDetailShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(0),
                      width: Responsive.width * 100,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: Responsive.width * 100,
                            height: Responsive.height * 32,
                            child: PageView.builder(
                              itemCount: 5,
                              onPageChanged: (value) {},
                              itemBuilder: (context, index) {
                                return const CachedImageWidget(imageUrl: "");
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: OfferTagWidget(
                              offer: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizeBoxH(15),
                    const DotListWidget(
                      productDetailsImages: [],
                      isProductDetails: true,
                    ),
                    const SizeBoxH(15),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidgets(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                text: ""),
                            const Spacer(),
                            const ProductDetailsIconWidget(
                              icon: Icons.share_outlined,
                              iconColor: Colors.transparent,
                            ),
                            const SizeBoxV(8),
                            const ProductDetailsIconWidget(
                              iconColor: Colors.transparent,
                              icon: Icons.favorite_outline,
                            ),
                          ],
                        ),
                      ),
                      CustomTextWidgets(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                          text: ""),
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 15),
                        child: Row(
                          children: [
                            const SizeBoxH(8),
                            SizedBox(
                              height: 20,
                              width: Responsive.width * 30,
                              child: const ReviewStarListWidget(
                                ignoreGestures: true,
                                reviewedColorCount: 0,
                              ),
                            ),
                            const SizeBoxV(5),
                            CustomTextWidgets(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        color: AppConstants
                                            .darkappDiscriptioGreyColor,
                                        fontWeight: FontWeight.w500),
                                text: "${0}"),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        child: CustomTextWidgets(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w700),
                            text: "Select Color"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 60,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return const ProductColorWidget(
                                imgUrl: '',
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizeBoxV(8),
                            itemCount: 0),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidgets(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                text: "Specification"),
                            const SizeBoxH(10),
                            SizedBox(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            top: BorderSide(
                                                color: AppConstants
                                                    .appBorderColor),
                                            bottom: BorderSide(
                                                color: AppConstants
                                                    .appBorderColor))),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 12, top: 12, left: 8),
                                          color: const Color(0xffF1F6FF),
                                          width: Responsive.width * 35,
                                          child: CustomTextWidgets(
                                              overflow: TextOverflow.clip,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              text: ''),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 12, top: 12, left: 8),
                                          width: Responsive.width * 58,
                                          child: CustomTextWidgets(
                                              overflow: TextOverflow.clip,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xff8391A1)),
                                              text: '}'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 15),
                        height: Responsive.height * 8,
                        child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CommonInkwell(
                                onTap: () {},
                                child: Container(
                                  width: Responsive.width * 25,
                                  height: Responsive.height * 8,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: const Color(0xffDCE5F2),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomTextWidgets(
                                        text: '',
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizeBoxH(2),
                                      CustomTextWidgets(
                                        overflow: TextOverflow.ellipsis,
                                        text: "${''} ${''}",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      CustomTextWidgets(
                                        text: "Not Avilable",
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontSize: 8,
                                              color: const Color(0xffFF5353),
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizeBoxV(Responsive.width * 2);
                            },
                            itemCount: 0),
                      ),
                    ]),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTileWidget(
                  isFromBrandInfo: false,
                  onExpansionChanged: (bool expanded) {
                    context
                        .read<SectionProvider>()
                        .checkProductDiscriptionIsExpandedFn();
                  },
                  value: false,
                  title: "RETURN POLICY",
                  subText: '',
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTileWidget(
                  isFromBrandInfo: false,
                  onExpansionChanged: (bool expanded) {
                    context
                        .read<SectionProvider>()
                        .checkProductDiscriptionIsExpandedFn();
                  },
                  value: true,
                  title: "BRAND INFO",
                  subText: '',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextWidgets(
                          text: "Review Product",
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: CustomTextWidgets(
                            text: "See More",
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppConstants.appPrimaryColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: Responsive.width * 30,
                      child: const ReviewStarListWidget(
                        reviewedColorCount: 0,
                        ignoreGestures: true,
                      ),
                    ),
                    const SizeBoxV(5),
                    CustomTextWidgets(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: 12,
                                color: AppConstants.darkappDiscriptioGreyColor,
                                fontWeight: FontWeight.w500),
                        text: " ${0}"),
                    const SizeBoxV(5),
                    CustomTextWidgets(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                                fontSize: 12,
                                color: AppConstants.darkappDiscriptioGreyColor,
                                fontWeight: FontWeight.w500),
                        text: "(${0} Review)"),
                    const Spacer(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: ReviewWidget(
                  review: Review(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidgets(
                      text: "You Might Also Like",
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    const SizeBoxH(15),
                    SizedBox(
                      height: 220,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          return OfferRelatedProductWidget(
                            offer: 0,
                            width: Responsive.width * 44,
                            oneProduct: Product(),
                            index: index,
                            isFrom: "",
                            isFromWhichScreen: "",
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizeBoxV(15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
