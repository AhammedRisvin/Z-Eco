import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/offer_related_product_widget.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../../helpers/common_widgets.dart';
import '../../../../helpers/sized_box.dart';
import '../../../../utils/app_images.dart';
import '../../model/get_secdtion_homescreen_model.dart';
import '../../view model/section_provider.dart';
import '../../widgets/carousal_slider.dart';
import '../../widgets/casection_home_screen_shimmer_widget.dart';
import '../../widgets/dot_list_widget.dart';

class MobileCatagoryScreen extends StatefulWidget {
  final String? categoryid;
  final String? sectionName;
  const MobileCatagoryScreen({super.key, this.categoryid, this.sectionName});

  @override
  State<MobileCatagoryScreen> createState() => _MobileCatagoryScreenState();
}

class _MobileCatagoryScreenState extends State<MobileCatagoryScreen> {
  @override
  initState() {
    super.initState();

    context
        .read<SectionProvider>()
        .getRecommendedProductsFn(catagoryId: widget.categoryid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: CustomAppBarWidget(
          onTap: () {
            context.read<SectionProvider>().selectCategoryFn(-1);
            context.pop();
          },
          isLeadingIconBorder: true,
          title: widget.sectionName ?? '',
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
                              value.banners?.topBanners?.isEmpty ?? true
                                  ? const SizedBox.shrink()
                                  : Container(
                                      margin: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 10,
                                          bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const CustomTextWidgets(
                                            textStyle: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                            text: "Featured Products",
                                          ),
                                          SizeBoxH(Responsive.height * 1),
                                          const CustomTextWidgets(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff8391A1),
                                            ),
                                            text: "Exciting releases",
                                          ),
                                          SizeBoxH(Responsive.height * 2),
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
                                    ),
                              value.topBrands?.isNotEmpty ?? false
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 10,
                                          bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizeBoxH(15),
                                          const CustomTextWidgets(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            text: "Popular Brands",
                                          ),
                                          const SizeBoxH(15),
                                          SizedBox(
                                            height: value.topBrands
                                                        ?.isNotEmpty ??
                                                    false
                                                ? 60 //Responsive.height * 11.1
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
                                                    height: 60,
                                                    width: 60,
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
                                                        height: 60,
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
                                        ],
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              SizeBoxH(Responsive.height * 3),
                              if (value.topDeals?.isNotEmpty ?? true) ...[
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
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
                                )
                              ],
                              const SizeBoxH(10),
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
                                          itemCount:
                                              value.topDeals?.length ?? 0,
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
                                                    'fromWhichList': "Mobile",
                                                    'selectedListIndex':
                                                        index.toString()
                                                  }),
                                              child: OfferRelatedProductWidget(
                                                width: Responsive.width * 45,
                                                oneProduct: topDealDeatails,
                                                index: index,
                                                isFrom: "Mobiles",
                                                isFromWhichScreen: "Top Deals",
                                              ),
                                            );
                                          }),
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
