import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/offer_related_product_widget.dart';

import '../../../../helpers/common_widgets.dart';
import '../../../../helpers/router.dart';
import '../../../../helpers/sized_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/extentions.dart';
import '../../../widgets/view/category_circle_widget.dart';
import '../../model/get_secdtion_homescreen_model.dart';
import '../../view model/section_provider.dart';
import '../../widgets/carousal_slider.dart';
import '../../widgets/casection_home_screen_shimmer_widget.dart';
import '../../widgets/category_list_widget.dart';
import '../../widgets/dot_list_widget.dart';
import 'widgets/furniture_list_with_category_product_widget.dart';

class FurnitureCategoryScreen extends StatefulWidget {
  final String? categoryid;
  final String? sectionName;
  const FurnitureCategoryScreen({super.key, this.categoryid, this.sectionName});

  @override
  State<FurnitureCategoryScreen> createState() =>
      _FurnitureCategoryScreenState();
}

class _FurnitureCategoryScreenState extends State<FurnitureCategoryScreen> {
  @override
  initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context
          .read<SectionProvider>()
          .getRecommendedProductsFn(catagoryId: widget.categoryid ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        flexibleSpace: CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: widget.sectionName ?? '',
          onTap: () {
            context.read<SectionProvider>().selectCategoryFn(-1);
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
                                    AppImages.homeNoData)),
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
                                                                              0.090,
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
                              value.banners?.topBanners?.isNotEmpty ?? false
                                  ? Container(
                                      margin: const EdgeInsets.only(bottom: 10),
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
                              value.filteredProducts?.isEmpty ?? false
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var filteredProductsDetails =
                                                value.filteredProducts?[index];
                                            return FurnitureListWithCategoryProductWidget(
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
                                          itemCount:
                                              value.filteredProducts?.length ??
                                                  0,
                                        ),
                                      ),
                                    ),
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
                                                    'fromWhichList':
                                                        "furnitureCatagory",
                                                    'selectedListIndex':
                                                        index.toString()
                                                  }),
                                              child: OfferRelatedProductWidget(
                                                width: Responsive.width * 45,
                                                oneProduct: topDealDeatails,
                                                index: index,
                                                isFrom: "Furniture",
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
