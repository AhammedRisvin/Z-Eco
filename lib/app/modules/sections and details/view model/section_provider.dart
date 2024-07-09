import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/cart/view%20model/cart_provider.dart';

import '../../../backend/server_client_services.dart';
import '../../../backend/urls.dart';
import '../../../helpers/common_widgets.dart';
import '../../../utils/enums.dart';
import '../../../utils/prefferences.dart';
import '../model/get_deals_model.dart';
import '../model/get_filter_details_model.dart';
import '../model/get_product_details_model.dart';
import '../model/get_secdtion_homescreen_model.dart';
import '../model/get_section_product_model.dart';

class SectionProvider extends ChangeNotifier {
  int caroselPageChange = 0;

  void nextPage(int value) {
    caroselPageChange = value;
    notifyListeners();
  }

  bool isSelectCategory = false;
  int selectedCategoryIndex = -1;
  void selectCategoryFn(int value) {
    if (value == -1) {
      fashionSubCatagory.clear();

      notifyListeners();
    }
    selectedCategoryIndex = value;
    isSelectCategory = !isSelectCategory;
    notifyListeners();
  }

  int curserIndex = 0;
  void curserIndexFnc({int? value}) {
    curserIndex = value ?? 0;
    notifyListeners();
  }

  //GET FASHION CATAGORIES START
  int index = 0;
  GetFashionCatagoriesStatus getFashionCatagoriesStatus =
      GetFashionCatagoriesStatus.initial;
  GetSectionHomeModel getSectionHomeScreenModel = GetSectionHomeModel();

  Future<void> getRecommendedProductsFn({required String catagoryId}) async {
    try {
      index = 0;
      getSectionHomeScreenModel = GetSectionHomeModel();
      notifyListeners();
      getFashionCatagoriesStatus = GetFashionCatagoriesStatus.loading;
      List response = await ServerClient.get(
        Urls.getFashionCatagories + catagoryId,
      );
      if (response.first >= 200 && response.first < 300) {
        getSectionHomeScreenModel = GetSectionHomeModel.fromJson(response.last);
        getFashionCatagoriesStatus = GetFashionCatagoriesStatus.loaded;
        notifyListeners();
      } else {
        getFashionCatagoriesStatus = GetFashionCatagoriesStatus.error;
        getSectionHomeScreenModel = GetSectionHomeModel();
      }
    } catch (e) {
      getFashionCatagoriesStatus = GetFashionCatagoriesStatus.error;
      getSectionHomeScreenModel = GetSectionHomeModel();
    } finally {
      index++;
      notifyListeners();
    }
  }

  ///TopBrand Model for using Sub Category
  List<SubCategory> fashionSubCatagory = [];

  getEachSubCatagoryFn({required List<SubCategory> subCatagory}) {
    fashionSubCatagory = subCatagory;

    notifyListeners();
  }

  //GET FASHION CATAGORIES END

  int getFashionProductStatus = 0;
  GetSectionProductModel fashionProductModel = GetSectionProductModel();

  String isCategoryOrBrandOrBannerForAPiKey = 'category=';
  void getIsCategoryOrBrandOrBanner(String value) {
    isCategoryOrBrandOrBannerForAPiKey = value;
    notifyListeners();
  }

  Future<void> getProductProductsFn({required String catagoryId}) async {
    try {
      getFashionProductStatus = 0;
      notifyListeners();
      List response = await ServerClient.get(
        Urls.getFashionProducts +
            isCategoryOrBrandOrBannerForAPiKey +
            catagoryId,
      );

      if (response.first >= 200 && response.first < 300) {
        fashionProductModel = GetSectionProductModel.fromJson(response.last);

        notifyListeners();
      } else {
        fashionProductModel = GetSectionProductModel();
      }
    } catch (e) {
      fashionProductModel = GetSectionProductModel();
    } finally {
      getFashionProductStatus++;
      notifyListeners();
    }
    notifyListeners();
  }

  //GET FASHION PRODUCTS END

//**  Product Details Screen Section  Start */

  checkAvailableQuantity() {
    for (var i = 0;
        i <= (getProductDetailsModel.product?.details?.length ?? 0);
        i++) {
      if (getProductDetailsModel.product?.details?[i].quantity != 0) {
        selectSizeFun(
            value: i,
            selectedSize: getProductDetailsModel.product?.details?[i].id ?? "",
            selectedPrice:
                getProductDetailsModel.product?.details?[i].price?.toInt() ?? 0,
            offer: getProductDetailsModel.product?.offers?.toInt() ?? 0);
        break;
      } else {
        continue;
      }
    }
  }

