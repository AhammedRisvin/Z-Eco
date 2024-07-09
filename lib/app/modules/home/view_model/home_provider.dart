// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/backend/urls.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/search/view%20model/search_provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/view%20model/section_provider.dart';
import 'package:zoco/app/utils/prefferences.dart';

import '../../../backend/server_client_services.dart';
import '../../../helpers/loading_overlay.dart';
import '../../../utils/enums.dart';
import '../../flicks/view_model/flicks_controller.dart';
import '../../sections and details/model/get_product_details_model.dart';
import '../../sections and details/model/get_secdtion_homescreen_model.dart';
import '../../settings/view model/settings_provider.dart';
import '../../vibes/view_model/vibes_provider.dart';
import '../model/get_homeproduct_model.dart';
import '../model/main_categories_model.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController searchTextEditingController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  double cartAnimatedWidth = 35;
  double cartAnimatedHeight = 35;
  bool isCartIconTaped = false;
  BorderRadiusGeometry cartAnimatedBorderRadius = BorderRadius.circular(50);

  List<String> categoryNames = [
    "Deals",
    "Fashion",
    "Gadget &Accessories",
    "Appliances",
    "Mobiles",
    "Sports",
    "PersonalCare",
    "Toys &Baby",
    "Furniture",
    "Grocery"
  ];
  int index = 0;
  void fetchHomeData() async {
    index = 0;
    sectionFnc();
    getRecommendedProductsFn();
    getTopSwellingsProductsFn();
    notifyListeners();
  }

  /*   Api integrations*    */

  /*   Api Categories*    */

  String accessoriesSectionId = '';
  String gadgetsSectionId = '';

  MainCategories mainCategories = MainCategories(
    message: '',
    sections: [],
    success: false,
  );
  List<SectionElement> sectionList = <SectionElement>[];
  SectionElement dealsData = SectionElement(
    id: '1234567890',
    image: 'https://api.dev.test.image.theowpc.com/NPveC1kzT.png',
    name: "Deals",
  );
  EctomereSectionStatus ectomereSectionStatus = EctomereSectionStatus.initial;
  Future<MainCategories?> sectionFnc() async {
    ectomereSectionStatus = EctomereSectionStatus.loading;
    try {
      dealsData = SectionElement(
        id: '1234567890',
        image: 'https://api.dev.test.image.theowpc.com/NPveC1kzT.png',
        name: "Deals",
      );
      List response = await ServerClient.get(Urls.sectionUrls);
      if (response.first >= 200 && response.first < 300) {
        sectionList.clear();
        mainCategories = MainCategories.fromJson(response.last);
        sectionList.add(dealsData);
        notifyListeners();
        sectionList.addAll(mainCategories.sections ?? []);
        for (var element in sectionList) {
          if (element.name == 'Accessories') {
            accessoriesSectionId = element.id ?? '';
            sectionList.remove(element);
            notifyListeners();
          } else if (element.name == "Gadget & Accessories") {
            gadgetsSectionId = element.id ?? '';
            notifyListeners();
          }
        }

        ectomereSectionStatus = EctomereSectionStatus.loaded;

        return mainCategories;
      } else {
        mainCategories = MainCategories(
          message: '',
          sections: [],
          success: false,
        );
        sectionList = <SectionElement>[];
      }
    } catch (e) {
      sectionList = <SectionElement>[];
      mainCategories = MainCategories(
        message: '',
        sections: [],
        success: false,
      );
      ectomereSectionStatus = EctomereSectionStatus.error;
    } finally {
      index++;
      notifyListeners();
    }
    return null;
  }

