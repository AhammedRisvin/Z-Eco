import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';
import 'package:zoco/app/modules/home/view_model/home_provider.dart';
import 'package:zoco/app/modules/onBoarding/view_model/onboarding_provider.dart';
import 'package:zoco/app/utils/prefferences.dart';

import '../env.dart';
import '../modules/auth/view_model/auth_provider.dart';
import '../modules/cart/view model/cart_provider.dart';
import '../modules/notification/view model/notificaion_provider.dart';
import '../modules/orders/view model/order_provider.dart';
import '../modules/review/view model/review_provider.dart';
import '../modules/search/view model/search_provider.dart';
import '../modules/sections and details/view model/section_provider.dart';
import '../modules/settings/view model/settings_provider.dart';
import '../modules/settings/view model/wallet_provider.dart';
import '../modules/vibes/view_model/vibes_provider.dart';
import '../modules/widgets/view_model/bottom_nav_bar_provider.dart';
import '../theme/theme_provider.dart';

class AppConstants {
  static const String appName = Environments.appName;
  static const String fontFamily = "PlusJakartaSans";

  static const reviewStarColor = Color(0xffFFC120);
  static const red = Colors.red;

  /// App Colors  Light
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF303030);
  static const appPrimaryColor = Color(0xff2F4EFF);
  static const appBorderColor = Color(0xFFDCE5F2);

  static const appMainGreyColor = Color(0xFF8391A1);

  /// App Colors  dark
  static const dark = Color(0xFFFFFFFF);
  static const darkbg = Color(0xFF111111);
  static const darkappPrimaryColor = Color(0xff2F4EFF);
  static const darkappBorderColor = Color(0xFF44484E);

  static const darkappDiscriptioGreyColor = Color(0xFF8391A1);
  static const darkapphintGreyColor = Color(0xFF72787E);
  static const containerColor = Color(0xFF2E2E2E);
  static const containerBorderColor = Color(0xFFDCE4F2);
}

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) {
      return ThemeProvider(AppPref.isDark);
    },
  ),
  ChangeNotifierProvider(create: ((context) => OnBoardingProvider())),
  ChangeNotifierProvider(create: ((context) => AuthProviders())),
  ChangeNotifierProvider(create: ((context) => BottomBarProvider())),
  ChangeNotifierProvider(create: ((context) => HomeProvider())),
  ChangeNotifierProvider(create: ((context) => FlicksController())),
  ChangeNotifierProvider(create: ((context) => CartProvider())),
  // ChangeNotifierProvider(create: ((context) => FilterProvider())),
  ChangeNotifierProvider(create: ((context) => OrderProvider())),
  ChangeNotifierProvider(create: ((context) => SettingsProvider())),
  ChangeNotifierProvider(create: ((context) => SectionProvider())),
  ChangeNotifierProvider(create: ((context) => VibesProvider())),
  ChangeNotifierProvider(create: ((context) => WalletProvider())),
  ChangeNotifierProvider(create: ((context) => NotificationProvider())),
  ChangeNotifierProvider(create: ((context) => SearchProvider())),
  ChangeNotifierProvider(create: ((context) => ReviewProvider())),
  // ChangeNotifierProvider(create: ((context) => SettingsProvider())),
];
