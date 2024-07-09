import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/offer_related_list_widget.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/offer_related_product_widget.dart';

import '../../../../helpers/common_widgets.dart';
import '../../../../helpers/router.dart';
import '../../../../helpers/sized_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/extentions.dart';
import '../../../home/widgets/home_screen_shimmer_widget.dart';
import '../../../widgets/view/category_circle_widget.dart';
import '../../model/get_secdtion_homescreen_model.dart';
import '../../view model/section_provider.dart';
import '../../widgets/carousal_slider.dart';
import '../../widgets/category_list_widget.dart';
import '../../widgets/dot_list_widget.dart';

class SectionHomeScreen extends StatefulWidget {
  final String? categoryid;
  final String? sectionName;
  const SectionHomeScreen({super.key, this.categoryid, this.sectionName});

  @override
  State<SectionHomeScreen> createState() => _SectionHomeScreenState();
}

class _SectionHomeScreenState extends State<SectionHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<SectionProvider>()
          .getRecommendedProductsFn(catagoryId: widget.categoryid ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        context.read<SectionProvider>().selectCategoryFn(-1);
        context.read<SectionProvider>().getSectionHomeScreenModel =
            GetSectionHomeModel();
        context.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
          flexibleSpace: CustomAppBarWidget(
            isLeadingIconBorder: true,
            title: widget.sectionName ?? '',
            onTap: () {
              context.read<SectionProvider>().selectCategoryFn(-1);
              context.read<SectionProvider>().getSectionHomeScreenModel =
                  GetSectionHomeModel();
              context.pop();
            },
            actions: [
              CommonInkwell(
                  onTap: () {
                    context.pushNamed(AppRouter.productSearchScreen,
                        queryParameters: {
                          'categoryid': widget.categoryid,
                        });
                    FocusScope.of(context).unfocus();
                  },
                  child: ImageIcon(AssetImage(AppImages.searchIcon))),
              const SizeBoxV(15)
            ],
          ),
        ),
        body: Selector<SectionProvider, int>(
          selector: (p0, p1) => p1.index,
          builder: (context, value, child) => value != 1
              ? HomeScreenShimmerWidget()
              : FadeInLeft(
                  duration: const Duration(milliseconds: 700),
                  child: SingleChildScrollView(
                    child: Selector<SectionProvider, GetSectionHomeModel>(
                      selector: (p0, provider) =>
                          provider.getSectionHomeScreenModel,
                      builder: (context, value, child) => value
                                      .banners?.bottomBanners?.isEmpty ==
                                  true &&
                              value.banners?.topBanners?.isEmpty == true &&
                              value.categories?.isEmpty == true &&
                              value.filteredProducts?.isEmpty == true &&
                              value.topBrands?.isEmpty == true &&
                              value.topDeals?.isEmpty == true
                          ? Padding(
                              padding:
                                  EdgeInsets.only(top: Responsive.height * 20),
                              child: Center(
                                child: Image.asset(
                                    height: Responsive.height * 40,
                                    width: Responsive.width * 50,
                                    widget.sectionName == "Fashion"
                                        ? AppImages.fashionNodata
                                        : widget.sectionName == "Sports"
                                            ? AppImages.sportsNoData
                                            : widget.sectionName ==
                                                    "Personal Care"
                                                ? AppImages.personalCareNoData
                                                : widget.sectionName ==
                                                        "Toys & Baby"
                                                    ? AppImages.toysNoData
                                                    : widget.sectionName ==
                                                            "Grocery"
                                                        ? AppImages
                                                            .groceryNoData
                                                        : widget.sectionName ==
                                                                "Appliances"
                                                            ? AppImages
                                                                .applienceNoData
                                                            : AppImages
                                                                .paymentFailed404),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizeBoxH(10),
                                value.categories?.isNotEmpty ?? false
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 5),
                                        child: CategoryListWidget(
                                          categoryid: widget.categoryid,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                Consumer<SectionProvider>(
                                  builder: (context, value, child) =>
                                      Selector<SectionProvider, bool>(
                                    selector: (p0, provider) =>
                                        provider.isSelectCategory,
                                    builder: (context, value, child) => value
                                        ? Selector<SectionProvider,
                                            List<SubCategory>>(
                                            selector: (p0, provider) =>
                                                provider.fashionSubCatagory,
                                            builder: (context, value, child) =>
                                                value.isNotEmpty
                                                    ? FadeInDown(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    600),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: AppConstants
                                                                        .appBorderColor),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Consumer<
                                                                SectionProvider>(
                                                              builder: (context,
                                                                  value,
                                                                  child) {
                                                                return GridView.builder(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                                                    shrinkWrap: true,
                                                                    physics: const NeverScrollableScrollPhysics(),
                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                        // childAspectRatio: 11 /
                                                                        //     14.8,
                                                                        childAspectRatio: Responsive.height * 0.090,
                                                                        crossAxisSpacing: 8,
                                                                        // mainAxisSpacing:
                                                                        //     8,
                                                                        crossAxisCount: 4),
                                                                    itemCount: value.fashionSubCatagory.length,
                                                                    itemBuilder: (context, index) {
                                                                      return CategoryCircleTabWidget(
                                                                        name: value.fashionSubCatagory[index].name ??
                                                                            "",
                                                                        imageUrl: value
                                                                            .fashionSubCatagory[index]
                                                                            .image,
                                                                        onTap:
                                                                            () {
                                                                          context
                                                                              .read<SectionProvider>()
                                                                              .getIsCategoryOrBrandOrBanner('category=');
                                                                          context.pushNamed(
                                                                              AppRouter.productListByCategoryScreen,
                                                                              queryParameters: {
                                                                                'categoryid': widget.categoryid,
                                                                                'subCategoryId': value.fashionSubCatagory[index].id ?? "",
                                                                                'categoryname': value.fashionSubCatagory[index].name ?? ''
                                                                              });
                                                                        },
                                                                      );
                                                                    });
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox.shrink(),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ),
                                value.banners?.topBanners?.isNotEmpty ?? false
                                    ? Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Column(
                                          children: [
                                            CarousalSliderWidget(
                                              carousalBaanner:
                                                  value.banners?.topBanners ??
                                                      [],
                                              onTap: () {
                                                context
                                                    .read<SectionProvider>()
                                                    .getIsCategoryOrBrandOrBanner(
                                                        'topBanners=');
                                                context.pushNamed(
                                                    AppRouter
                                                        .productListByCategoryScreen,
                                                    queryParameters: {
                                                      'categoryid':
                                                          widget.categoryid,
                                                      'subCategoryId': value
                                                              .banners!
                                                              .topBanners?[context
                                                                  .read<
                                                                      SectionProvider>()
                                                                  .curserIndex]
                                                              .category
                                                              ?.id ??
                                                          '',
                                                      'categoryname': value
                                                              .banners!
                                                              .topBanners?[context
                                                                  .read<
                                                                      SectionProvider>()
                                                                  .curserIndex]
                                                              .category
                                                              ?.name ??
                                                          ''
                                                    });
                                              },
                                            ),
                                            const SizeBoxH(10),
                                            if ((value.banners?.topBanners
                                                        ?.length ??
                                                    0) >
                                                1) ...[
                                              DotListWidget(
                                                carousalBaanner:
                                                    value.banners?.topBanners ??
                                                        [],
                                              )
                                            ]
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                value.topBrands?.isNotEmpty ?? false
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 12.0, right: 12),
                                              child: CustomTextWidgets(
                                                textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                text: "Popular Brands",
                                              ),
                                            ),
                                            const SizeBoxH(15),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: SizedBox(
                                                height: 60,
                                                child: ListView.separated(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    var data =
                                                        value.topBrands?[index];
                                                    return CommonInkwell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                SectionProvider>()
                                                            .getIsCategoryOrBrandOrBanner(
                                                                'brand=');
                                                        context.pushNamed(
                                                            AppRouter
                                                                .productListByCategoryScreen,
                                                            queryParameters: {
                                                              'categoryid': widget
                                                                  .categoryid,
                                                              'subCategoryId':
                                                                  data?.id ??
                                                                      '',
                                                              'categoryname':
                                                                  data?.name ??
                                                                      '',
                                                              'isBrand': 'true'
                                                            });
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xff8391A1),
                                                          ),
                                                        ),
                                                        child: CachedImageWidget(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            height: 60,
                                                            width: Responsive
                                                                    .width *
                                                                100,
                                                            imageUrl: data
                                                                    ?.image ??
                                                                "https://blogger.googleusercontent.com/img/a/AVvXsEhUeiRmvP33IgmhAffdiFwHOqweHsFyOW12IoM2sXmU9ZxgzD1hra9-awcHXaF8aL5UZzg6Aa_R_JIde1_ZI-liUkc1UzD2fQYWvUzF7tPX4oyyNxkyGd0jM5_cG_QbA328a_eYs2PN9BCpQRXVEBVrG83lX-I6VrOTvkRfx666VJap6F4AbZakPJioul2y=w640-h192"),
                                                      ),
                                                    );
                                                  }),
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizeBoxV(
                                                        Responsive.width * 4);
                                                  },
                                                  itemCount:
                                                      value.topBrands?.length ??
                                                          0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                value.banners?.bottomBanners?.isNotEmpty ??
                                        false
                                    ? Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 15),
                                        child: Column(
                                          children: [
                                            CarousalSliderWidget(
                                              carousalBaanner: value
                                                      .banners?.bottomBanners ??
                                                  [],
                                              onTap: () {
                                                context
                                                    .read<SectionProvider>()
                                                    .getIsCategoryOrBrandOrBanner(
                                                        'bottomBanners=');
                                                context.pushNamed(
                                                    AppRouter
                                                        .productListByCategoryScreen,
                                                    queryParameters: {
                                                      'categoryid':
                                                          widget.categoryid,
                                                      'subCategoryId': value
                                                          .banners!
                                                          .bottomBanners?[context
                                                              .read<
                                                                  SectionProvider>()
                                                              .curserIndex]
                                                          .category
                                                          ?.id,
                                                      'categoryname': value
                                                              .banners!
                                                              .bottomBanners?[context
                                                                  .read<
                                                                      SectionProvider>()
                                                                  .curserIndex]
                                                              .category
                                                              ?.name ??
                                                          ''
                                                    });
                                              },
                                            ),
                                            const SizeBoxH(10),
                                            if ((value.banners?.bottomBanners
                                                        ?.length ??
                                                    0) >
                                                1) ...[
                                              DotListWidget(
                                                carousalBaanner: value.banners
                                                        ?.bottomBanners ??
                                                    [],
                                              ),
                                            ]
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                value.filteredProducts?.isEmpty ?? true
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0, right: 12),
                                        child: SizedBox(
                                          child: ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var filteredProductsDetails =
                                                  value
                                                      .filteredProducts?[index];
                                              return OfferRelatedProductListWidget(
                                                sectionName: widget.sectionName,
                                                offer: filteredProductsDetails
                                                    ?.offer,
                                                relatedProducts:
                                                    filteredProductsDetails
                                                        ?.products,
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const SizeBoxH(5);
                                            },
                                            itemCount: value
                                                    .filteredProducts?.length ??
                                                0,
                                          ),
                                        ),
                                      ),
                                value.topDeals?.isEmpty ?? true
                                    ? const SizedBox.shrink()
                                    : Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomTextWidgets(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'Plus Jakarta Sans',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                  text: "Top Deals",
                                                ),
                                                const SizeBoxH(15),
                                                GridView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisSpacing: 8,
                                                            childAspectRatio:
                                                                Responsive
                                                                        .height *
                                                                    0.095,
                                                            crossAxisCount: 2),
                                                    itemCount: value
                                                            .topDeals?.length ??
                                                        0,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var topDealDeatails =
                                                          value
                                                              .topDeals?[index];
                                                      return CommonInkwell(
                                                        onTap: () => context
                                                            .pushNamed(
                                                                AppRouter
                                                                    .productDetailsViewScreen,
                                                                queryParameters: {
                                                              'productLink':
                                                                  topDealDeatails
                                                                          ?.link ??
                                                                      '',
                                                              'fromWhichList':
                                                                  "section Main Top deals",
                                                              'selectedListIndex':
                                                                  index
                                                                      .toString()
                                                            }),
                                                        child: Consumer<
                                                            SectionProvider>(
                                                          builder: (context,
                                                                  value,
                                                                  child) =>
                                                              OfferRelatedProductWidget(
                                                            width: Responsive
                                                                    .width *
                                                                45,
                                                            oneProduct:
                                                                topDealDeatails,
                                                            index: index,
                                                            isFrom:
                                                                "SectionHomeScreen",
                                                            isFromWhichScreen:
                                                                "Top Deals",
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
