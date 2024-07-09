import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/theme/theme_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';

import '../../../../helpers/common_widgets.dart';
import '../../../../helpers/sized_box.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/extentions.dart';
import '../../../review/widgets/revieew_star_list_widget.dart';
import '../../../review/widgets/review_widget.dart';
import '../../model/get_product_details_model.dart';
import '../../view model/section_provider.dart';
import '../../widgets/product_color_widget.dart';
import '../../widgets/product_detail_product_image_widget.dart';
import '../../widgets/product_details_also_like_products_widget.dart';
import '../../widgets/product_details_bottom_navigation_bar_widget.dart';
import '../../widgets/product_details_expansionTileWidget.dart';
import '../../widgets/product_details_icon_widget.dart';
import '../../widgets/product_details_shimmer_widget.dart';

class ProductDetailsViewScreen extends StatefulWidget {
  final String? productLink;
  const ProductDetailsViewScreen({
    super.key,
    required this.productLink,
  });

  @override
  State<ProductDetailsViewScreen> createState() =>
      _ProductDetailsViewScreenState();
}

class _ProductDetailsViewScreenState extends State<ProductDetailsViewScreen> {
  late int selectedListIndex;
  late String isFromWhichList;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context
          .read<SectionProvider>()
          .getProductDetailsFun(link: widget.productLink ?? "");

