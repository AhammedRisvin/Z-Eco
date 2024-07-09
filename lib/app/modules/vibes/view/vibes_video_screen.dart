import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/view%20model/section_provider.dart';
import 'package:zoco/app/modules/vibes/model/get_vibes_model.dart';
import 'package:zoco/app/modules/vibes/view_model/vibes_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../review/widgets/review_user_captured_product_image_widget.dart';

// ignore: must_be_immutable
class VibesVideoScreen extends StatefulWidget {
  String index;

  VibesVideoScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<VibesVideoScreen> createState() => _VibesVideoScreenState();
}

class _VibesVideoScreenState extends State<VibesVideoScreen> {
  late PageController _pageController;
  late ScrollController _scrollController;
  int count = 0;
  @override
  void initState() {
    super.initState();
    int index = int.tryParse(widget.index) ?? 0;

    _pageController = PageController(initialPage: index);
    _scrollController = ScrollController();

    // // Attach scroll listener
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Check if the end of the page is reached
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Call your API function here
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    await Provider.of<VibesProvider>(context, listen: false)
        .getVibesFn(2.toString(), false);
  }

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 35,
            height: 35,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: AssetImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.black,
      body: Consumer<VibesProvider>(
        builder: (context, provider, child) => PageView.builder(
          controller: _pageController,
          itemCount: provider.getVibesData.vibesData?.length ?? 0,
          onPageChanged: (value) {},
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = provider.getVibesData.vibesData?[index];
            return VideoPlayerWidget(
              data: data,
              currency: provider.getVibesData.currency,
              currencySymbol: provider.getVibesData.currencySymbol ?? '',
            );
          },
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
    this.data,
    required this.currency,
    required this.currencySymbol,
  });
  final VibesDatum? data;
  final String? currency;
  final String currencySymbol;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController videoPlayerController;

  bool isLoading = true;
  bool isVideoPlaying = false;
  bool isMuted = false;
  @override
  void initState() {
    super.initState();

    isLoading = true;

    videoPlayerController =
        VideoPlayerController.network(widget.data?.videoUrl ?? "")
          ..initialize().then((_) {
            isLoading = false;
            videoPlayerController.play();
            setState(() {});
          });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: VideoPlayer(videoPlayerController),
        ),
        Column(
          children: [
            const SizeBoxH(50),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: Responsive.height * 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isMuted = !isMuted;

                            videoPlayerController
                                .setVolume(isMuted ? 0.0 : 1.0);
                          });
                        },
                        child: Icon(
                          isMuted ? Icons.volume_off : Icons.volume_up,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      const SizeBoxH(20),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, bottom: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 120,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: widget.data?.products?.length ?? 0,
                              separatorBuilder: (context, index) =>
                                  const SizeBoxV(10),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var suggestedData =
                                    widget.data?.products?[index];

                                return Stack(
                                  children: [
                                    CommonInkwell(
                                      onTap: () {},
                                      child: Container(
                                        height: Responsive.height * 13,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Colors.white.withAlpha(140),
                                                blurRadius: 0.0,
                                                spreadRadius: 0.0,
                                              ),
                                            ],
                                            color:
                                                Colors.white.withOpacity(0.0),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child:
                                                  ReviewUserCaptureProductimageWidget(
                                                reviewImage: suggestedData
                                                        ?.images?.first ??
                                                    "",
                                              ),
                                            ),
                                            SizedBox(
                                              height: 90,
                                              width: Responsive.width * 52,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizeBoxH(2),
                                                  CustomTextWidgets(
                                                      textStyle: Theme.of(
                                                              context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                      text: suggestedData
                                                              ?.productName ??
                                                          ""),
                                                  Row(
                                                    children: [
                                                      CustomTextWidgets(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                          text:
                                                              "${widget.currencySymbol}${suggestedData?.discountPrice?.toStringAsFixed(2) ?? ""} ${widget.currency ?? ''}"),
                                                      const Spacer(),
                                                      CustomTextWidgets(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                          text:
                                                              "Size : ${suggestedData?.size ?? ""}"),
                                                      const SizeBoxV(10)
                                                    ],
                                                  ),
                                                  suggestedData
                                                              ?.discountPrice ==
                                                          suggestedData?.price
                                                      ? const SizedBox.shrink()
                                                      : CustomTextWidgets(
                                                          textStyle:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .lineThrough,
                                                                    decorationThickness:
                                                                        2.5,
                                                                    decorationStyle:
                                                                        TextDecorationStyle
                                                                            .solid,
                                                                    decorationColor:
                                                                        const Color(
                                                                            0xFF8390A1),
                                                                    color: const Color(
                                                                        0xFF8390A1),
                                                                    fontSize:
                                                                        11,
                                                                    fontFamily:
                                                                        'Plus Jakarta Sans',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height: 0,
                                                                  ),
                                                          text:
                                                              '${widget.currencySymbol}${suggestedData?.price?.toStringAsFixed(2) ?? ''} ${widget.currency ?? ''}',
                                                        ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color:
                                                            Color(0xFFFFC732),
                                                      ),
                                                      const SizeBoxV(5),
                                                      CustomTextWidgets(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontSize: 12,
                                                                  color:
                                                                      AppConstants
                                                                          .black,
                                                                  fontFamily:
                                                                      'Plus Jakarta Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  height: 0,
                                                                ),
                                                        text: context
                                                            .read<
                                                                HomeProvider>()
                                                            .formatNumber(
                                                                suggestedData
                                                                        ?.ratings ??
                                                                    0),
                                                      ),
                                                      const Spacer(),
                                                      Consumer<SectionProvider>(
                                                        builder: (context,
                                                                value, child) =>
                                                            GestureDetector(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    VibesProvider>()
                                                                .addToCartFn(
                                                                    context:
                                                                        context,
                                                                    productId:
                                                                        suggestedData?.productId ??
                                                                            "",
                                                                    sizeId:
                                                                        suggestedData?.sizeId ??
                                                                            "");
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 100,
                                                            height: 30,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: AppConstants
                                                                  .appPrimaryColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                'Add To cart',
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      AppConstants
                                                                          .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  height: 0.08,
                                                                  letterSpacing:
                                                                      0.72,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizeBoxV(5)
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    suggestedData?.offers == 0
                                        ? const SizedBox.shrink()
                                        : Positioned(
                                            top: 10,
                                            child: Container(
                                              width: 30,
                                              height: 20,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFDB3022),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(30),
                                                    bottomRight:
                                                        Radius.circular(30),
                                                  ),
                                                ),
                                              ),
                                              child: Center(
                                                child: CustomTextWidgets(
                                                    textStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 0,
                                                        ),
                                                    text:
                                                        "${suggestedData?.offers} %"),
                                              ),
                                            ),
                                          ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizeBoxH(25),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
