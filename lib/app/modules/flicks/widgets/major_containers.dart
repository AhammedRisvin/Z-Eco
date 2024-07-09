import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../model/get_flicks_detailed_view_model.dart';

class OtherSeriesContainer extends StatelessWidget {
  final Episode? singleEpisodeData;
  final String? flickId;
  const OtherSeriesContainer({
    super.key,
    this.singleEpisodeData,
    this.flickId,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: () {
        context.pushNamed(AppRouter.videoPlayerScreen, queryParameters: {
          "videoUrl": singleEpisodeData?.video ?? "",
          "flickId": flickId ?? "",
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: Responsive.width * 65,
        padding: const EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: Responsive.width * 60,
              height: 120,
              child: CachedImageWidget(
                imageUrl: singleEpisodeData?.thumbnail ?? "",
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(height: 13),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                singleEpisodeData?.genres?.isEmpty == true
                    ? const SizedBox.shrink()
                    : SizedBox(
                        height: 10,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: singleEpisodeData?.genres?.length ?? 0,
                          separatorBuilder: (context, index) =>
                              const SizeBoxV(5),
                          itemBuilder: (context, index) {
                            final genreName = singleEpisodeData?.genres?[index];
                            return Text(
                              genreName ?? "",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: const Color(0xFF8390A1),
                                    fontSize: 10,
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                            );
                          },
                        ),
                      ),
                const SizedBox(height: 6),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(singleEpisodeData?.name ?? "aaa",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontFamily: 'Plus Jakarta Sans',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: -0.5)),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: Responsive.width * 60,
                      child: Text(
                        singleEpisodeData?.description ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF8390A1),
                              fontSize: 12,
                              fontFamily: 'Plus Jakarta Sans',
                              fontWeight: FontWeight.w500,
                              height: 0,
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
    );
  }
}

class MovieDetailsContainer extends StatelessWidget {
  final String text;
  final bool isFirstContainer;
  const MovieDetailsContainer({
    super.key,
    required this.text,
    this.isFirstContainer = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin:
          isFirstContainer ? const EdgeInsets.only(left: 12) : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: const Color(0xFF8390A1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppConstants.white,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: 0.25,
            ),
      ),
    );
  }
}

class BackgroundContainer extends StatelessWidget {
  final Widget widget;
  const BackgroundContainer({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.4000000059604645),
      ),
      child: widget,
    );
  }
}
