import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../utils/app_images.dart';
import '../../../utils/enums.dart';
import '../view_model/flicks_controller.dart';

class FlicksSubCategoryScreen extends StatefulWidget {
  final String title;
  const FlicksSubCategoryScreen({
    super.key,
    required this.title,
  });

  @override
  State<FlicksSubCategoryScreen> createState() =>
      _FlicksSubCategoryScreenState();
}

class _FlicksSubCategoryScreenState extends State<FlicksSubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppImages.flickTextImage,
          height: 35,
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: 0.25,
                    ),
              ),
            ),
            Consumer<FlicksController>(
              builder: (context, provider, child) => provider
                          .flicksCatagoryModel.flicks?.isEmpty ==
                      true
                  ? Text("no ${widget.title} available")
                  : SizedBox(
                      height: Responsive.height * 100,
                      width: Responsive.width * 100,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.flicksCatagoryModel.flicks?.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          childAspectRatio: .95,
                        ),
                        itemBuilder: (context, index) {
                          var catagoryData =
                              provider.flicksCatagoryModel.flicks?[index];
                          return CommonInkwell(
                            onTap: () {
                              context.pushNamed(AppRouter.videoScreen,
                                  queryParameters: {
                                    "productLink": catagoryData?.link ?? "",
                                  });
                            },
                            child: provider.getFlicksCatagoryScreenStatus ==
                                    GetFlicksCatagoryScreenStatus.loading
                                ? const CatagoryShimmer()
                                : provider.getFlicksCatagoryScreenStatus ==
                                        GetFlicksCatagoryScreenStatus.loaded
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: CachedImageWidget(
                                            imageUrl: catagoryData?.banner ??
                                                "https://resizing.flixster.com/RRKpZaBDbZEJGGJnm9W3EJR7Jxg=/206x305/v2/https://resizing.flixster.com/uIALCOWs_1c76J2NXJ8_62wckrE=/ems.cHJkLWVtcy1hc3NldHMvbW92aWVzLzE0YTUzZjJlLTc4N2YtNGE0My04YzJiLTVmYzZjMGI0Yzg3OC5qcGc=",
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      )
                                    : const Text("Something went wrong"),
                          );
                        },
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class CatagoryShimmer extends StatelessWidget {
  const CatagoryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 200,
        width: 200,
        child: CachedImageWidget(
          imageUrl:
              "https://resizing.flixster.com/RRKpZaBDbZEJGGJnm9W3EJR7Jxg=/206x305/v2/https://resizing.flixster.com/uIALCOWs_1c76J2NXJ8_62wckrE=/ems.cHJkLWVtcy1hc3NldHMvbW92aWVzLzE0YTUzZjJlLTc4N2YtNGE0My04YzJiLTVmYzZjMGI0Yzg3OC5qcGc=",
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
