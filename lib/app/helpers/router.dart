import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoco/app/modules/auth/view/create_new_password.dart';
import 'package:zoco/app/modules/auth/view/create_profile_screen.dart';
import 'package:zoco/app/modules/auth/view/forgot_password_screen.dart';
import 'package:zoco/app/modules/auth/view/otp_verification_screen.dart';
import 'package:zoco/app/modules/auth/view/password_change_success_screen.dart';
import 'package:zoco/app/modules/auth/view/signup_screen.dart';
import 'package:zoco/app/modules/flicks/view/flicks_settings_screen.dart';
import 'package:zoco/app/modules/flicks/view/library_screen.dart';
import 'package:zoco/app/modules/flicks/view/video_player_screen.dart';
import 'package:zoco/app/modules/flicks/view/video_screen.dart';
import 'package:zoco/app/modules/notification/view/notification_screen.dart';
import 'package:zoco/app/modules/onBoarding/view/splash_screen.dart';
import 'package:zoco/app/modules/orders/view/orders_screen.dart';
import 'package:zoco/app/modules/sections%20and%20details/widgets/produc_list_by_category.dart';

import '../modules/auth/view/login_screen.dart';
import '../modules/cart/view/add_address_screen.dart';
import '../modules/cart/view/deliver_to_screen.dart';
import '../modules/cart/view/your_cart.dart';
import '../modules/filter/view/filter_screen.dart';
import '../modules/flicks/view/flicks_current_sub_screen.dart';
import '../modules/flicks/view/flicks_downloads_screen.dart';
import '../modules/flicks/view/flicks_payment_screen.dart';
import '../modules/flicks/view/flicks_search_screen.dart';
import '../modules/flicks/view/flicks_subcategory.dart';
import '../modules/flicks/view/flicks_watch_history_screen.dart';
import '../modules/onBoarding/view/onboarding_screen.dart';
import '../modules/orders/view/bank_details_screen.dart';
import '../modules/orders/view/cancel_order_screen.dart';
import '../modules/orders/view/order_details_screen.dart';
import '../modules/orders/view/order_details_stepper_screen.dart';
import '../modules/orders/view/return_payment_selecting_screen.dart';
import '../modules/review/view/all_review_screen.dart';
import '../modules/review/view/write_review_screen.dart';
import '../modules/search/view/search_screen.dart';
import '../modules/sections and details/view/common section/product-details_screen.dart';
import '../modules/sections and details/view/common section/section_home_screen.dart';
import '../modules/sections and details/view/deals/deals_screen.dart';
import '../modules/sections and details/view/furniture/furniture_category_screen.dart';
import '../modules/sections and details/view/gadgets_and_accessories/gadgets_and_acessories_home_screen.dart';
import '../modules/sections and details/view/mobile/mobile_catagory_page.dart';
import '../modules/settings/view/change_password_screen.dart';
import '../modules/settings/view/coupons_screen.dart';
import '../modules/settings/view/profile_settings_screen.dart';
import '../modules/settings/view/settings_screen.dart';
import '../modules/settings/view/wallet/wallet-add_screen.dart';
import '../modules/settings/view/wallet/wallet_history_screen.dart';
import '../modules/settings/view/wishlist_screen.dart';
import '../modules/vibes/view/vibes_home_screen.dart';
import '../modules/vibes/view/vibes_video_screen.dart';
import '../modules/widgets/view/bottom_tab_bar.dart';
import '../modules/widgets/view/no_found_page.dart';
import '../modules/widgets/view/no_internet_screen.dart';
import '../utils/prefferences.dart';

class AppRouter {
  static const String initial = '/';
  static const String sliderScreen = '/sliderScreen';
  static const String login = '/login';
  static const String register = '/register';
  static const String noInternet = '/noInternet';
  static const String tab = '/tabscreen';

