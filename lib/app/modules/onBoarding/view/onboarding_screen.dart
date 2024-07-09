import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/onBoarding/view_model/onboarding_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/extentions.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final onBoardingProvider = context.watch<OnBoardingProvider>();
    final isLastSlide = onBoardingProvider.caroselPageChange ==
        onBoardingProvider.introImg.length - 1;
    return Scaffold(
      body: Consumer<OnBoardingProvider>(
        builder: (context, provider, child) => Stack(
          children: [
            CarouselSlider.builder(
              carouselController: provider.carouselController,
              options: CarouselOptions(
                height: Responsive.height * 100,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0,
                scrollDirection: Axis.horizontal,
                scrollPhysics: const ClampingScrollPhysics(),
                onPageChanged: (index, reason) {
                  onBoardingProvider.nextPage(index);
                },
              ),
              itemCount: provider.introImg.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                var img = provider.introImg[itemIndex];
                var headline = provider.introHeadline[itemIndex];
                var subTitle = provider.introSubTitle[itemIndex];
                return Container(
                  height: Responsive.height * 100,
                  width: Responsive.width * 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(img.toString()), fit: BoxFit.fill)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(headline,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppConstants.white,
                                  fontSize: 24,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.96,
                                )),
                        const SizeBoxH(10),
                        Text(subTitle,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: AppConstants.white,
                                  fontSize: 12,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.48,
                                )),
                        const SizeBoxH(30),
                        CommonButton(
                          btnName: isLastSlide ? "Get Started" : "Next",
                          ontap: () {
                            if (isLastSlide) {
                              context.goNamed(AppRouter.login);
                            } else {
                              provider.carouselController.nextPage();
                            }
                          },
                        ),
                        const SizeBoxH(20),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (!isLastSlide)
              Positioned(
                top: Responsive.height * 4,
                right: 20,
                child: TextButton(
                  onPressed: () {
                    context.goNamed(AppRouter.login);
                  },
                  child: Text(
                    "Skip",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: AppConstants.appPrimaryColor,
                          fontSize: 20,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.48,
                        ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
