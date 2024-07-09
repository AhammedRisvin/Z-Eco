// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoco/app/backend/urls.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/cart/model/get_cart_model.dart';
import 'package:zoco/app/modules/cart/widget/order_success_screen.dart';

import '../../../backend/server_client_services.dart';
import '../../../helpers/loading_overlay.dart';
import '../../../utils/app_images.dart';
import '../../../utils/enums.dart';
import '../model/address_model.dart';
import '../widget/cart_paypal_webview_screen.dart';

class CartProvider extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController searchTextEditingController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController couponCodeController = TextEditingController();

  List<ShippingAddress> addressList = <ShippingAddress>[];
  ShippingAddress slectedAddressList = ShippingAddress();

  //cart increment and decrement

  void justUpdate() {
    notifyListeners();
  }

  int isSelected = 0;
  String addressType = '';

  void addressTypeFnc({required int type}) {
    if (type == 1) {
      isSelected = type;
      addressType = 'Home';
    } else if (type == 2) {
      isSelected = type;
      addressType = 'Work';
    } else {
      isSelected = 0;
      addressType = '';
    }
    notifyListeners();
  }

  int? selectAddres = 0;
  String addressId = '';

  void selectAddressFnc({required int value, required String id}) {
    selectAddres = value;

    addressId = id;

    for (ShippingAddress data in addressList) {
      if (data.id == addressId) {
        slectedAddressList = data;
      }
    }

    notifyListeners();
  }

  slectaddressIndex({int? value}) {
    selectAddres = value ?? 0;

    notifyListeners();
  }

  String dialCountryForAddress = 'IN';
  String dialCodeForAddress = '+91';
  void getPhoneNumberFromCountryCodeAddressFn(
      {required String dialCode, required String countryCode}) {
    dialCountryForAddress = countryCode;
    dialCodeForAddress = dialCode;
    notifyListeners();
  }

  void getPhoneNumberAddressFn({
    required String phone,
    required String dialCode,
    String? countryCode,
  }) {
    phoneNumberController.text = phone;
    dialCountryForAddress = countryCode ?? '';
    dialCodeForAddress = dialCode;
    notifyListeners();
  }

  addAddresstextfield() {
    firstNameController.text = slectedAddressList.name.toString();
    phoneNumberController.text = slectedAddressList.phone.toString();
    addressController.text = slectedAddressList.address.toString();
    cityController.text = slectedAddressList.city.toString();
    stateController.text = slectedAddressList.state.toString();
    zipCodeController.text = slectedAddressList.pincode.toString();
    log('.dialCodeShipping. ${slectedAddressList.dialCodeShipping.toString()}');
    getPhoneNumberAddressFn(
      dialCode: slectedAddressList.dialCodeShipping.toString(),
      phone: slectedAddressList.phone.toString(),
      countryCode: slectedAddressList.countryCode.toString(),
    );
    if (slectedAddressList.addressType == "Home") {
      isSelected = 1;
      addressType = "Home";
    } else if (slectedAddressList.addressType == "Work") {
      isSelected = 2;
      addressType = "Work";
    }
    notifyListeners();
  }

  bool isEditedAddress = false;

  isEdittedAddressFnc(bool value) {
    isEditedAddress = value;
    notifyListeners();
  }

  /*....................Api Integraions..................... */

  /*..........GetAddress*/

  ShippingAddressStatus shppingAddressStatus = ShippingAddressStatus.initial;

  Future getAllAddressFnc() async {
    shppingAddressStatus = ShippingAddressStatus.loading;
    try {
      List response = await ServerClient.get(Urls.getAddressUrl);
      log("message  ${response.last}");
      if (response.first >= 200 && response.first < 300) {
        ShippingAddressModel data =
            ShippingAddressModel.fromJson(response.last);
        addressList = data.shippingAddress!.toList();
        if (addressList.isNotEmpty) {
          selectAddressFnc(
              id: '${addressList[selectAddres ?? 0].id}',
              value: selectAddres ?? 0);
        }

        shppingAddressStatus = ShippingAddressStatus.loaded;
        return addressList;
      } else {
        shppingAddressStatus = ShippingAddressStatus.error;
      }
    } catch (e) {
      shppingAddressStatus = ShippingAddressStatus.error;
    } finally {
      notifyListeners();
    }
  }

  /*..........PostAddress*/

  Future postAddressFnc({required BuildContext context}) async {
    try {
      List response = await ServerClient.post(
        Urls.postAddressUrl,
        data: {
          "address": addressController.text,
          "city": cityController.text,
          "pincode": zipCodeController.text,
          "state": stateController.text,
          "name": firstNameController.text,
          "phone": phoneNumberController.text,
          "addressType": addressType,
          "dialCode": dialCodeForAddress
        },
      );

      if (response.first >= 200 && response.first < 300) {
        getAllAddressFnc();
        context.pushNamed(AppRouter.delivertoscreen);
        isEdittedAddressFnc(false);
        addressClearFnc();
      } else {
        toast(context, title: response.last, backgroundColor: Colors.red);
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  void addressClearFnc() {
    addressController.clear();
    cityController.clear();
    zipCodeController.clear();
    stateController.clear();
    firstNameController.clear();
    phoneNumberController.clear();
    addressType;
  }

  /*..........editAddress*/

  Future editAddressFnc(
      {required BuildContext context, required String addressId}) async {
    try {
      List response = await ServerClient.put(
        Urls.editAddressUrl + addressId,
        data: {
          "address": addressController.text,
          "city": cityController.text,
          "pincode": zipCodeController.text,
          "state": stateController.text,
          "name": firstNameController.text,
          "phone": phoneNumberController.text,
          "addressType": addressType,
        },
      );
      if (response.first >= 200 && response.first < 300) {
        slectedAddressList = ShippingAddress();
        getAllAddressFnc();
        context.pushNamed(AppRouter.delivertoscreen);
        isEdittedAddressFnc(false);
        addressClearFnc();
      } else {
        toast(context, title: response.last, backgroundColor: Colors.red);
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  /*..........deleteAddress*/

  Future deleteAddressFnc({
    required String addressId,
  }) async {
    try {
      List response =
          await ServerClient.delete(Urls.deleteAddressUrl + addressId);

      if (response.first >= 200 && response.first < 300) {
        int indexToRemove =
            addressList.indexWhere((address) => address.id == addressId);

        if (indexToRemove != -1) {
          if (addressId == addressList[indexToRemove].id &&
              addressList.isNotEmpty) {
            slectedAddressList = ShippingAddress();

            selectAddressFnc(value: 0, id: addressList[0].id.toString());
          } else {
            slectaddressIndex(value: -1);
            slectedAddressList = ShippingAddress();
          }
          addressList.removeAt(indexToRemove);
          addressClearFnc();
        }
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  /*..........Get cart*/

  GetCartStatus getCartStatus = GetCartStatus.initial;

  GetCartModel getCartModel = GetCartModel();

  Future getCartFn() async {
    getCartStatus = GetCartStatus.loading;
    try {
      List response = await ServerClient.get(Urls.getCartUrl);

      if (response.first >= 200 && response.first < 300) {
        getCartModel = GetCartModel.fromJson(response.last);

        getCartStatus = GetCartStatus.loaded;
        return addressList;
      } else {
        getCartModel = GetCartModel();
        getCartStatus = GetCartStatus.error;
      }
    } catch (e) {
      getCartModel = GetCartModel();
      getCartStatus = GetCartStatus.error;
    } finally {
      notifyListeners();
    }
  }

  Future quantityIncrementFn({
    required String productId,
    required String selectedSizeId,
    required int quantity,
    required int totalQuantity,
    required BuildContext context,
  }) async {
    try {
      setLoadingAdd(true);
      List response = await ServerClient.post(
        Urls.cartIncrementUrl,
        data: {
          "productId": productId,
          "sizeId": selectedSizeId,
        },
      );

      if (response.first >= 200 &&
          response.first < 300 &&
          quantity < totalQuantity) {
        getCartFn();
        setLoadingAdd(false);

        notifyListeners();
      } else {
        setLoadingAdd(false);
        toast(
          context,
          title: "Reached Max Quantity",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  Future quantityDecrementFn({
    required String productId,
    required String selectedSizeId,
    required int quantity,
  }) async {
    try {
      setLoadingAdd(true);
      List response = await ServerClient.post(
        Urls.cartDecrementUrl,
        data: {
          "productId": productId,
          "sizeId": selectedSizeId,
        },
      );

      if (response.first >= 200 && response.first < 300) {
        getCartFn();
        setLoadingAdd(false);
      } else {
        setLoadingAdd(false);
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

// CART REMOVE FN

  Future cartRemoveFn({
    required String productId,
    required String selectedSizeId,
    required BuildContext context,
  }) async {
    try {
      List response = await ServerClient.post(
        Urls.cartRemoveUrl,
        data: {
          "productId": productId,
          "sizeId": selectedSizeId,
        },
      );

      if (response.first >= 200 && response.first < 300) {
        toast(
          context,
          title: "Product Removed Successfully",
          backgroundColor: Colors.red,
        );
        getCartFn();
      } else {
        toast(
          context,
          title: response.last,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  int selectedPaymentIndex = -1;
  List<int> selectedPaymentIndexList = [];

  void setSelectedIndex(
    int index, {
    required int walletAmount,
    required int totalPrice,
  }) {
    if (selectedPaymentIndexList.contains(index)) {
      selectedPaymentIndexList.remove(index);
      selectedPaymentIndex = -1;
    } else {
      if (totalPrice <= walletAmount) {
        selectedPaymentIndexList.clear();
        isWalletSelected = false;
      }
      selectedPaymentIndexList.clear();
      selectedPaymentIndexList.add(index);
      selectedPaymentIndex = index;
    }

    notifyListeners();
  }

  //**Stripe Payment Start */

  String selectedCouponId = '';
  bool isCouponApplied = false;

  String paymentIntentId = '';
  String orderId = '';
  Future createStripeFn({
    required BuildContext context,
    required String amount,
    required String cartId,
    required String isWalletApplied,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.cartStripeUrl + isWalletApplied,
        data: isCouponApplied
            ? {
                "amount": amount,
                "shippingId": slectedAddressList.id,
                "cartId": cartId,
                "couponId": selectedCouponId
              }
            : {
                "amount": amount,
                "shippingId": slectedAddressList.id,
                "cartId": cartId,
              },
        post: true,
      );
      log("message  ${response.last}");
      log("message  ${response.first}");
      if (response.first >= 200 && response.first < 300) {
        paymentIntentId = response.last['clientSecret'];
        orderId = response.last['orderId'];
        makeStripePayment(context: context, cartId: cartId);
      } else {
        LoadingOverlay.of(context).hide();
        context.pop();
        toast(
          context,
          title: "Bank server is busy. Please try again later",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      debugPrint('Error occurred during upload: $e ');
    }
  }

  Future<void> makeStripePayment({
    required BuildContext context,
    required cartId,
  }) async {
    try {
      try {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                merchantDisplayName: "prospect",
                paymentIntentClientSecret: paymentIntentId));
      } catch (e) {
        LoadingOverlay.of(context).hide();
      }
      //STEP 3: Display Payment sheet
      try {
        LoadingOverlay.of(context).hide();

        await Stripe.instance.presentPaymentSheet().then((value) async {
          await paymentValidationFn(
            clintId: paymentIntentId,
            context: context,
            cartId: cartId,
          );
        });
      } on Exception catch (e) {
        LoadingOverlay.of(context).hide();

        if (e is StripeException) {
          debugPrint('Error occurred during upload: $e ');
        } else {
          debugPrint('Error occurred during upload: $e ');
        }
      } catch (e) {
        LoadingOverlay.of(context).hide();
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      toast(
        context,
        title: "Bank server is busy. Please try again later",
        backgroundColor: Colors.red,
      );
      debugPrint('Error occurred during upload: $e ');
    }
  }

  //validate payment
  Future paymentValidationFn({
    required clintId,
    required cartId,
    required BuildContext context,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.cartStripeValidation,
        data: {
          "clientSecret": clintId,
          "orderId": orderId,
          "cartId": cartId,
          "couponId": selectedCouponId
        },
        post: true,
      );
      log("message  ${response.last}");
      log("message  ${response.first}");

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        getCartFn();
        isWalletSelected = false;
        selectedPaymentIndex = -1;
        isCouponApplied = false;
        selectedCouponId = '';
        selectedPaymentIndexList.clear();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
        );
      } else {
        context.pop();
        LoadingOverlay.of(context).hide();
        toast(
          context,
          title: "Bank server is busy. Please try again later",
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    }

    notifyListeners();
  }

//**End */

  //** Paypal Payment Start */

  String paypalUrl = '';
  String paypalSuccessUrl = '';
  String paypalCancelUrl = '';
  String payPalAmount = "";
  String paypalCartId = '';
  paypalAmountFn(String amount) {
    payPalAmount = amount;
    notifyListeners();
  }

  Future createPaypalFn({
    required BuildContext context,
    required String isWalletApplied,
    required String cartId,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.cartPaypalUrl + isWalletApplied,
        data: isCouponApplied
            ? {
                "amount": payPalAmount,
                "shippingId": slectedAddressList.id,
                "cartId": cartId,
                "couponId": selectedCouponId
              }
            : {
                "amount": payPalAmount,
                "shippingId": slectedAddressList.id,
                "cartId": cartId,
              },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        paypalCartId = cartId;
        paypalUrl = response.last['url'];
        paypalSuccessUrl = response.last['successUrl'];
        paypalCancelUrl = response.last['cancelUrl'];

        orderId = response.last['orderId'];

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const CartPaypalScreen(),
        ));
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
      toast(
        context,
        title: "Bank server is busy. Please try again later",
        backgroundColor: Colors.red,
      );
    }
  }

  //validate payment
  Future paypalPaymentValidationFn(
      {required String paymentId,
      required String payerID,
      required BuildContext context,
      required WebViewController controller}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.cartPaypalValidation,
        data: {
          "payerId": payerID,
          "paymentId": paymentId,
          "payAmount": payPalAmount,
          "orderId": orderId,
          "cartId": paypalCartId
        },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        getCartFn();
        isWalletSelected = false;
        selectedPaymentIndex = -1;
        isCouponApplied = false;
        selectedCouponId = '';
        selectedPaymentIndexList.clear();
        successPopUp(
          image: AppImages.successmark,
          context: context,
          content: '''Payment has been \n successfully completed .''',
          title: 'Payment Success',
          ontap: () async {
            controller.clearCache();
            controller.clearLocalStorage();
            bool value = await controller.canGoBack();
            if (value) {
              controller.goBack();
            } else {
              context.pushNamed(AppRouter.tab);
            }
          },
        );
      } else {
        toast(
          context,
          title: "Bank server is busy. Please try again later",
          backgroundColor: Colors.red,
        );
        LoadingOverlay.of(context).hide();
      }
    } catch (e) {
      toast(
        context,
        title: "Bank server is busy. Please try again later",
        backgroundColor: Colors.red,
      );
      LoadingOverlay.of(context).hide();
    }

    notifyListeners();
  }
//**End */

  bool isWalletSelected = false;
  selectWalletFn(int index,
      {required int walletBalance, required int totalPrice}) {
    isWalletSelected = !isWalletSelected;
    if (isWalletSelected) {
      if (totalPrice <= walletBalance) {
        selectedPaymentIndexList.clear();
        selectedPaymentIndex = -1;
      }
    }

    notifyListeners();
  }

  //wallet payment

  Future walletPaymentFn({
    required BuildContext context,
    required String amount,
    required String cartId,
  }) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.walletPayUrl,
        data: isCouponApplied
            ? {
                "amount": amount,
                "shippingId": slectedAddressList.id,
                "cartId": cartId,
                "couponId": selectedCouponId
              }
            : {
                "amount": amount,
                "shippingId": slectedAddressList.id,
                "cartId": cartId,
              },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        getCartFn();
        isWalletSelected = false;
        selectedPaymentIndex = -1;
        isCouponApplied = false;
        selectedCouponId = '';
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const OrderSuccessScreen(),
        ));
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    }
  }

  bool isLoading = false;

  void setLoadingAdd(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
