import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/home/model/main_categories_model.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/utils/prefferences.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/extentions.dart';
import '../../sections and details/view model/section_provider.dart';
import '../widgets/home_app_bar_widget.dart';
import '../widgets/home_recomended_products_widget.dart';
import '../widgets/home_screen_shimmer_widget.dart';
import '../widgets/home_sections_widget.dart';
import '../widgets/home_top_selling_products_widget.dart';
import '../widgets/home_videos_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SectionProvider? sectionProvider;
  late bool isSignedIn;

  @override
  void initState() {
    super.initState();
    sectionProvider = context.read<SectionProvider>();
    isSignedIn = AppPref.isSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                leading: const SizedBox.shrink(),
                expandedHeight: 160,
                flexibleSpace: HomeScreenAppBarWidget(isSignedIn: isSignedIn),
                floating: true,
                snap: true,
                pinned: true,
              )
            ];
          },
          body: Selector<HomeProvider, int>(
            selector: (p0, provider) => provider.index,
            builder: (context, value, child) {
              return value != 3
                  ? HomeScreenShimmerWidget()
                  : context.read<HomeProvider>().country.isEmpty
                      ? Center(
                          child: CustomTextWidgets(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 20,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                            text: 'Please select Location',
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<HomeProvider, MainCategories>(
                                selector: (p0, p1) => p1.mainCategories,
                                builder: (context, value, child) => value
                                            .banners?.topBanner?.isEmpty ??
                                        true
                                    ? const SizedBox.shrink()
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            top: 8, bottom: 10),
                                        child: CarouselSlider.builder(
                                          options: CarouselOptions(
                                              height: 170,
                                              aspectRatio: 16 / 9,
                                              viewportFraction: 1,
                                              initialPage: 0,
                                              enableInfiniteScroll: false,
                                              reverse: false,
                                              autoPlay: true,
                                              autoPlayInterval:
                                                  const Duration(seconds: 5),
                                              autoPlayAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 400),
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                              enlargeCenterPage: true,
                                              enlargeFactor: 0,
                                              scrollDirection: Axis.horizontal,
                                              scrollPhysics:
                                                  const ClampingScrollPhysics(),
                                              onPageChanged:
                                                  (index, reason) {}),
                                          itemCount: value
                                                  .banners?.topBanner?.length ??
                                              0,
                                          itemBuilder: (BuildContext context,
                                              int itemIndex,
                                              int pageViewIndex) {
                                            var data = value
                                                .banners?.topBanner?[itemIndex];
                                            return CommonInkwell(
                                              onTap: () =>
                                                  navigateToCategoryScreenBasedOnSectionFn(
                                                      context: context,
                                                      sectionId:
                                                          data?.section?.id ??
                                                              '',
                                                      sectionName:
                                                          data?.section?.name ??
                                                              ''),
                                              child: CachedImageWidget(
                                                imageUrl: data?.image ?? '',
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                height: 170,
                                                width: Responsive.width * 100,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                              const HomeSectionsWidget(),
                              const HomeRecomendedProductsWidget(),
                              const HomeTopSellingProductsWidget(),
                              Selector<HomeProvider, MainCategories>(
                                selector: (p0, p1) => p1.mainCategories,
                                builder: (context, value, child) => value
                                            .banners?.bottomBanner?.isEmpty ??
                                        true
                                    ? const SizedBox.shrink()
                                    : Container(
                                        height: 190,
                                        margin: const EdgeInsets.only(
                                            bottom: 10, top: 0),
                                        child: PageView.builder(
                                          itemCount: value.banners?.bottomBanner
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            var data = value
                                                .banners?.bottomBanner?[index];
                                            return CommonInkwell(
                                              onTap: () =>
                                                  navigateToCategoryScreenBasedOnSectionFn(
                                                      context: context,
                                                      sectionId:
                                                          data?.section?.id ??
                                                              '',
                                                      sectionName:
                                                          data?.section?.name ??
                                                              ''),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 5.0),
                                                  child: CachedImageWidget(
                                                    imageUrl: data?.image ?? '',
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    height: 190,
                                                    width:
                                                        Responsive.width * 100,
                                                  )),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                              const HomeVideosWidget(),
                            ],
                          )),
                        );
            },
          ),
        ),
      ),
    );
  }
}
