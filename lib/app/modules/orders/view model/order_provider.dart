import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:zoco/app/backend/urls.dart';
import 'package:zoco/app/modules/cart/model/get_cart_model.dart';
import 'package:zoco/app/modules/orders/model/order_product_details.dart'
    as Info;
import 'package:zoco/app/modules/orders/model/order_product_details.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../backend/server_client_services.dart';
import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_images.dart';
import '../../../utils/enums.dart';
import '../model/order_model.dart';
import '../model/order_product_details.dart' as Info;

class OrderProvider extends ChangeNotifier {
  TextEditingController fullNameCntrlr = TextEditingController();
  TextEditingController accountNumberCntrlr = TextEditingController();
  TextEditingController ifscCodeCntrlr = TextEditingController();
  TextEditingController branchNameCntrlr = TextEditingController();
  TextEditingController otherReasonCntrlr = TextEditingController();

  OrdersModel ordersModel = OrdersModel();

  int activeStep = 1;

  void goToStep(int step) {
    activeStep = step;
    notifyListeners();
  }

  //dropdown order cancel

  String? selectedCancellationReason;

  void updateCancellationReason(String? reason) {
    selectedCancellationReason = reason;
    notifyListeners(); // Notify listeners about the change
  }

  //select payment

  int itemLength = 0;

  itemLengthFnc({int? value}) {
    itemLength = value ?? 0;
  }

  bool isBankSelected = false;

  void changePaymentOption(bool option) {
    isBankSelected = option;
    notifyListeners();
  }

  List<Cart> cancelProduct = <Cart>[];

  void canceledOrderFn({String? bookingId}) {
    cancelProduct.clear();
    cancelProduct = ordersModel.response!
        .where((plan) => plan.bookingId == bookingId)
        .toList();
    notifyListeners();
  }

  bool isReturnedTrue = false;

  isReturnedTrueFnc({required bool value}) {
    isReturnedTrue = value;
    notifyListeners();
  }