  /////////////////////////////////////////////////////////////
  static const String otpVerification = '/otpVerification';
  static const String createProfile = '/createProfile';
  static const String forgotPassword = '/forgotPassword';
  static const String createNewPassword = '/createNewPassword';
  static const String passwordChangeSuccessScreen =
      '/passwordChangeSuccessScreen';
  static const String notification = '/notification';
  static const String yourcartscreen = '/yourcartscreen';
  static const String checkoutscreen = '/checkoutscreen';
  static const String videoScreen = '/videoscreen';
  static const String libraryScreen = '/libraryscreen';
  static const String subscriptionScreen = '/subscriptionscreen';
  static const String videoPlayerScreen = '/videoplayerscreen';
  static const String delivertoscreen = '/delivertoscreen';
  static const String addaddressscreen = '/addaddressscreen';
  static const String selectPaymentScreen = '/selectPaymentScreen';
  static const String paymentFailedScreen = '/paymentFailedScreen';
  static const String filterScreen = '/filterScreen';
  static const String mobileCategoryScreen = '/mobileCatagoryScreen';
  static const String orderDetailsScreen = '/orderDetailsScreen';
  static const String orderDetailsStepperScreen = '/orderDetailsStepperScreen';
  static const String returnPaymentSelectingScreen =
      '/returnPaymentSelectingScreen';
  static const String cancelOrderScreen = '/cancelOrderScreen';
  static const String gadgetsAndAccessoriesHomeScreen =
      '/gadgetsAndAccessoriesHomeScreen';
  static const String furnitureCategoryScreen = '/furnitureCategoryScreen';
  static const String vibesHomeScreen = '/vibesHomeScreen';
  static const String writeReviewScreen = '/writeReviewScreen';
  static const String allReviewScreen = '/allReviewScreen';
  static const String productSearchScreen = '/productSearchScreen';
  static const String sectionHomeScreen = '/sectionHomeScreen';
  static const String subCategoryDetailsSCreen = '/subCategoryDetailsSCreen';
  static const String settingsScreen = '/settingsScreen';
  static const String profileSettingsScreen = '/profileSettingsScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String couponsScreen = '/couponsScreen';
  static const String wishlistScreen = '/wishlistScreen';
  static const String walletAddScreen = '/walletAddScreen';
  static const String walletHistoryScreen = '/walletHistoryScreen';
  static const String productListByCategoryScreen =
      '/productListByCategoryScreen';
  static const String dealsScreen = '/dealsScreen';
  static const String viewAvailableOfferScreen = '/viewAvailableOfferScreen';
  static const String bankDetailsScreen = '/bankDetailsScreen';
  static const String productDetailsViewScreen = '/productDetailsViewScreen';
  static const String selectAddressScreen = "/selectAddressScreen";
  static const String vibesVideoScreen = "/vibesVideoScreen";
  static const String orderScreen = "/orderScreen";
  static const String flixSubCategoryScreen = "/fixCategoryScreen";
  static const String flicksPaymentScreen = "/flicksPaymentScreen";
  static const String flicksSettingsScreen = "/flicksSettingsScreen";
  static const String flicksDownloadsScreen = "/flicksDownloadsScreen";
  static const String flicksWatchHistoryScreen = "/flicksWatchHistoryScreen";
  static const String flicksCurrentSubScreen = "/flicksCurrentSubScreen";
  static const String flicksSearchScreen = "/flicksSearchScreen";

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundPage();
// GoRouter configuration
  static final _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/Fashion/:category/:id',
        builder: (context, state) {
          debugPrint("path is ${state.uri.path}");
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '/Gadget & Accessories/Laptop/:category/:id',
        builder: (context, state) {
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '/Appliances/:category/:id',
        builder: (context, state) {
          debugPrint("path is ${state.uri.path}");
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '/Mobiles/:category/:id',
        builder: (context, state) {
          debugPrint("path is ${state.uri.path}");
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '/Sports/:category/:id',
        builder: (context, state) {
          debugPrint("path is ${state.uri.path}");
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '/Personal Care/:category/:id',
        builder: (context, state) {
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '/Toys & Baby/:category/:id',
        builder: (context, state) {
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '/Furniture/:category/:id',
        builder: (context, state) {
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '/Grocery/:category/:id',
        builder: (context, state) {
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '/deals/:category/:id',
        builder: (context, state) {
          return ProductDetailsViewScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        path: '//:category/:id',
        builder: (context, state) {
          return VideoScreen(
            productLink: state.uri.path.substring(1),
          );
        },
        redirect: (context, state) {
          if (!AppPref.isSignedIn) {
            return AppRouter.sliderScreen;
          }
          return null;
        },
      ),
      GoRoute(
        name: initial,
        path: initial,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: sectionHomeScreen,
        path: sectionHomeScreen,
        builder: (context, state) => SectionHomeScreen(
          categoryid: state.uri.queryParameters['categoryid'] ?? '',
          sectionName: state.uri.queryParameters['sectionName'] ?? '',
        ),
      ),
      GoRoute(
        name: vibesHomeScreen,
        path: vibesHomeScreen,
        builder: (context, state) => const VibesHomeScreen(),
      ),
      GoRoute(
        name: productListByCategoryScreen,
        path: productListByCategoryScreen,
        builder: (context, state) => ProductListByCategoryScreen(
          categoryid: state.uri.queryParameters['categoryid'] ?? '',
          subCategoryId: state.uri.queryParameters['subCategoryId'] ?? '',
          categoryname: state.uri.queryParameters['categoryname'] ?? '',
          isBrand: state.uri.queryParameters['isBrand'] ?? 'false',
          isFromDealsScreen:
              state.uri.queryParameters['isFromDealsScreen'] ?? 'false',
        ),
      ),
      GoRoute(
        name: productDetailsViewScreen,
        path: productDetailsViewScreen,
        builder: (context, state) => ProductDetailsViewScreen(
          productLink: state.uri.queryParameters['productLink'] ?? '',
        ),
      ),
      GoRoute(
        name: sliderScreen,
        path: sliderScreen,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        name: login,
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: register,
        path: register,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        name: noInternet,
        path: noInternet,
        builder: (context, state) => const NoInternetScreen(),
      ),
      GoRoute(
        name: tab,
        path: tab,
        builder: (context, state) => const BottomNavBarWidget(),
      ),
      GoRoute(
        name: otpVerification,
        path: otpVerification,
        builder: (context, state) {
          return const OtpVerificationScreen();
        },
      ),
      GoRoute(
        name: createProfile,
        path: createProfile,
        builder: (context, state) => const CreateProfileScreen(),
      ),
      GoRoute(
        name: forgotPassword,
        path: forgotPassword,
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        name: createNewPassword,
        path: createNewPassword,
        builder: (context, state) => CreateNewPasswordScreen(),
      ),
      GoRoute(
        name: passwordChangeSuccessScreen,
        path: passwordChangeSuccessScreen,
        builder: (context, state) => const PasswordChangeSuccessScreen(),
      ),
      GoRoute(
        name: notification,
        path: notification,
        builder: (context, state) => const ScreenNotification(),
      ),
      GoRoute(
        name: yourcartscreen,
        path: yourcartscreen,
        builder: (context, state) => const YourCartScreen(),
      ),
      GoRoute(
        name: videoScreen,
        path: videoScreen,
        builder: (context, state) => VideoScreen(
          productLink: state.uri.queryParameters["productLink"] ?? '',
        ),
      ),
      GoRoute(
        name: libraryScreen,
        path: libraryScreen,
        builder: (context, state) => const LibraryScreen(),
      ),
      GoRoute(
        name: delivertoscreen,
        path: delivertoscreen,
        builder: (context, state) => const DeliverToScreen(),
      ),
      GoRoute(
        name: addaddressscreen,
        path: addaddressscreen,
        builder: (context, state) => const AddAddressScreen(),
      ),
      GoRoute(
        name: videoPlayerScreen,
        path: videoPlayerScreen,
        builder: (context, state) => VideoPlayerScreen(
          videoUrl: state.uri.queryParameters['videoUrl'] ?? '',
          flickId: state.uri.queryParameters['flickId'] ?? '',
          fromWhere: state.uri.queryParameters['fromWhere'] ?? '',
        ),
      ),
      GoRoute(
        name: productSearchScreen,
        path: productSearchScreen,
        builder: (context, state) => ProductSearchScreen(
          categoryid: state.uri.queryParameters['categoryid'] ?? '',
          subCategoryId: state.uri.queryParameters['subCategoryId'] ?? '',
          brandId: state.uri.queryParameters['brandId'] ?? '',
        ),
      ),
      GoRoute(
        name: filterScreen,
        path: filterScreen,
        builder: (context, state) => FilterScreen(
          subCategory: state.uri.queryParameters['subCategory'] ?? '',
        ),
      ),
      GoRoute(
        name: mobileCategoryScreen,
        path: mobileCategoryScreen,
        builder: (context, state) => MobileCatagoryScreen(
          categoryid: state.uri.queryParameters['categoryid'] ?? '',
          sectionName: state.uri.queryParameters['sectionName'] ?? '',
        ),
      ),
      GoRoute(
        name: allReviewScreen,
        path: allReviewScreen,
        builder: (context, state) => AllReviewScreen(
          productId: state.uri.queryParameters['productId'] ?? '',
        ),
      ),
      GoRoute(
        name: writeReviewScreen,
        path: writeReviewScreen,
        builder: (context, state) => WriteReviewScreen(
          productId: state.uri.queryParameters['productId'] ?? '',
        ),
      ),
      GoRoute(
        name: orderDetailsScreen,
        path: orderDetailsScreen,
        builder: (context, state) => OrderDetailsScreen(
          isACtive: state.uri.queryParameters['isACtive'] ?? '',
        ),
      ),
      GoRoute(
        name: orderDetailsStepperScreen,
        path: orderDetailsStepperScreen,
        builder: (context, state) => const OrderDetailsStepperScreen(),
      ),
      GoRoute(
        name: returnPaymentSelectingScreen,
        path: returnPaymentSelectingScreen,
        builder: (context, state) => const ReturnPaymentSelectingScreen(),
      ),
      GoRoute(
        name: cancelOrderScreen,
        path: cancelOrderScreen,
        builder: (context, state) => const CancelOrderScreen(),
      ),
      GoRoute(
        name: settingsScreen,
        path: settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: profileSettingsScreen,
        path: profileSettingsScreen,
        builder: (context, state) => const ProfileSettingsScreen(),
      ),
      GoRoute(
        name: changePasswordScreen,
        path: changePasswordScreen,
        builder: (context, state) => const ChangePasswordScreen(),
      ),
      GoRoute(
        name: couponsScreen,
        path: couponsScreen,
        builder: (context, state) => const CouponsScreen(),
      ),
      GoRoute(
        name: wishlistScreen,
        path: wishlistScreen,
        builder: (context, state) => const WishlistScreen(),
      ),
      GoRoute(
        name: walletAddScreen,
        path: walletAddScreen,
        builder: (context, state) {
          return const WalletAddScreen();
        },
      ),
      GoRoute(
        name: walletHistoryScreen,
        path: walletHistoryScreen,
        builder: (context, state) => const WalletHistoryScreen(),
      ),
      GoRoute(
        name: furnitureCategoryScreen,
        path: furnitureCategoryScreen,
        builder: (context, state) => FurnitureCategoryScreen(
          categoryid: state.uri.queryParameters['categoryid'] ?? '',
          sectionName: state.uri.queryParameters['sectionName'] ?? '',
        ),
      ),
      GoRoute(
        name: gadgetsAndAccessoriesHomeScreen,
        path: gadgetsAndAccessoriesHomeScreen,
        builder: (context, state) => GadgetsAndAccessoriesHomeScreen(
          categoryid: state.uri.queryParameters['categoryid'] ?? '',
          sectionName: state.uri.queryParameters['sectionName'] ?? '',
        ),
      ),
      GoRoute(
        name: dealsScreen,
        path: dealsScreen,
        builder: (context, state) => const DealsScreen(),
      ),
      GoRoute(
        name: bankDetailsScreen,
        path: bankDetailsScreen,
        builder: (context, state) => const BankDetailsScreen(),
      ),
      GoRoute(
        name: vibesVideoScreen,
        path: vibesVideoScreen,
        builder: (context, state) => VibesVideoScreen(
          index: state.uri.queryParameters["index"].toString(),
        ),
      ),
      GoRoute(
        name: orderScreen,
        path: orderScreen,
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        name: flixSubCategoryScreen,
        path: flixSubCategoryScreen,
        builder: (context, state) => FlicksSubCategoryScreen(
          title: state.uri.queryParameters['title'] ?? '',
        ),
      ),
      GoRoute(
        name: flicksPaymentScreen,
        path: flicksPaymentScreen,
        builder: (context, state) => const FlicksPaymentScreen(),
      ),
      GoRoute(
        name: flicksSettingsScreen,
        path: flicksSettingsScreen,
        builder: (context, state) => const FlicksSettingsScreen(),
      ),
      GoRoute(
        name: flicksDownloadsScreen,
        path: flicksDownloadsScreen,
        builder: (context, state) => const FlicksDownloadsScreen(),
      ),
      GoRoute(
        name: flicksWatchHistoryScreen,
        path: flicksWatchHistoryScreen,
        builder: (context, state) => const FlicksWatchHistoryScreen(),
      ),
      GoRoute(
        name: flicksCurrentSubScreen,
        path: flicksCurrentSubScreen,
        builder: (context, state) => const FlicksCurrentSubScreen(),
      ),
      GoRoute(
        name: flicksSearchScreen,
        path: flicksSearchScreen,
        builder: (context, state) => const FlicksSearchScreen(),
      ),
    ],
  );

  static GoRouter get router => _router;
}
