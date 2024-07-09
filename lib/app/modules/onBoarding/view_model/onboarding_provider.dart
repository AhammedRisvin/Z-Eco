import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zoco/app/utils/app_images.dart';

class OnBoardingProvider extends ChangeNotifier {
  TextEditingController emailTextEditingController = TextEditingController();
  final List<String> introImg = [
    AppImages.onboard01,
    AppImages.onboard02,
    AppImages.onboard03,
  ];

  final List<String> introHeadline = [
    'Let’s Start Your Shopping Journey',
    'Discover Your Style',
    'Gear Up for Anything',
  ];
  final List<String> introSubTitle = [
    'Browse our curated selection of products and enjoy exclusive in-flight discounts.',
    'Explore the latest fashion trends for men, women, and everything in between.',
    'Find the perfect tech gadgets and accessories to elevate your everyday life.',
  ];

  CarouselController carouselController = CarouselController();

  int caroselPageChange = 0;
  void nextPage(int value) {
    caroselPageChange = value;
    notifyListeners();
  }
}