  String formatSpecialDate(DateTime dateTime) {
    // Format the day with 'dd' to get the day number with leading zeros
    final day = DateFormat('dd').format(dateTime);

    // Determine the suffix for the day (st, nd, rd, th)
    final suffix = _getDaySuffix(int.parse(day));

    // Format the month to get its abbreviation in lowercase
    final month = DateFormat('MMM').format(dateTime).toLowerCase();

    // Format the year to get only the last two digits
    final year = DateFormat('yy').format(dateTime);

    // Format the date in the desired format
    return '${DateFormat('E').format(dateTime)}, $day$suffix $month ‘$year';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String convertUtcToLocalDeliveryDate(String utcDateString) {
    // Parse the UTC date string to a DateTime object
    DateTime utcDateTime = DateTime.parse(utcDateString);

    // Convert UTC DateTime to local DateTime
    DateTime localDateTime = utcDateTime.toLocal();

    // Format the local DateTime to the desired format
    DateFormat formatter = DateFormat('MMM d');
    String formattedDate = formatter.format(localDateTime);

    // Return the final string
    return ' on $formattedDate';
  }

  List<Info.Info> deliveryList = <Info.Info>[];

  /* ...........................Order API  Integration....................... */

  /*.............. Get All Orders............ */
  GetCartStatus getCartStatus = GetCartStatus.initial;

  Future getOrdersf({
    required String ordersMode,
    required BuildContext context,
  }) async {
    getCartStatus = GetCartStatus.loading;
    notifyListeners();
    try {
      ordersModel = OrdersModel();
      List response = await ServerClient.get(Urls.getAllOrdersUrl + ordersMode);
      if (response.first >= 200 && response.first < 300) {
        ordersModel = OrdersModel.fromJson(response.last);
        getCartStatus = GetCartStatus.loaded;
      } else {
        getCartStatus = GetCartStatus.error;
        ordersModel = OrdersModel();
      }
    } catch (e) {
      getCartStatus = GetCartStatus.error;
      ordersModel = OrdersModel();
    } finally {
      getCartStatus = GetCartStatus.loaded;
      notifyListeners();
    }
  }

  /*.............. ReturnProdcut............ */

  Future cancelOrderFnc({
    required String bookingId,
    required String reason,
    required String productId,
    required String sizeId,
    required bool isWallet,
    required BuildContext context,
    String? fullName,
    String? accountNumber,
    String? ifscCode,
    String? branchName,
  }) async {
    try {
      List response = await ServerClient.post(
          '${Urls.cancelOrderUrl}isWallet=$isWallet',
          data: {
            'bookingId': bookingId,
            'reason': reason,
            'productId': productId,
            'sizeId': sizeId,
            'fullName': fullName,
            'accountNumber': accountNumber,
            'ifscCode': ifscCode,
            'branchName': branchName
          });

      if (response.first >= 200 && response.first < 300) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                height: Responsive.height * 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.successmark,
                      height: 100,
                      width: 100,
                    ),
                    const SizeBoxH(50),
                    CustomTextWidgets(
                      text: 'Order cancelled!',
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                height: 0.05,
                              ),
                    ),
                    const SizeBoxH(20),
                    CustomTextWidgets(
                      text: '''Your Order has been \nCancled successfully.''',
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                              color: const Color(0xFF8390A1),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                    ),
                    const SizeBoxH(20),
                    CommonButton(
                      btnName: "Back to order",
                      ontap: () {
                        context.goNamed(AppRouter.tab);
                        getOrdersf(ordersMode: 'Placed', context: context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  OrderDetailsStatus orderDetailsStatus = OrderDetailsStatus.initial;

  OrdersProductDetailModel orderPrdoct = OrdersProductDetailModel();
  Future getOrderProductDetailFnc(
      {required String bookingId,
      required String sizeId,
      required BuildContext context}) async {
    try {
      orderDetailsStatus = OrderDetailsStatus.loading;

      List response = await ServerClient.post(Urls.orderProdcutDetailsUrl,
          data: {'bookingId': bookingId, 'sizeId': sizeId});

      if (response.first >= 200 && response.first < 300) {
        orderPrdoct = OrdersProductDetailModel.fromJson(response.last);
        deliveryList = orderPrdoct.orderDatas?[0].shippingInfo ?? [];
        context.pushNamed(AppRouter.orderDetailsScreen,
            queryParameters: {'isACtive': 'isActive'});
        if (orderPrdoct.orderDatas![0].returnInfo!.isNotEmpty) {
          deliveryList = orderPrdoct.orderDatas?[0].returnInfo ?? [];
        }

        orderDetailsStatus = OrderDetailsStatus.loaded;
      } else {
        orderDetailsStatus = OrderDetailsStatus.error;
        orderPrdoct = OrdersProductDetailModel();
        deliveryList = [];
      }
    } catch (e) {
      orderDetailsStatus = OrderDetailsStatus.error;
      orderPrdoct = OrdersProductDetailModel();
      deliveryList = [];
    } finally {
      notifyListeners();
    }
  }

  Future returnOrder({
    required String bookingId,
    required String reason,
    required String productId,
    required String sizeId,
    required bool isWallet,
    required BuildContext context,
    String? fullName,
    String? accountNumber,
    String? ifscCode,
    String? branchName,
  }) async {
    try {
      List response = await ServerClient.post(
          '${Urls.returnProductUrl}?isWallet=$isWallet',
          data: {
            'bookingId': bookingId,
            'reason': reason,
            'productId': productId,
            'sizeId': sizeId,
            'fullName': fullName,
            'accountNumber': accountNumber,
            'iban': ifscCode,
            'bankName': branchName
          });
      if (response.first >= 200 && response.first < 300) {
        isReturnedTrueFnc(value: false);
        context.pushNamed(AppRouter.tab);
      } else {
        toast(context, backgroundColor: Colors.red, title: '${response.last}');
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  /* delivery details api*/

  Future deliveryDetails() async {
    try {
      List response = await ServerClient.get(Urls.addDetails);
      if (response.first >= 200 && response.first < 300) {}
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }
}