      context.read<SectionProvider>().isProductAddedToCart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        flexibleSpace: Selector<SectionProvider, GetProductDetailsModel>(
          selector: (p0, p1) => p1.getProductDetailsModel,
          builder: (context, value, child) => CustomAppBarWidget(
            isLeadingIconBorder: true,
            title: value.product?.productName ?? '',
            actions: [
              CommonInkwell(
                  onTap: () {
                    context.pushNamed(AppRouter.yourcartscreen);
                  },
                  child: ImageIcon(
                    AssetImage(AppImages.cartIcon),
                  )),
              const SizeBoxV(15)
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Selector<SectionProvider, int>(
          selector: (p0, p1) => p1.getProductDetailsStatus,
          builder: (context, value, child) => value == 0
              ? const ProductDetailShimmerWidget()
              : FadeInLeft(
                  duration: const Duration(milliseconds: 700),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Consumer<SectionProvider>(
                      builder: (context, provider, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProductDetailProductImageWidget(
                              provider: provider,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: Responsive.width * 65,
                                          child: CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              text: provider
                                                      .getProductDetailsModel
                                                      .product
                                                      ?.brandInfo
                                                      ?.name
                                                      ?.trim() ??
                                                  ""),
                                        ),
                                        const Spacer(),
                                        CommonInkwell(
                                          onTap: () => context
                                              .read<FlicksController>()
                                              .shareVideoUrl(
                                                  videoUrl: provider
                                                          .getProductDetailsModel
                                                          .product
                                                          ?.link ??
                                                      '',
                                                  subject: provider
                                                          .getProductDetailsModel
                                                          .product
                                                          ?.productName ??
                                                      ''),
                                          child: ProductDetailsIconWidget(
                                            icon: Icons.share_outlined,
                                            iconColor: context
                                                        .watch<ThemeProvider>()
                                                        .isDarkMode ==
                                                    true
                                                ? AppConstants.white
                                                : Colors.black.withOpacity(.7),
                                          ),
                                        ),
                                        const SizeBoxV(8),
                                        Consumer<HomeProvider>(
                                          builder: (context, providerInstance,
                                                  child) =>
                                              CommonInkwell(
                                            onTap: () {
                                              provider.getProductDetailsModel
                                                          .product?.wishlist ==
                                                      true
                                                  ? providerInstance
                                                      .removeFromWishlistFn(
                                                      productId: provider
                                                              .getProductDetailsModel
                                                              .product
                                                              ?.id ??
                                                          "",
                                                      productDetails: provider
                                                          .getProductDetailsModel
                                                          .product,
                                                      context: context,
                                                      isFrom: "Details",
                                                      isFromWhichList:
                                                          "Details",
                                                    )
                                                  : providerInstance
                                                      .addToWishlistFn(
                                                      productId: provider
                                                              .getProductDetailsModel
                                                              .product
                                                              ?.id ??
                                                          "",
                                                      productDetails: provider
                                                          .getProductDetailsModel
                                                          .product,
                                                      context: context,
                                                      isFrom: "Details",
                                                      isFromWhichList:
                                                          "Details",
                                                    );
                                            },
                                            child: ProductDetailsIconWidget(
                                              icon: provider
                                                          .getProductDetailsModel
                                                          .product
                                                          ?.wishlist ==
                                                      true
                                                  ? Icons.favorite
                                                  : Icons.favorite_outline,
                                              iconColor: provider
                                                          .getProductDetailsModel
                                                          .product
                                                          ?.wishlist ==
                                                      true
                                                  ? Colors.red
                                                  : context
                                                              .watch<
                                                                  ThemeProvider>()
                                                              .isDarkMode ==
                                                          true
                                                      ? Colors.white
                                                      : Colors.black
                                                          .withOpacity(.7),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomTextWidgets(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                    text: provider.getProductDetailsModel
                                            .product?.productName
                                            ?.trim() ??
                                        "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  provider.getProductDetailsModel.product
                                              ?.ratings?.average !=
                                          0
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              top: 8, bottom: 15),
                                          child: Row(
                                            children: [
                                              const SizeBoxH(8),
                                              SizedBox(
                                                child: ReviewStarListWidget(
                                                  ignoreGestures: true,
                                                  reviewedColorCount: provider
                                                          .getProductDetailsModel
                                                          .product
                                                          ?.ratings
                                                          ?.average
                                                          ?.toDouble() ??
                                                      0.0,
                                                ),
                                              ),
                                              const SizeBoxV(8),
                                              CustomTextWidgets(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: AppConstants
                                                              .darkappDiscriptioGreyColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  text:
                                                      "${provider.getProductDetailsModel.product?.ratings?.average ?? 0}"),
                                              const Spacer(),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  provider.getProductDetailsModel.product
                                              ?.variants?.isEmpty ??
                                          true
                                      ? const SizedBox.shrink()
                                      : Container(
                                          margin: const EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                              text: "Select Color"),
                                        ),
                                  provider.getProductDetailsModel.product
                                              ?.variants?.isEmpty ??
                                          true
                                      ? const SizedBox.shrink()
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          height: 60,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                var varient = provider
                                                    .getProductDetailsModel
                                                    .product
                                                    ?.variants?[index];
                                                return ProductColorWidget(
                                                  imgUrl:
                                                      varient?.images?.first ??
                                                          '',
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizeBoxV(8),
                                              itemCount: provider
                                                      .getProductDetailsModel
                                                      .product
                                                      ?.variants
                                                      ?.length ??
                                                  0),
                                        ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 8, bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextWidgets(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                            text: "Specification"),
                                        const SizeBoxH(10),
                                        SizedBox(
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: provider
                                                    .getProductDetailsModel
                                                    .product
                                                    ?.specifications
                                                    ?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              var specificationData = provider
                                                  .getProductDetailsModel
                                                  .product
                                                  ?.specifications?[index];
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10,
                                                              top: 10,
                                                              left: 8),
                                                      width:
                                                          Responsive.width * 35,
                                                      child: CustomTextWidgets(
                                                          overflow:
                                                              TextOverflow.clip,
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                          text:
                                                              specificationData
                                                                      ?.key ??
                                                                  ''),
                                                    ),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10,
                                                              top: 10,
                                                              left: 8),
                                                      width:
                                                          Responsive.width * 58,
                                                      child: CustomTextWidgets(
                                                          overflow: TextOverflow
                                                              .clip,
                                                          textStyle: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: const Color(
                                                                      0xff8391A1)),
                                                          text:
                                                              specificationData
                                                                      ?.value ??
                                                                  ''),
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
                                  Selector<SectionProvider, int>(
                                    selector: (p0, provider) =>
                                        provider.selectedSizeIndex,
                                    builder:
                                        (context, selectedSizevalue, child) =>
                                            Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 15),
                                      height: Responsive.height * 8,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            var sizeData = provider
                                                .getProductDetailsModel
                                                .product
                                                ?.details?[index];
                                            return CommonInkwell(
                                              onTap: () {
                                                if (sizeData?.quantity != 0) {
                                                  provider.isProductAddedToCart =
                                                      false;
                                                  context
                                                      .read<SectionProvider>()
                                                      .selectSizeFun(
                                                          value: index,
                                                          selectedSize:
                                                              sizeData?.id ??
                                                                  "",
                                                          selectedPrice: sizeData
                                                                  ?.price
                                                                  ?.toInt() ??
                                                              0,
                                                          offer: provider
                                                                  .getProductDetailsModel
                                                                  .product
                                                                  ?.offers
                                                                  ?.toInt() ??
                                                              0);
                                                }
                                              },
                                              child: Container(
                                                width: Responsive.width * 25,
                                                height: Responsive.height * 8,
                                                decoration: BoxDecoration(
                                                  color: selectedSizevalue ==
                                                          index
                                                      ? context
                                                              .watch<
                                                                  ThemeProvider>()
                                                              .isDarkMode
                                                          ? const Color(
                                                              0xff8391A1)
                                                          : const Color(
                                                              0xffF1F6FF)
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xffDCE5F2),
                                                  ),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomTextWidgets(
                                                      text:
                                                          sizeData?.size ?? '',
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                    ),
                                                    const SizeBoxH(2),
                                                    CustomTextWidgets(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      text:
                                                          "${provider.getProductDetailsModel.product?.currency ?? ''}  ${((sizeData?.price ?? 0) - ((sizeData?.price ?? 0) * ((provider.getProductDetailsModel.product?.offers ?? 0) / 100))).floor()}",
                                                      textStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                    ),
                                                    sizeData?.quantity == 0
                                                        ? CustomTextWidgets(
                                                            text:
                                                                "Not Avilable",
                                                            textStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                  fontSize: 8,
                                                                  color: const Color(
                                                                      0xffFF5353),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizeBoxV(
                                                Responsive.width * 2);
                                          },
                                          itemCount: provider
                                                  .getProductDetailsModel
                                                  .product
                                                  ?.details
                                                  ?.length ??
                                              0),
                                    ),
                                  ),
                                  Selector<SectionProvider, bool>(
                                    selector: (p0, p1) =>
                                        p1.productDiscriptionIsExpanded,
                                    builder: (context, boolValue, child) =>
                                        Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                      ),
                                      child: ExpansionTileWidget(
                                        onExpansionChanged: (bool expanded) {
                                          context
                                              .read<SectionProvider>()
                                              .checkProductDiscriptionIsExpandedFn();
                                        },
                                        value: boolValue,
                                        title: "PRODUCT DESCRIPTION",
                                        subText: provider.getProductDetailsModel
                                                .product?.description ??
                                            '',
                                        isFromBrandInfo: false,
                                      ),
                                    ),
                                  ),
                                  Selector<SectionProvider, bool>(
                                    selector: (p0, p1) =>
                                        p1.productDiscriptionIsExpanded,
                                    builder: (context, boolValue, child) =>
                                        Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                      ),
                                      child: ExpansionTileWidget(
                                        onExpansionChanged: (bool expanded) {
                                          context
                                              .read<SectionProvider>()
                                              .checkProductDiscriptionIsExpandedFn();
                                        },
                                        value: boolValue,
                                        title: "RETURN POLICY",
                                        subText: provider.getProductDetailsModel
                                                .product?.returnPolicy ??
                                            '',
                                        isFromBrandInfo: false,
                                      ),
                                    ),
                                  ),
                                  Selector<SectionProvider, bool>(
                                    selector: (p0, p1) =>
                                        p1.productDiscriptionIsExpanded,
                                    builder: (context, boolValue, child) =>
                                        Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                      ),
                                      child: ExpansionTileWidget(
                                        imageUrl: provider
                                                .getProductDetailsModel
                                                .product
                                                ?.brandInfo
                                                ?.image ??
                                            '',
                                        onExpansionChanged: (bool expanded) {
                                          context
                                              .read<SectionProvider>()
                                              .checkProductDiscriptionIsExpandedFn();
                                        },
                                        value: boolValue,
                                        title: "BRAND INFO",
                                        subText: provider
                                                .getProductDetailsModel
                                                .product
                                                ?.brandInfo
                                                ?.description ??
                                            '',
                                        isFromBrandInfo: true,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 8, bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomTextWidgets(
                                              text: "Review Product",
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.pushNamed(
                                                    AppRouter.allReviewScreen,
                                                    queryParameters: {
                                                      "productId": provider
                                                              .getProductDetailsModel
                                                              .product
                                                              ?.id ??
                                                          ''
                                                    });
                                              },
                                              child: CustomTextWidgets(
                                                text: "See More",
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppConstants
                                                            .appPrimaryColor),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  provider.getProductDetailsModel.product
                                              ?.ratings?.average ==
                                          0
                                      ? const SizedBox.shrink()
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: Responsive.width * 30,
                                                child: ReviewStarListWidget(
                                                    ignoreGestures: true,
                                                    reviewedColorCount: provider
                                                            .getProductDetailsModel
                                                            .product
                                                            ?.ratings
                                                            ?.average
                                                            ?.toDouble() ??
                                                        0.0),
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
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  text:
                                                      " ${provider.getProductDetailsModel.product?.ratings?.average ?? 0}"),
                                              const SizeBoxV(5),
                                              CustomTextWidgets(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: AppConstants
                                                              .darkappDiscriptioGreyColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                  text:
                                                      "(${provider.getProductDetailsModel.product?.ratings?.count ?? 0} Review)"),
                                              const Spacer(),
                                            ],
                                          ),
                                        ),
                                  provider.getProductDetailsModel.product
                                              ?.reviews?.isEmpty ??
                                          true
                                      ? const SizedBox.shrink()
                                      : Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 15),
                                          child: ReviewWidget(
                                            review: provider
                                                .getProductDetailsModel
                                                .product
                                                ?.reviews
                                                ?.first,
                                          ),
                                        ),
                                  provider.getProductDetailsModel
                                              .relatedProducts?.isEmpty ??
                                          true
                                      ? const SizedBox.shrink()
                                      : ProductDetailsAlsoLikeProductsWidget(
                                          provider: provider,
                                        ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: const ProductDetailsBottomNavigationBarWidget(),
    );
  }
}