  int selectedSizeIndex = -1;
  int selectedProductPrice = 0;
  int selectedProductDiscountPrice = 0;
  selectSizeFun(
      {required int value,
      required String selectedSize,
      required int selectedPrice,
      required int offer}) {
    selectedSizeIndex = value;
    selectedSizeId = selectedSize;

    int discountedPrice =
        (selectedPrice - (selectedPrice * (offer / 100))).floor();

    selectedProductDiscountPrice = discountedPrice;
    selectedProductPrice = selectedPrice;

    notifyListeners();
  }

  bool productDiscriptionIsExpanded = false;
  void checkProductDiscriptionIsExpandedFn() {
    productDiscriptionIsExpanded = !productDiscriptionIsExpanded;
    notifyListeners();
  }

  String convertDateToMontFormate(String selectedDateT) {
    try {
      DateTime date = DateTime.parse(selectedDateT).toLocal();

      // Format the DateTime object into "MMM d" format
      String formattedDate = DateFormat('MMMM d, yyyy').format(date);

      return formattedDate;
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    }
    return '';
  }

  int getProductDetailsStatus = 0;
  GetProductDetailsModel getProductDetailsModel = GetProductDetailsModel();

  Future<void> getProductDetailsFun({required String link}) async {
    try {
      getProductDetailsModel = GetProductDetailsModel();

      getProductDetailsStatus = 0;
      notifyListeners();
      List response = await ServerClient.post(Urls.getProductDetails,
          post: true, data: {'link': link});

      log('Product Details Response: ${response.first}');
      log('Product Details Response: ${response.last}');

      if (response.first >= 200 && response.first < 300) {
        try {
          getProductDetailsModel =
              GetProductDetailsModel.fromJson(response.last);
          checkAvailableQuantity();
        } catch (e) {
          getProductDetailsModel = GetProductDetailsModel();
        }

        notifyListeners();
      } else {
        getProductDetailsModel = GetProductDetailsModel();
      }
    } catch (e) {
      getProductDetailsModel = GetProductDetailsModel();
    } finally {
      getProductDetailsStatus++;
    }

    notifyListeners();
  }
//**  Product Details Screen Section  End */

  String selectedSizeId = "";

  /*..........Post add to cart*/