//* Get Recommended Products   - start  */

  GetRecomendedProductstatus getRecomendedProductstatus =
      GetRecomendedProductstatus.initial;
  GetHomeProductsModel recomendedProductsModel =
      GetHomeProductsModel(message: '', productData: []);

  List<ProductDatum> recommendedProductList = [];

  Future<void> getRecommendedProductsFn() async {
    try {
      getRecomendedProductstatus = GetRecomendedProductstatus.loading;
      List response = await ServerClient.get(
        Urls.getRecommendedProducts,
      );
      if (response.first >= 200 && response.first < 300) {
        recomendedProductsModel = GetHomeProductsModel.fromJson(response.last);
        recommendedProductList.clear();
        recommendedProductList
            .addAll(recomendedProductsModel.productData ?? []);

        getRecomendedProductstatus = GetRecomendedProductstatus.loaded;
        notifyListeners();
      } else {
        recomendedProductsModel =
            GetHomeProductsModel(message: '', productData: []);
        recommendedProductList = [];
        getRecomendedProductstatus = GetRecomendedProductstatus.error;
      }
    } catch (e) {
      recommendedProductList = [];
      recomendedProductsModel = GetHomeProductsModel(
        message: '',
        productData: [],
      );
      getRecomendedProductstatus = GetRecomendedProductstatus.error;
    } finally {
      index++;
    }
    notifyListeners();
  }

  GetHomeProductsModel topSellingProductModel = GetHomeProductsModel(
    message: '',
    productData: [],
  );
  List<ProductDatum> topSellingList = [];
  Future<void> getTopSwellingsProductsFn() async {
    try {
      List response = await ServerClient.get(
        Urls.getTopSwellings,
      );
      if (response.first >= 200 && response.first < 300) {
        topSellingProductModel = GetHomeProductsModel.fromJson(response.last);
        topSellingList.clear();
        topSellingList.addAll(topSellingProductModel.productData ?? []);

        notifyListeners();
      } else {
        topSellingProductModel =
            GetHomeProductsModel(message: '', productData: []);
        topSellingList = [];
      }
    } catch (e) {
      topSellingList = [];
      topSellingProductModel = GetHomeProductsModel(
        message: '',
        productData: [],
      );
    } finally {
      index++;
    }
    notifyListeners();
  }

  /*...........Location.............*/

  final searchbarText = TextEditingController();
  String location = 'Choose a location';

  double longitude = 0.0;
  double latitude = 0.0;
  String country = '';
  String street = '';
  String state = '';
  String selectedLocation = '';
  String postalCode = '';
  String subLocality = '';

  Position? currentPosition;
  String currentAddress = "Location";
  String? choosedLocation;

  String currentcountry = '';

  Future<Position> determinePosition({required BuildContext context}) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        double defaultLatitude = 20.5937;
        double defaultLongitude = 78.9629;
        await getAddressFromLatLng(
            latitude: defaultLatitude,
            longitude: defaultLongitude,
            context: context);
        return Position(
          latitude: defaultLatitude,
          longitude: defaultLongitude,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0,
          headingAccuracy: 0.0,
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      double defaultLatitude = 20.5937;
      double defaultLongitude = 78.9629;
      await getAddressFromLatLng(
          latitude: defaultLatitude,
          longitude: defaultLongitude,
          context: context);
      return Position(
        latitude: defaultLatitude,
        longitude: defaultLongitude,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        headingAccuracy: 0.0,
      );
    }
    LoadingOverlay.of(context).show();

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    await getAddressFromLatLng(
        latitude: position.latitude,
        longitude: position.longitude,
        context: context);
    LoadingOverlay.of(context).hide();
    return position;
  }

  getLocation({context}) async {
    final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    longitude = pos.longitude;
    latitude = pos.latitude;

    await getAddressFromLatLng(
        latitude: latitude, longitude: longitude, context: context);
  }

  getZipCodeLocation({context}) async {
    List<Location> locations =
        await locationFromAddress(zipcodeController.text);

    // Display location information
    if (locations.isNotEmpty) {
      latitude = locations.first.latitude;
      longitude = locations.first.longitude;
      getAddressFromLatLng(
          latitude: latitude, longitude: longitude, context: context);
      zipcodeController.clear();
      notifyListeners();
    } else {
      const locationInfo = 'Location not found';
      zipcodeController.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  getAddressFromLatLng(
      {required double latitude,
      required double longitude,
      required context}) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);

      Placemark place = p[0];

      String locality = place.locality.toString();
      currentAddress = locality;
      AppPref.country = place.country.toString();

      country = place.country.toString();
      street = (place.name ?? '') + (place.street ?? '');
      state = place.administrativeArea ?? "";
      postalCode = place.postalCode ?? "";
      subLocality = place.subLocality ?? '';
      fetchHomeData();
      Provider.of<VibesProvider>(context, listen: false).getVibesFn("", false);
      Provider.of<FlicksController>(context, listen: false)
          .getFlicksSubscriptionFn();
    } finally {
      notifyListeners();
    }
  }

