import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';
import '../../vibes/view_model/vibes_provider.dart';
import '../../widgets/view_model/bottom_nav_bar_provider.dart';

class HomeVideosWidget extends StatelessWidget {
  const HomeVideosWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<VibesProvider>(
      builder: (context, provider, child) => provider
                  .getVibesData.vibesData?.isEmpty ??
              true
          ? const SizedBox.shrink()
          : Container(
              margin: const EdgeInsets.only(top: 0, bottom: 10),
              child: provider.getVibesData.vibesData?.isEmpty == true
                  ? const SizedBox.shrink()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWidgets(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 20,
                                    fontFamily: 'Plus Jakarta Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                              text: 'Videos',
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<BottomBarProvider>()
                                    .onItemTapped(index: 1);
                              },
                              child: CustomTextWidgets(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                      color: const Color(0xff2F4EFF),
                                    ),
                                text: 'See more',
                              ),
                            )
                          ],
                        ),
                        const SizeBoxH(10),
                        SizedBox(
                          height: Responsive.height * 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (provider
                                            .getVibesData.vibesData?.length ??
                                        0) >=
                                    10
                                ? 10
                                : provider.getVibesData.vibesData?.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var vibesData =
                                  provider.getVibesData.vibesData?[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  width: Responsive.width * 46,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            vibesData?.imageUrl ?? ""),
                                        onError: (exception, stackTrace) =>
                                            Image.asset(
                                              AppImages.paymentFailed404,
                                              fit: BoxFit.fill,
                                            ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      context.pushNamed(
                                          AppRouter.vibesVideoScreen,
                                          queryParameters: {
                                            "index": index.toString()
                                          });
                                    },
                                    icon: Icon(
                                      Icons.play_circle_filled_rounded,
                                      size: Responsive.radius * 18,
                                      color: AppConstants.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}
