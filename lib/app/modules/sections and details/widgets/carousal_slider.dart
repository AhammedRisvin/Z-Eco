import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/extentions.dart';
import '../model/get_secdtion_homescreen_model.dart';
import '../view model/section_provider.dart';

class CarousalSliderWidget extends StatelessWidget {
  final void Function() onTap;
  final List<TopBanner>? carousalBaanner;
  const CarousalSliderWidget({
    super.key,
    required this.onTap,
    this.carousalBaanner,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 200,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 400),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0,
        scrollDirection: Axis.horizontal,
        scrollPhysics: const ClampingScrollPhysics(),
        onPageChanged: (index, reason) {
          context.read<SectionProvider>().nextPage(index);
          context.read<SectionProvider>().curserIndexFnc(value: index);
        },
      ),
      itemCount: carousalBaanner?.length ?? 0,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        var bannerDetails = carousalBaanner?[itemIndex];

        return CommonInkwell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0),
            child: SizedBox(
              height: 160,
              width: Responsive.width * 100,
              child: CachedImageWidget(
                  borderRadius: BorderRadius.circular(15),
                  height: 160,
                  width: Responsive.width * 100,
                  imageUrl: bannerDetails?.image ??
                      "https://blogger.googleusercontent.com/img/a/AVvXsEhUeiRmvP33IgmhAffdiFwHOqweHsFyOW12IoM2sXmU9ZxgzD1hra9-awcHXaF8aL5UZzg6Aa_R_JIde1_ZI-liUkc1UzD2fQYWvUzF7tPX4oyyNxkyGd0jM5_cG_QbA328a_eYs2PN9BCpQRXVEBVrG83lX-I6VrOTvkRfx666VJap6F4AbZakPJioul2y=w640-h192"),
            ),
          ),
        );
      },
    );
  }
}
