import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/utils/enums.dart';

import '../../../helpers/router.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';
import '../../../utils/extentions.dart';
import '../model/get_vibes_model.dart';
import '../view_model/vibes_provider.dart';

class VibesHomeScreen extends StatefulWidget {
  const VibesHomeScreen({super.key});

  @override
  State<VibesHomeScreen> createState() => _VibesHomeScreenState();
}

class _VibesHomeScreenState extends State<VibesHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VibesProvider>().getVibesFn("", false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Consumer<VibesProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  const SizeBoxH(25),
                  StoryWidget(
                    vibesCatagoryList: provider.getVibesData.categoryData,
                  ),
                  const SizeBoxH(10),
                  provider.getVibesData.vibesData?.isEmpty == true
                      ? SizedBox(
                          height: Responsive.height * 70,
                          width: Responsive.width * 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Image.asset(
                                  "assets/images/vibesNoDataImage.png",
                                  width: Responsive.width * 100,
                                  height: Responsive.height * 30,
                                ),
                              ),
                            ],
                          ),
                        )
                      : provider.getVibesStatus == GetVibesStatus.loading
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
                          : MasonryGridView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount:
                                  provider.getVibesData.vibesData?.length ?? 0,
                              gridDelegate:
                                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                var vibesHomeData =
                                    provider.getVibesData.vibesData?[index];
                                return provider.getVibesStatus ==
                                        GetVibesStatus.loaded
                                    ? CommonInkwell(
                                        onTap: () {
                                          context.pushNamed(
                                              AppRouter.vibesVideoScreen,
                                              queryParameters: {
                                                "index": index.toString()
                                              });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(vibesHomeData
                                                    ?.imageUrl ??
                                                "https://images.ctfassets.net/hrltx12pl8hq/5596z2BCR9KmT1KeRBrOQa/4070fd4e2f1a13f71c2c46afeb18e41c/shutterstock_451077043-hero1.jpg?fit=fill&w=600&h=1200"),
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              },
                            ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class StoryWidget extends StatelessWidget {
  final List<CategoryDatum>? vibesCatagoryList;

  const StoryWidget({super.key, this.vibesCatagoryList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(vibesCatagoryList?.length ?? 0, (index) {
                var catagoryData = vibesCatagoryList?[index];
                return Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: CommonInkwell(
                    onTap: () {
                      context
                          .read<VibesProvider>()
                          .getVibesFn(catagoryData?.id ?? '', true);
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 67,
                          height: 67,
                          padding: const EdgeInsets.all(4.0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF9B2282),
                                    Color(0xFFEEA863)
                                  ])),
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CachedNetworkImage(
                                imageUrl: catagoryData?.image ??
                                    "https://blogger.googleusercontent.com/img/a/AVvXsEhUeiRmvP33IgmhAffdiFwHOqweHsFyOW12IoM2sXmU9ZxgzD1hra9-awcHXaF8aL5UZzg6Aa_R_JIde1_ZI-liUkc1UzD2fQYWvUzF7tPX4oyyNxkyGd0jM5_cG_QbA328a_eYs2PN9BCpQRXVEBVrG83lX-I6VrOTvkRfx666VJap6F4AbZakPJioul2y=w640-h192",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 65,
                                  height: 65,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey, spreadRadius: 1)
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: AppConstants.appPrimaryColor,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(AppImages.paymentFailed404,
                                        fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(catagoryData?.name ?? ""),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
