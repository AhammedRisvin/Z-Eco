import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/dot_list_widget.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../../../helpers/common_widgets.dart';
import '../../../../../helpers/router.dart';
import '../../../../../helpers/sized_box.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/app_images.dart';
import '../../../../widgets/view/category_circle_widget.dart';
import '../../../model/get_secdtion_homescreen_model.dart';
import '../../../view model/section_provider.dart';
import '../../../widgets/carousal_slider.dart';
import '../../../widgets/casection_home_screen_shimmer_widget.dart';
import '../../../widgets/category_list_widget.dart';
import '../../../widgets/offer_related_product_widget.dart';

class GadgetScreen extends StatefulWidget {
  final String? categoryid;
  const GadgetScreen({super.key, required this.categoryid});

  @override
  State<GadgetScreen> createState() => _GadgetScreenState();
}

class _GadgetScreenState extends State<GadgetScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<SectionProvider>().getRecommendedProductsFn(
          catagoryId: context.read<HomeProvider>().gadgetsSectionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.height * 100,
      width: Responsive.width * 100,
      child: Selector<SectionProvider, int>(
        selector: (p0, p1) => p1.index,
        builder: (context, value, child) => value == 0
            ? const SectionHomeScreenShimmerWidget()
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
                                    AppImages.gadgetNoData)),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              value.categories?.isNotEmpty ?? false
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          top: 20.0, bottom: 5),
                                      child: CategoryListWidget(
                                        categoryid: widget.categoryid,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
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
                                                    duration: const Duration(
                                                        milliseconds: 600),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                                // color: AppConstants.white,
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
                                                                  value, child) =>
                                                              GridView.builder(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          12),
                                                                  shrinkWrap:
                                                                      true,
                                                                  physics:
                                                                      const NeverScrollableScrollPhysics(),
                                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                      childAspectRatio:
                                                                          Responsive.height *
                                                                              0.092,
                                                                      crossAxisSpacing:
                                                                          8,
                                                                      crossAxisCount:
                                                                          4),
                                                                  itemCount: value
                                                                      .fashionSubCatagory
                                                                      .length,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return CategoryCircleTabWidget(
                                                                      name: value
                                                                              .fashionSubCatagory[index]
                                                                              .name ??
                                                                          "",
                                                                      imageUrl: value
                                                                          .fashionSubCatagory[
                                                                              index]
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
                                                                  }),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              value.topBrands?.isNotEmpty ?? false
                                  ? Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // const SizeBoxH(15),
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
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, right: 12),
                                            height: value.topBrands
                                                        ?.isNotEmpty ??
                                                    false
                                                ? 65 //Responsive.height * 11.1
                                                : 0,
                                            child: ListView.separated(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: ((context, index) {
                                                var data =
                                                    value.topBrands?[index];
                                                return CommonInkwell(
                                                  onTap: () {
                                                    context
                                                        .read<SectionProvider>()
                                                        .getIsCategoryOrBrandOrBanner(
                                                            'brand=');
                                                    context.pushNamed(
                                                        AppRouter
                                                            .productListByCategoryScreen,
                                                        queryParameters: {
                                                          'categoryid':
                                                              widget.categoryid,
                                                          'subCategoryId':
                                                              data?.id,
                                                          'categoryname':
                                                              data?.name ?? ''
                                                        });
                                                  },
                                                  child: Container(
                                                    height: 65,
                                                    width: 65,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: Border.all(
                                                        color: const Color(
                                                            0xff8391A1),
                                                      ),
                                                    ),
                                                    child: CachedImageWidget(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        height: 65,
                                                        width:
                                                            Responsive.width *
                                                                100,
                                                        imageUrl: data?.image ??
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
                                                  value.topBrands?.length ?? 0,
                                            ),
                                          ),
                                          // const SizeBoxH(10),
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              value.banners?.topBanners?.isNotEmpty ?? false
                                  ? Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: Column(
                                        children: [
                                          CarousalSliderWidget(
                                            carousalBaanner:
                                                value.banners?.topBanners ?? [],
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
                                                        ?.id,
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
                                            ),
                                          ]
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              value.banners?.bottomBanners?.isNotEmpty ?? false
                                  ? Container(
                                      margin: const EdgeInsets.only(bottom: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 12.0, right: 12),
                                            child: CustomTextWidgets(
                                              textStyle: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              text: "New Trending Smart Watch",
                                            ),
                                          ),
                                          const SizeBoxH(10),
                                          CarousalSliderWidget(
                                            carousalBaanner:
                                                value.banners?.bottomBanners ??
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
                                              carousalBaanner: value
                                                      .banners?.bottomBanners ??
                                                  [],
                                            ),
                                          ]
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              value.topDeals?.isEmpty ?? true
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: CustomTextWidgets(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontSize: 18,
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontWeight: FontWeight.w500,
                                            ),
                                        text: "Top Deals",
                                      ),
                                    ),
                              value.topDeals?.isEmpty ?? true
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio:
                                                    Responsive.height * 0.092,
                                                crossAxisSpacing: 8,
                                                crossAxisCount: 2),
                                        itemCount: value.topDeals?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          var topDealDeatails =
                                              value.topDeals?[index];
                                          return CommonInkwell(
                                            onTap: () => context.pushNamed(
                                                AppRouter
                                                    .productDetailsViewScreen,
                                                queryParameters: {
                                                  'productLink':
                                                      topDealDeatails?.link ??
                                                          '',
                                                  'fromWhichList': "Gadget",
                                                  'selectedListIndex':
                                                      index.toString()
                                                }),
                                            child: OfferRelatedProductWidget(
                                              width: Responsive.width * 45,
                                              oneProduct: topDealDeatails,
                                              index: index,
                                              isFrom: "Gadget",
                                              isFromWhichScreen: "Top Deals",
                                            ),
                                          );
                                        },
                                      ),
                                    )
                            ],
                          ),
                  ),
                ),
              ),
      ),
    );
  }
}
