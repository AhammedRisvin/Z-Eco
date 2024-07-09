import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';
import 'package:zoco/app/modules/flicks/widgets/major_containers.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/enums.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../utils/prefferences.dart';

class VideoScreen extends StatefulWidget {
  final String? productLink;
  const VideoScreen({
    super.key,
    this.productLink,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();

    context.read<FlicksController>().getFlicksDetailedViewFn(
          flicksId: widget.productLink ?? "",
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<FlicksController>(
          builder: (context, provider, child) {
            return provider.getFlicksDetailedViewStatus ==
                    GetFlicksDetailedViewStatus.loading
                ? SizedBox(
                    height: Responsive.height * 100,
                    width: Responsive.width * 100,
                    child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            child: CircularProgressIndicator(
                              color: AppConstants.appPrimaryColor,
                            ),
                          ),
                        ]),
                  )
                : provider.getFlicksDetailedViewStatus ==
                        GetFlicksDetailedViewStatus.loaded
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: Responsive.height * 45,
                            width: Responsive.width * 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  provider.getFlicksDetailedViewModel.flick
                                          ?.banner ??
                                      "",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizeBoxH(Responsive.height * 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.pop();
                                        },
                                        child: const BackgroundContainer(
                                          widget: Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            color: AppConstants.white,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          CommonInkwell(
                                            onTap: () {
                                              provider.handleLibraryFn(
                                                flicksId: provider
                                                        .getFlicksDetailedViewModel
                                                        .flick
                                                        ?.id ??
                                                    '',
                                                context: context,
                                                isFrom: "Details",
                                              );
                                            },
                                            child: BackgroundContainer(
                                              widget: provider
                                                          .getFlicksDetailedViewModel
                                                          .flick
                                                          ?.saved ==
                                                      true
                                                  ? Image.asset(
                                                      AppImages.savedWhite,
                                                    )
                                                  : Image.asset(
                                                      AppImages.saveButton,
                                                    ),
                                            ),
                                          ),
                                          const SizeBoxV(10),
                                          CommonInkwell(
                                            onTap: () {
                                              provider.shareVideoUrl(
                                                videoUrl: provider
                                                        .getFlicksDetailedViewModel
                                                        .flick
                                                        ?.link ??
                                                    "",
                                                subject: "subject",
                                              );
                                            },
                                            child: const BackgroundContainer(
                                              widget: Icon(
                                                Icons.ios_share_rounded,
                                                color: AppConstants.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CommonButtonWithIcon(
                                textColor: AppConstants.white,
                                color: Theme.of(context).primaryColor,
                                ontap: () {
                                  context.pushNamed(AppRouter.videoPlayerScreen,
                                      queryParameters: {
                                        "videoUrl": provider
                                                .getFlicksDetailedViewModel
                                                .flick
                                                ?.video ??
                                            "",
                                        "flickId": provider
                                                .getFlicksDetailedViewModel
                                                .flick
                                                ?.id ??
                                            "",
                                        "fromWhere": "network"
                                      });
                                },
                                widget: Row(
                                  children: [
                                    const Icon(
                                      Icons.play_arrow,
                                      color: AppConstants.white,
                                    ),
                                    const SizeBoxV(5),
                                    Text(
                                      'Watch Now',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppConstants.white),
                                    ),
                                  ],
                                ),
                                height: Responsive.height * 7,
                                width: Responsive.width * 100),
                          ),
                          if (AppPref.flicksDownloadable) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: CommonButtonWithIcon(
                                textColor: AppConstants.black,
                                color: const Color(0xFFDCE4F2),
                                ontap: () {
                                  if (!provider.downloadList.any(
                                      (downloadModel) =>
                                          downloadModel.videoId ==
                                          provider.getFlicksDetailedViewModel
                                              .flick?.id)) {
                                    provider.videoDownload(
                                      context: context,
                                      url: provider.getFlicksDetailedViewModel
                                              .flick?.video ??
                                          "",
                                      img: provider.getFlicksDetailedViewModel
                                              .flick?.banner ??
                                          "",
                                      duration: provider
                                              .getFlicksDetailedViewModel
                                              .flick
                                              ?.duration ??
                                          "",
                                      id: provider.getFlicksDetailedViewModel
                                              .flick?.id ??
                                          "",
                                      name: provider.getFlicksDetailedViewModel
                                              .flick?.name ??
                                          "",
                                      fileSize: provider
                                              .getFlicksDetailedViewModel
                                              .flick
                                              ?.fileSize ??
                                          "",
                                    );
                                  }
                                },
                                widget: ValueListenableBuilder<bool>(
                                  valueListenable:
                                      provider.isDownloadingNotifier,
                                  builder: (context, isDownloading, child) {
                                    if (isDownloading) {
                                      return ValueListenableBuilder<double>(
                                        valueListenable:
                                            provider.progressNotifier,
                                        builder: (context, progress, _) {
                                          return CircularProgressIndicator(
                                            value: progress,
                                            color: AppConstants.black,
                                          );
                                        },
                                      );
                                    } else if (provider.downloadList.any(
                                        (downloadModel) =>
                                            downloadModel.videoId ==
                                            provider.getFlicksDetailedViewModel
                                                .flick?.id)) {
                                      return Row(
                                        children: [
                                          const Icon(
                                            Icons.done,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            'Downloaded',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppConstants.black),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Row(
                                        children: [
                                          const Icon(
                                            Icons.file_download_outlined,
                                            color: AppConstants.black,
                                          ),
                                          Text(
                                            'Download',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppConstants.black),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                height: Responsive.height * 7,
                                width: Responsive.width * 100,
                              ),
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              provider.getFlicksDetailedViewModel.flick?.name ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 19,
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: Responsive.height * 3,
                            child: Row(
                              children: [
                                const SizeBoxV(12),
                                MovieDetailsContainer(
                                  text: provider.getFlicksDetailedViewModel
                                          .flick?.releasedYear ??
                                      "",
                                ),
                                provider.getFlicksDetailedViewModel.flick
                                            ?.ageCategory ==
                                        null
                                    ? const SizedBox.shrink()
                                    : MovieDetailsContainer(
                                        isFirstContainer: true,
                                        text: provider
                                                .getFlicksDetailedViewModel
                                                .flick
                                                ?.ageCategory ??
                                            "",
                                      ),
                                const SizeBoxV(12),
                                Expanded(
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final genreData = provider
                                          .getFlicksDetailedViewModel
                                          .flick
                                          ?.genres?[index];
                                      return MovieDetailsContainer(
                                        text: genreData?.type ?? "",
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizeBoxV(12),
                                    itemCount: provider
                                            .getFlicksDetailedViewModel
                                            .flick
                                            ?.genres
                                            ?.length ??
                                        0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizeBoxH(12),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: SizedBox(
                              child: Text(
                                provider.getFlicksDetailedViewModel.flick
                                        ?.description ??
                                    "",
                                // overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: const Color(0xFF8390A1),
                                      fontSize: 15,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                              ),
                            ),
                          ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final details = provider
                                  .getFlicksDetailedViewModel
                                  .flick
                                  ?.details?[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${details?.key}:',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Plus Jakarta Sans',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Consumer<FlicksController>(
                                      builder: (context, provider, child) {
                                        return Expanded(
                                          child: ReadMoreText(
                                            details?.value ?? "",
                                            trimLines: 1,
                                            colorClickableText:
                                                AppConstants.black,
                                            trimMode: TrimMode.Line,
                                            style: const TextStyle(
                                              color: Color(0xFF8390A1),
                                              fontSize: 15,
                                              fontFamily: 'Plus Jakarta Sans',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                            trimCollapsedText: 'Show more',
                                            trimExpandedText: 'Show less',
                                            moreStyle: const TextStyle(
                                              color: AppConstants.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            lessStyle: const TextStyle(
                                              color: AppConstants.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizeBoxH(2),
                            itemCount: provider.getFlicksDetailedViewModel.flick
                                    ?.details?.length ??
                                0,
                          ),
                          const SizeBoxH(10),
                          provider.getFlicksDetailedViewModel.flick?.seasons
                                      ?.isEmpty ==
                                  true
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  height: Responsive.height * 4.7,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider
                                              .getFlicksDetailedViewModel
                                              .flick
                                              ?.seasons
                                              ?.length ??
                                          0,
                                      separatorBuilder: (context, index) {
                                        return SizeBoxV(Responsive.width * 3);
                                      },
                                      itemBuilder: (context, index) {
                                        final seasonName = provider
                                            .getFlicksDetailedViewModel
                                            .flick
                                            ?.seasons?[index];
                                        final isSelected =
                                            provider.selectedSeasonIndex ==
                                                index;
                                        return CommonInkwell(
                                          onTap: () {
                                            provider.selectSeason(index);
                                            provider.changeSeasonFn(index);
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                color: isSelected
                                                    ? AppConstants
                                                        .appPrimaryColor
                                                    : AppConstants.white,
                                                border: Border.all(
                                                  color: AppConstants
                                                      .appPrimaryColor,
                                                )),
                                            child: Text(
                                              seasonName?.name ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: isSelected
                                                        ? AppConstants.white
                                                        : AppConstants
                                                            .appPrimaryColor,
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
                          provider.getFlicksDetailedViewModel.flick?.seasons
                                      ?.isEmpty ==
                                  true
                              ? const SizedBox.shrink()
                              : SizedBox(
                                  height: Responsive.height * 34,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        provider.flicksEpisodeList.length,
                                    itemBuilder: (context, index) {
                                      final episodeData =
                                          provider.flicksEpisodeList[index];
                                      return OtherSeriesContainer(
                                        singleEpisodeData: episodeData,
                                        flickId: provider
                                            .getFlicksDetailedViewModel
                                            .flick
                                            ?.id,
                                      );
                                    },
                                  ),
                                )
                        ],
                      )
                    : const Text("Something went wrong");
          },
        ),
      ),
    );
  }
}
