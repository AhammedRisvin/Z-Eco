import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../utils/enums.dart';
import '../../../utils/prefferences.dart';
import 'subscription_screen.dart';

class FlicksScreen extends StatefulWidget {
  const FlicksScreen({
    super.key,
  });

  @override
  State<FlicksScreen> createState() => _FlicksScreenState();
}

class _FlicksScreenState extends State<FlicksScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FlicksController>().createList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<FlicksController>(
          builder: (context, provider, _) {
            return provider.getFlicksSubscriptionModel.flicksMembership
                            ?.isMembership ==
                        true &&
                    provider.isDateExpiredToday(provider
                                .getFlicksSubscriptionModel
                                .flicksMembership
                                ?.expires ??
                            DateTime.now()) ==
                        false
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizeBoxH(Responsive.height * 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                AppImages.flickTextImage,
                                height: 35,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonInkwell(
                                    onTap: () {
                                      context.pushNamed(
                                        AppRouter.flicksSearchScreen,
                                      );
                                    },
                                    child: Image.asset(
                                      AppImages.searchIcon,
                                      height: 30,
                                      color: AppPref.isDark == true
                                          ? AppConstants.white
                                          : AppConstants.black,
                                    ),
                                  ),
                                  SizeBoxV(
                                    Responsive.width * 2,
                                  ),
                                  CommonInkwell(
                                    onTap: () {
                                      context.push(
                                        AppRouter.flicksSettingsScreen,
                                      );
                                    },
                                    child: Image.asset(
                                      AppImages.flicksSettings,
                                      height: 30,
                                      color: AppPref.isDark == true
                                          ? AppConstants.white
                                          : AppConstants.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizeBoxH(Responsive.height * 3),
                        SizedBox(
                          height: Responsive.height * 4.7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: provider.getFlicksHomeScreenModel
                                      .categories?.length ??
                                  0,
                              separatorBuilder: (context, index) {
                                return SizeBoxV(Responsive.width * 3);
                              },
                              itemBuilder: (context, index) {
                                final flicksCatagoryData = provider
                                    .getFlicksHomeScreenModel
                                    .categories?[index];
                                return CommonInkwell(
                                  onTap: () {
                                    provider.getFlicksCatagoryWiseFn(
                                      catagory: flicksCatagoryData?.name ?? "",
                                    );
                                    context.pushNamed(
                                        AppRouter.flixSubCategoryScreen,
                                        queryParameters: {
                                          "title":
                                              flicksCatagoryData?.name ?? "",
                                        });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border: Border.all(
                                          color: AppConstants.appPrimaryColor,
                                        )),
                                    child: Text(
                                      flicksCatagoryData?.name ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: AppConstants.appPrimaryColor,
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                            letterSpacing: 0.25,
                                          ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        provider.getFlicksHomeScreenModel.latestFlicks
                                    ?.isEmpty ==
                                true
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'Latest Flicks',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.25,
                                      ),
                                ),
                              ),
                        provider.getFlicksHomeScreenModel.latestFlicks
                                    ?.isEmpty ==
                                true
                            ? const SizedBox.shrink()
                            : provider.getFlicksHomeScreenStatus ==
                                    GetFlicksHomeScreenStatus.loading
                                ? const Align(
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  )
                                : provider.getFlicksHomeScreenStatus ==
                                        GetFlicksHomeScreenStatus.loaded
                                    ? CarouselSlider.builder(
                                        itemCount: provider
                                            .getFlicksHomeScreenModel
                                            .latestFlicks
                                            ?.length,
                                        itemBuilder:
                                            (context, index, realIndex) {
                                          final flicksData = provider
                                              .getFlicksHomeScreenModel
                                              .latestFlicks?[index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: CommonInkwell(
                                              onTap: () {
                                                provider
                                                    .getFlicksDetailedViewFn(
                                                  flicksId:
                                                      flicksData?.link ?? "",
                                                );
                                                provider.selectedSeasonIndex =
                                                    0;
                                                context.pushNamed(
                                                    AppRouter.videoScreen,
                                                    queryParameters: {
                                                      'productLink':
                                                          flicksData?.link ?? ""
                                                    });
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height:
                                                        Responsive.height * 47,
                                                    width:
                                                        Responsive.width * 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: CachedImageWidget(
                                                      imageUrl:
                                                          flicksData?.banner ??
                                                              "",
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        15,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  provider
                                                                      .handleLibraryFn(
                                                                    context:
                                                                        context,
                                                                    flicksId:
                                                                        flicksData?.id ??
                                                                            "",
                                                                  );
                                                                },
                                                                icon: Column(
                                                                  children: [
                                                                    flicksData?.saved ==
                                                                            true
                                                                        ? Image
                                                                            .asset(
                                                                            AppImages.savedWhite,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            AppImages.saveButton,
                                                                          ),
                                                                    Text(
                                                                      flicksData?.saved ==
                                                                              true
                                                                          ? 'Saved'
                                                                          : 'Save',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              fontSize: 10,
                                                                              color: AppConstants.white),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              CommonButtonWithIcon(
                                                                textColor:
                                                                    AppConstants
                                                                        .white,
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                width: Responsive
                                                                        .width *
                                                                    40,
                                                                height: Responsive
                                                                        .height *
                                                                    6,
                                                                widget: Row(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .play_arrow,
                                                                      color: AppConstants
                                                                          .white,
                                                                    ),
                                                                    Text(
                                                                      'Watch Now',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              color: AppConstants.white),
                                                                    ),
                                                                  ],
                                                                ),
                                                                ontap: () {
                                                                  context.pushNamed(
                                                                      AppRouter
                                                                          .videoPlayerScreen,
                                                                      queryParameters: {
                                                                        "videoUrl":
                                                                            flicksData?.video ??
                                                                                "",
                                                                        "flickId":
                                                                            flicksData?.id ??
                                                                                "",
                                                                        "fromWhere":
                                                                            "network"
                                                                      });
                                                                },
                                                              ),
                                                              IconButton(
                                                                onPressed: () {
                                                                  provider.shareVideoUrl(
                                                                      subject:
                                                                          "any subject",
                                                                      videoUrl:
                                                                          flicksData?.link ??
                                                                              "");
                                                                },
                                                                icon: Column(
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .ios_share_rounded,
                                                                      color: AppConstants
                                                                          .white,
                                                                    ),
                                                                    Text(
                                                                      'Share',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              fontSize: 10,
                                                                              color: AppConstants.white),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizeBoxH(
                                                            Responsive.height *
                                                                1.5)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        options: CarouselOptions(
                                          height: Responsive.height * 48,
                                          autoPlay: true,
                                        ),
                                      )
                                    : const Text("Something went wrong"),
                        provider.getFlicksHomeScreenModel.trendingFlicks
                                    ?.isEmpty ==
                                true
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'Trending',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.25,
                                      ),
                                ),
                              ),
                        provider.getFlicksHomeScreenModel.trendingFlicks
                                    ?.isEmpty ==
                                true
                            ? const SizedBox.shrink()
                            : provider.getFlicksHomeScreenStatus ==
                                    GetFlicksHomeScreenStatus.loading
                                ? SizedBox(
                                    height: Responsive.height * 40,
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : provider.getFlicksHomeScreenStatus ==
                                        GetFlicksHomeScreenStatus.loaded
                                    ? SizedBox(
                                        height: Responsive.height * 40,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: provider
                                                .getFlicksHomeScreenModel
                                                .trendingFlicks
                                                ?.length,
                                            itemBuilder: (context, index) {
                                              final flicksTrendingData =
                                                  provider
                                                      .getFlicksHomeScreenModel
                                                      .trendingFlicks?[index];
                                              return CommonInkwell(
                                                onTap: () {
                                                  context.pushNamed(
                                                    AppRouter.videoScreen,
                                                    queryParameters: {
                                                      'productLink':
                                                          flicksTrendingData
                                                                  ?.link ??
                                                              ""
                                                    },
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Container(
                                                    width:
                                                        Responsive.width * 65,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: CachedImageWidget(
                                                      imageUrl:
                                                          flicksTrendingData
                                                                  ?.banner ??
                                                              "",
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : const Text("Something went wrong"),
                        provider.getFlicksHomeScreenModel.recommendedFlicks
                                    ?.isEmpty ==
                                true
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  'Recommended for you',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 20,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                        letterSpacing: 0.25,
                                      ),
                                ),
                              ),
                        provider.getFlicksHomeScreenModel.recommendedFlicks
                                    ?.isEmpty ==
                                true
                            ? const SizedBox.shrink()
                            : provider.getFlicksHomeScreenStatus ==
                                    GetFlicksHomeScreenStatus.loading
                                ? SizedBox(
                                    height: Responsive.height * 33,
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : provider.getFlicksHomeScreenStatus ==
                                        GetFlicksHomeScreenStatus.loaded
                                    ? SizedBox(
                                        height: Responsive.height * 33,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: provider
                                                .getFlicksHomeScreenModel
                                                .recommendedFlicks
                                                ?.length,
                                            itemBuilder: (context, index) {
                                              final flicksRecommendedData =
                                                  provider
                                                      .getFlicksHomeScreenModel
                                                      .recommendedFlicks?[index];
                                              return CommonInkwell(
                                                onTap: () {
                                                  context.pushNamed(
                                                      AppRouter.videoScreen,
                                                      queryParameters: {
                                                        'productLink':
                                                            flicksRecommendedData
                                                                    ?.link ??
                                                                ""
                                                      });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child: Container(
                                                    width:
                                                        Responsive.width * 46,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: CachedImageWidget(
                                                      imageUrl:
                                                          flicksRecommendedData
                                                                  ?.banner ??
                                                              "",
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : const Text("Something went wrong")
                      ],
                    ),
                  )
                : const SubscriptionScreen();
          },
        ),
      ),
    );
  }
}
