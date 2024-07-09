import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/model/get_deals_model.dart';
import 'package:zoco/app/modules/sections%20and%20details/view%20model/section_provider.dart';
import 'package:zoco/app/theme/theme_provider.dart';

import '../../../../helpers/common_widgets.dart';
import '../../../../helpers/router.dart';
import '../../../../helpers/sized_box.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/extentions.dart';
import '../../../widgets/view/category_circle_widget.dart';
import 'widgets/deals_shimmer_widget.dart';
import 'widgets/product_card_widgets.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({
    super.key,
  });

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  @override
  initState() {
    super.initState();
    context.read<SectionProvider>().getDealsFun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: 'Deals',
          actions: [],
        ),
      ),
      body: Container(
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Selector<SectionProvider, int>(
          selector: (p0, p1) => p1.getDealsFunStatus,
          builder: (context, value, child) => value != 1
              ? const DealsShimmerWidget()
              : FadeInLeft(
                  duration: const Duration(milliseconds: 700),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Selector<SectionProvider, GetDealsModel>(
                      selector: (p0, provider) => provider.getDealsModel,
                      builder: (context, value, child) => value
                                      .bigSavings?.isEmpty ==
                                  true &&
                              value.dealsBanner?.isEmpty == true &&
                              value.sections?.isEmpty == true &&
                              value.recommendedProducts?.isEmpty == true &&
                              value.specialDeals?.isEmpty == true
                          ? Padding(
                              padding:
                                  EdgeInsets.only(top: Responsive.height * 20),
                              child: Center(
                                  child: Image.asset(
                                      height: Responsive.height * 40,
                                      width: Responsive.width * 50,
                                      AppImages.dealsNoData)),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                value.dealsBanner?.isNotEmpty ?? false
                                    ? SizedBox(
                                        height: Responsive.height * 22,
                                        width: Responsive.width * 100,
                                        child: PageView.builder(
                                          itemCount:
                                              value.dealsBanner?.length ?? 0,
                                          onPageChanged: (value) {
                                            context
                                                .read<SectionProvider>()
                                                .nextPage(value);
                                          },
                                          itemBuilder: (context, index) {
                                            var image =
                                                value.dealsBanner?[index];
                                            return CachedImageWidget(
                                                imageUrl: image?.image ?? "");
                                          },
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                value.sections?.isNotEmpty ?? false
                                    ? Container(
                                        margin: EdgeInsets.only(
                                            top: Responsive.height * 2.5),
                                        child: SingleChildScrollView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomTextWidgets(
                                                  textStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                  text: 'Trendy Offers'),
                                              CustomTextWidgets(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: context
                                                                  .read<
                                                                      ThemeProvider>()
                                                                  .isDarkMode ==
                                                              true
                                                          ? const Color(
                                                              0xff72787e)
                                                          : const Color(
                                                              0x99000000),
                                                      fontSize: 12,
                                                      fontFamily: AppConstants
                                                          .fontFamily,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 0,
                                                    ),
                                                text: 'Super summer sale',
                                              ),
                                              SizeBoxH(Responsive.height * 2),
                                              GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio:
                                                      Responsive.height * 0.085,
                                                  crossAxisCount: 5,
                                                  crossAxisSpacing: 8,
                                                ),
                                                itemCount:
                                                    value.sections?.length ?? 0,
                                                itemBuilder: (context, index) {
                                                  return CategoryCircleTabWidget(
                                                    imageUrl: value
                                                        .sections?[index].image,
                                                    name: value.sections?[index]
                                                            .name ??
                                                        '',
                                                    radius: 30,
                                                    onTap: () {
                                                      navigateToCategoryScreenBasedOnSectionFn(
                                                          context: context,
                                                          sectionId: value
                                                                  .sections?[
                                                                      index]
                                                                  .id ??
                                                              '',
                                                          sectionName: value
                                                                  .sections?[
                                                                      index]
                                                                  .name ??
                                                              '');
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                value.recommendedProducts?.isEmpty ?? true
                                    ? const SizedBox.shrink()
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: Responsive.height * 2.5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                              text: 'Recommended',
                                            ),
                                            const SizeBoxH(5),
                                            CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: context
                                                                .read<
                                                                    ThemeProvider>()
                                                                .isDarkMode ==
                                                            true
                                                        ? const Color(
                                                            0xff72787e)
                                                        : const Color(
                                                            0x99000000),
                                                    fontSize: 12,
                                                    fontFamily:
                                                        AppConstants.fontFamily,
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                              text: 'Recommended deals for you',
                                            ),
                                            SizeBoxH(Responsive.height * 2),
                                            SizedBox(
                                              height: 250,
                                              child: ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: value
                                                        .recommendedProducts
                                                        ?.length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  var data = value
                                                          .recommendedProducts?[
                                                      index];
                                                  return DealsProductWidget(
                                                      onTap: () =>
                                                          context.pushNamed(
                                                              AppRouter
                                                                  .productDetailsViewScreen,
                                                              queryParameters: {
                                                                'productLink':
                                                                    data?.link ??
                                                                        '',
                                                              }),
                                                      index: index,
                                                      productModel: data,
                                                      width: Responsive.width *
                                                          44);
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const SizeBoxV(15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                CustomTextWidgets(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        fontSize: 20,
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                  text: 'Mega Savings',
                                ),
                                const SizeBoxH(5),
                                CustomTextWidgets(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: context
                                                    .read<ThemeProvider>()
                                                    .isDarkMode ==
                                                true
                                            ? const Color(0xff72787e)
                                            : const Color(0x99000000),
                                        fontSize: 12,
                                        fontFamily: AppConstants.fontFamily,
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                  text: 'Get the biggest discount',
                                ),
                                const SizeBoxH(27),
                                SizedBox(
                                  height: Responsive.height * 13,
                                  child: Row(
                                    children: [
                                      CommonInkwell(
                                          onTap: () => context
                                              .read<SectionProvider>()
                                              .getDealsOfferProductFn(
                                                  offer: '20',
                                                  context: context),
                                          child: SizedBox(
                                              child:
                                                  megaOffer(context, '20%'))),
                                      const SizeBoxV(10),
                                      CommonInkwell(
                                          onTap: () => context
                                              .read<SectionProvider>()
                                              .getDealsOfferProductFn(
                                                  offer: '50',
                                                  context: context),
                                          child: SizedBox(
                                              child:
                                                  megaOffer(context, '50%'))),
                                      const SizeBoxV(10),
                                      CommonInkwell(
                                          onTap: () => context
                                              .read<SectionProvider>()
                                              .getDealsOfferProductFn(
                                                  offer: '80',
                                                  context: context),
                                          child: SizedBox(
                                              child:
                                                  megaOffer(context, '80%'))),
                                    ],
                                  ),
                                ),
                                value.specialDeals?.isEmpty ?? true
                                    ? const SizedBox.shrink()
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: Responsive.height * 3),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                              text: 'Special Deals',
                                            ),
                                            SizeBoxH(Responsive.height * 2),
                                            SizedBox(
                                              height: 200,
                                              child: ListView.separated(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: value
                                                        .specialDeals?.length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  var data = value
                                                      .specialDeals?[index];
                                                  return DealsProductWidget(
                                                      onTap: () {
                                                        context.pushNamed(
                                                            AppRouter
                                                                .productDetailsViewScreen,
                                                            queryParameters: {
                                                              'productLink':
                                                                  data?.link ??
                                                                      '',
                                                            });
                                                      },
                                                      index: index,
                                                      productModel: data,
                                                      isSpecialDeal: true,
                                                      width: Responsive.width *
                                                          44);
                                                },
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const SizeBoxV(15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                value.bigSavings?.isEmpty ?? true
                                    ? const SizedBox.shrink()
                                    : Container(
                                        margin: EdgeInsets.only(
                                            top: Responsive.height * 2),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomTextWidgets(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'Plus Jakarta Sans',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0,
                                                  ),
                                              text: ' Big Saving For You',
                                            ),
                                            SizeBoxH(Responsive.height * 2),
                                            GridView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio:
                                                    Responsive.height * 0.092,
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 8,
                                              ),
                                              itemCount:
                                                  value.bigSavings?.length ?? 0,
                                              itemBuilder: (context, index) {
                                                var data =
                                                    value.bigSavings?[index];
                                                return DealsProductWidget(
                                                  onTap: () => context.pushNamed(
                                                      AppRouter
                                                          .productDetailsViewScreen,
                                                      queryParameters: {
                                                        'productLink':
                                                            data?.link ?? '',
                                                      }),
                                                  index: index,
                                                  productModel: data,
                                                  bigsavingyou: true,
                                                );
                                              },
                                            ),
                                          ],
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

  megaOffer(context, String offer) {
    return Container(
      width: Responsive.width * 28,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF61B9EB),
            Color(0xFF4C7DC8),
          ],
          stops: [0.0, 1.0],
          transform: GradientRotation(49.14 * 3.141592653589793 / 180),
        ),
      ),
      child: Column(
        children: [
          SizeBoxH(Responsive.height * 2),
          CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: AppConstants.fontFamily,
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
            text: offer,
          ),
          CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: AppConstants.fontFamily,
                  fontWeight: FontWeight.w900,
                  height: 0,
                ),
            text: 'OFF',
          ),
          SizeBoxH(Responsive.height * 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 0,
                ),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(8))),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