  Future addToCartFn({
    required BuildContext context,
    required String productId,
  }) async {
    bool isSignedIn = AppPref.isSignedIn;

    if (!isSignedIn) {
      context.pushReplacement(AppRouter.login);
      return;
    }
    try {
      List response = await ServerClient.post(
        Urls.postAddToCartUrl,
        data: {
          "productId": productId,
          "sizeId": selectedSizeId,
        },
      );

      if (selectedSizeId == "") {
        toast(
          context,
          title: "Choose size",
          backgroundColor: Colors.red,
        );
      } else if (response.first >= 200 && response.first < 300) {
        context.read<CartProvider>().getCartFn();
        isProductAddedToCart = true;
        notifyListeners();
        toast(
          context,
          title: response.last["message"],
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  // int getFashionProductStatus = 0;
  // GetSectionProductModel fashionProductModel = GetSectionProductModel();

//*********************************  Filter Section Start *********************************************************************/

  String getCategoryid2 = '';

  void getCategoryId2Fun(String value) {
    getCategoryid2 = value;

    notifyListeners();
  }

  List<String> filterOptions = [
    'Price',
    'Brand',
    'Rating',
    'Size',
    'Gender',
    'Colors',
    'New\nArrivals',
    'Sort By'
  ];

  List<String> priceOption = [
    '5000 and Above',
    '1000-4999',
    '500-999',
    '0-499',
    'All'
  ];

  List<String> newArrivals = [
    "Last 90 Days",
    "Last 60 Days",
    "Last 30 Days",
    "None"
  ];

  List<String> sortBy = [
    "Relevance",
    "Popularity",
    "Price : Low to High",
    'Price : High to Low',
    'None'
  ];

  int selectedIndex = 0;

  void selectedOption(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  int getProductFilterStatus = 0;
  GetFilterDetailsModel getFilterDetailsModel = GetFilterDetailsModel();

  List<FilterBrand> productBrandShowListForFilter = [];
  List<FilterBrand> productBrandListFilter = [];
  Future getProductFilterDataFn(String cateid) async {
    try {
      getFilterDetailsModel = GetFilterDetailsModel();
      getProductFilterStatus = 0;
      List response = await ServerClient.get(
        "${Urls.filterDetails}"
        "${getCategoryid2 == '' ? cateid : getCategoryid2}",
      );

      if (response.first >= 200 && response.first < 300) {
        getFilterDetailsModel = GetFilterDetailsModel.fromJson(response.last);
        productBrandShowListForFilter.clear();
        productBrandListFilter.clear();
        for (var element in getFilterDetailsModel.brands ?? []) {
          productBrandShowListForFilter.add(element);
          productBrandListFilter.add(element);
        }
        notifyListeners();
      } else {
        getFilterDetailsModel = GetFilterDetailsModel();
      }
    } catch (e) {
      getFilterDetailsModel = GetFilterDetailsModel();
      debugPrint('Error occurred during upload: $e ');
    } finally {
      getProductFilterStatus++;
      notifyListeners();
    }
  }

  void filterBrandSearchFn({required String enteredKeyword}) async {
    List<FilterBrand> productBrandListForFilter = [];
    if (enteredKeyword.isEmpty) {
      List response = await ServerClient.get(
        Urls.filterDetails + getCategoryid2,
      );
      getFilterDetailsModel = GetFilterDetailsModel.fromJson(response.last);

      productBrandListForFilter.clear();
      productBrandListForFilter.addAll(getFilterDetailsModel.brands ?? []);
      notifyListeners();
    } else if (enteredKeyword.length > 2) {
      productBrandListForFilter = productBrandListFilter.where((product) {
        return product.name!
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase());
      }).toList();
      notifyListeners();
    }

    productBrandShowListForFilter.clear();
    productBrandShowListForFilter.addAll(productBrandListForFilter);
    notifyListeners();
  }

  //
  //GENDER

  bool isMaleSelected = false;
  bool isFemaleSelected = false;
  bool isKidsSelected = false;

  String selectedGender = '';

  void selectMale(bool? value) {
    isMaleSelected = value ?? false;

    if (value != null && value) {
      isFemaleSelected = false;
      isKidsSelected = false;
    }
    if (isMaleSelected) {
      selectedGender = 'male';
    }
    notifyListeners();
  }

  void selectFemale(bool? value) {
    isFemaleSelected = value ?? false;
    if (value != null && value) {
      isMaleSelected = false;
      isKidsSelected = false;
    }
    if (isFemaleSelected) {
      selectedGender = 'female';
    }
    notifyListeners();
  }

  void selectKids(bool? value) {
    isKidsSelected = value ?? false;
    if (value != null && value) {
      isMaleSelected = false;
      isFemaleSelected = false;
    }
    if (isKidsSelected) {
      selectedGender = 'kids';
    }
    notifyListeners();
  }

  String selectedPrice = '';
  String minPrice = '';
  String maxPrice = '';
  String categoryId = "";
  void selectePriceFn(String value) {
    selectedPrice = value;

    if (value == '5000 and Above') {
      minPrice = "5000";
      maxPrice = "";
    } else if (value == 'All') {
      minPrice = '';
      maxPrice = '';
    } else {
// Split the string by "-"
      List<String> numbers = value.split("-");

// Assign the numbers to variables
      minPrice = numbers[0]; // "700"
      maxPrice = numbers[1]; // "500"
    }

    notifyListeners();
  }

  String selectedSortBy = '';
  String selectedSortdataForUiUpdate = '';

  void selecteSortByFn(String value) {
    selectedSortdataForUiUpdate = value;
    if (value == 'Relevance') {
      selectedSortBy = 'relevance=true';
    } else if (value == 'Popularity') {
      selectedSortBy = 'popularity=true';
    } else if (value == 'Price : Low to High') {
      selectedSortBy = 'price=1';
    } else if (value == 'Price : High to Low') {
      selectedSortBy = 'price=-1';
    } else if (value == 'None') {
      selectedSortBy = '';
    }

    notifyListeners();
  }

  String rating = '';

  void selecteRatingFn(String value) {
    rating = value;

    notifyListeners();
  }

  int selectedNewArrivals = 0;
  String selectedNewArrivaldataForUiUpdate = '';

  void selecteNewArrivalsFn(String value) {
    selectedNewArrivaldataForUiUpdate = value;
    if (value == 'Last 90 Days') {
      selectedNewArrivals = 90;
    } else if (value == 'Last 30 Days') {
      selectedNewArrivals = 30;
    } else if (value == "Last 60 Days") {
      selectedNewArrivals = 60;
    } else if (value == 'None') {
      selectedNewArrivals = 0;
    }

    notifyListeners();
  }

  List<String> selectedBrandListt = [];
  String brandQuery = '';

  void addAndRemoveBeand(String value) {
    if (!selectedBrandListt.contains(value)) {
      selectedBrandListt.add(value);
      notifyListeners();
    } else {
      selectedBrandListt.remove(value);
      notifyListeners();
    }
    brandQuery = buildQueryString(isBrand: true, isColor: false, isSize: false);
  }

  String buildQueryString(
      {required bool isBrand, required bool isColor, required bool isSize}) {
    String queryString = '';

    if (isBrand == true) {
      for (String brand in selectedBrandListt) {
        queryString += '&brand=$brand';
      }
    } else if (isColor == true) {
      for (String color in selectedColorList) {
        queryString += '&color=$color';
      }
    } else if (isSize == true) {
      for (String size in selectedSizeList) {
        queryString += '&size=$size';
      }
    }

    return queryString;
  }

//Size
  List<String> selectedSizeList = [];
  String sizeQuery = '';

  void addAndRemoveSize(String value) {
    if (!selectedSizeList.contains(value)) {
      selectedSizeList.add(value);
      notifyListeners();
    } else {
      selectedSizeList.remove(value);
      notifyListeners();
    }
    sizeQuery = buildQueryString(isBrand: false, isColor: false, isSize: true);
  }

//color
  List<String> selectedColorList = [];
  String colorQuery = '';

  void addAndRemoveColor(String value) {
    if (!selectedColorList.contains(value)) {
      selectedColorList.add(value);
      notifyListeners();
    } else {
      selectedColorList.remove(value);
      notifyListeners();
    }
    colorQuery = buildQueryString(isBrand: false, isColor: true, isSize: false);
  }

  Future productFilterFun(
      {required String categor, required BuildContext context}) async {
    try {
      getProductDetailsStatus = 0;
      String url = "";
      url =
          '${Urls.productFilterUrl + categor}&minPrice=$minPrice&maxPrice=$maxPrice&rating=$rating&gender=$selectedGender&days=$selectedNewArrivals$brandQuery$sizeQuery$colorQuery&$selectedSortBy';
      List response = await ServerClient.get(
        url,
      );

      if (response.first >= 200 && response.first < 300) {
        fashionProductModel = GetSectionProductModel.fromJson(response.last);

        context.pop();
        notifyListeners();
      } else {
        fashionProductModel = GetSectionProductModel();
      }
    } catch (e) {
      fashionProductModel = GetSectionProductModel();
      debugPrint('Error occurred during upload: $e ');
    } finally {
      getProductDetailsStatus++;
      notifyListeners();
    }
  }

  void clearSelectedFiltrartiopns() {
    minPrice = '';
    maxPrice = '';
    rating = '';
    selectedGender = '';
    selectedNewArrivals = 0;
    brandQuery = '';
    sizeQuery = '';
    colorQuery = '';
    selectedSortBy = '';

    isMaleSelected = false;
    isFemaleSelected = false;
    isKidsSelected = false;
    selectedPrice = '';
    selectedSortdataForUiUpdate = '';
    selectedNewArrivaldataForUiUpdate = '';
    selectedBrandListt.clear();
    selectedSizeList.clear();
    selectedColorList.clear();
    notifyListeners();
  }

//*********************************  Filter Section End *********************************************************************/

  int getDealsFunStatus = 0;
  GetDealsModel getDealsModel = GetDealsModel();

  Future<void> getDealsFun() async {
    try {
      getDealsModel = GetDealsModel();
      getDealsFunStatus = 0;
      List response = await ServerClient.get(Urls.deals);

      if (response.first >= 200 && response.first < 300) {
        List<Sections> filteredSections = [];
        getDealsModel = GetDealsModel.fromJson(response.last);

        if (getDealsModel.sections?.isNotEmpty ?? false) {
          for (var element in getDealsModel.sections!) {
            if (element.name != 'Accessories') {
              filteredSections.add(element);
            }
          }
          getDealsModel.sections = filteredSections;
          notifyListeners();
        }
      } else {
        getDealsModel = GetDealsModel();
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      getDealsModel = GetDealsModel();
    } finally {
      getDealsFunStatus = 1;
    }
    notifyListeners();
  }

  Future getDealsOfferProductFn(
      {required String offer, required BuildContext context}) async {
    try {
      getFashionProductStatus = 0;

      List response = await ServerClient.get(
        Urls.trendyOffer + offer,
      );

      if (response.first >= 200 && response.first < 300) {
        fashionProductModel = GetSectionProductModel.fromJson(response.last);

        context.pushNamed(AppRouter.productListByCategoryScreen,
            queryParameters: {'isFromDealsScreen': "true"});
        notifyListeners();
      } else {
        fashionProductModel = GetSectionProductModel();
      }
    } catch (e) {
      fashionProductModel = GetSectionProductModel();
      debugPrint('Error occurred during upload: $e ');
    } finally {
      getFashionProductStatus++;
      notifyListeners();
    }
  }

  bool isProductAddedToCart = false;
}

class ColorData {
  final String text;
  final Color color;

  ColorData({required this.text, required this.color});
}