// new wishlist fn start

  Future addToWishlistFn({
    required String productId,
    required BuildContext context,
    required String isFrom,
    required String isFromWhichList,
    ProductDetails? productDetails,
    Product? offerProduct,
    int? index,
  }) async {
    bool isSignedIn = AppPref.isSignedIn;

    if (!isSignedIn) {
      context.pushReplacement(AppRouter.login);
      return;
    }
    try {
      List response = await ServerClient.post(
        Urls.addOrRemoveFromWishlistUrl,
        data: {
          "id": productId,
        },
      );

      if (response.first >= 200 && response.first < 300) {
        SettingsProvider settingsProvider = context.read<SettingsProvider>();
        settingsProvider.getWishlistFn();

        setAllProductWishlist(
          productId: productId,
          context: context,
          where: isFrom,
          isTrue: true,
        );
      }
    } finally {
      notifyListeners();
    }
  }

  Future removeFromWishlistFn({
    required String productId,
    required BuildContext context,
    required String isFrom,
    required String isFromWhichList,
    ProductDetails? productDetails,
    Product? offerProduct,
    int? index,
  }) async {
    try {
      List response = await ServerClient.post(
        Urls.addOrRemoveFromWishlistUrl,
        data: {
          "id": productId,
        },
      );

      if (response.first >= 200 && response.first < 300) {
        SettingsProvider settingsProvider = context.read<SettingsProvider>();
        settingsProvider.getWishlistFn();

        setAllProductWishlist(
          productId: productId,
          context: context,
          where: isFrom,
          isTrue: false,
        );
      }
    } finally {
      notifyListeners();
    }
  }

  void setAllProductWishlist(
      {required String productId,
      required String where,
      required BuildContext context,
      required bool isTrue}) {
    if (where.toUpperCase() == "DETAILS") {
      context.read<SectionProvider>().getProductDetailsModel.product?.wishlist =
          isTrue;
    }

    try {
      for (var element in recommendedProductList) {
        if (element.productId == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element in topSellingList) {
        if (element.productId == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element in context
              .read<SectionProvider>()
              .getSectionHomeScreenModel
              .filteredProducts?[0]
              .products ??
          []) {
        if (element.id == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element in context
              .read<SectionProvider>()
              .getSectionHomeScreenModel
              .filteredProducts?[1]
              .products ??
          []) {
        if (element.id == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element in context
              .read<SectionProvider>()
              .getSectionHomeScreenModel
              .filteredProducts?[2]
              .products ??
          []) {
        if (element.id == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      if (where == 'Details Recommended Products') {
        for (var element in context
                .read<SectionProvider>()
                .getProductDetailsModel
                .relatedProducts ??
            []) {
          if (element.id == productId) {
            element.wishlist = isTrue;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element
          in context.read<SectionProvider>().getDealsModel.specialDeals ?? []) {
        if (element.productId == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element in context.read<SearchProvider>().searchDataList) {
        if (element.id == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element
          in context.read<SectionProvider>().fashionProductModel.products ??
              []) {
        if (element.id == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element in context
              .read<SectionProvider>()
              .getDealsModel
              .recommendedProducts ??
          []) {
        if (element.productId == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element
          in context.read<SectionProvider>().getDealsModel.specialDeals ?? []) {
        if (element?.id == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element in context
              .read<SectionProvider>()
              .getProductDetailsModel
              .relatedProducts ??
          []) {
        if (element.id == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element in context
              .read<SectionProvider>()
              .getSectionHomeScreenModel
              .topDeals ??
          []) {
        if (element.id == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("productId  :: ${e.toString()}");
      }
    }

    try {
      for (var element
          in context.read<SectionProvider>().fashionProductModel.products ??
              []) {
        if (element.id == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      e.toString();
    }

    try {
      for (var element
          in context.read<SectionProvider>().getDealsModel.specialDeals ?? []) {
        if (element.productId == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      e.toString();
    }

    try {
      for (var element
          in context.read<SectionProvider>().getDealsModel.bigSavings ?? []) {
        if (element.productId == productId) {
          element.wishlist = isTrue;
        }
      }
    } catch (e) {
      e.toString();
    }

    notifyListeners();
  }

// new wishlist fn end

  String formatNumber(num value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(2);
    }
  }
}
