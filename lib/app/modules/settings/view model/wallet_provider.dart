import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoco/app/modules/settings/model/wallet_history_model.dart';
import 'package:zoco/app/utils/enums.dart';

import '../../../backend/server_client_services.dart';
import '../../../backend/urls.dart';
import '../../../helpers/common_widgets.dart';
import '../../../helpers/loading_overlay.dart';
import '../../../utils/app_images.dart';
import '../view/wallet/paypal_webview_screen.dart';

class WalletProvider extends ChangeNotifier {
  TextEditingController enterAmountController = TextEditingController();
//wallet payment selection

  int selectedPaymentIndex = -1;

  void setSelectedIndex(int index) {
    selectedPaymentIndex = index;

    notifyListeners();
  }

//add amount to wallet

  bool addAmountToWallet = true;

  void addAmountToWalletFn(bool value) {
    addAmountToWallet = value;
    notifyListeners();
  }

//**Stripe Payment Start */

  String paymentIntentId = '';
  Future createStripeFn({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.createStripe,
        data: {"amount": enterAmountController.text},
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        paymentIntentId = response.last['clientSecret'];

        makeStripePayment(context: context);
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    }
  }

  Future<void> makeStripePayment({required BuildContext context}) async {
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
          await paymentValidationFn(clintId: paymentIntentId, context: context);
        });
      } on Exception catch (e) {
        if (e is StripeException) {
          debugPrint('Error occurred during upload: $e ');
        } else {
          debugPrint('Error occurred during upload: $e ');
        }
      } catch (e) {
        LoadingOverlay.of(context).hide();
        debugPrint('Error occurred during upload: $e ');
      }
    } catch (err) {
      LoadingOverlay.of(context).hide();
    }
  }

  //validate payment
  Future paymentValidationFn(
      {required clintId, required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.walletStripeValidation,
        data: {
          "clientSecret": clintId,
        },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        LoadingOverlay.of(context).hide();
        enterAmountController.clear();
        successPopUp(
          image: AppImages.successmark,
          context: context,
          content: '''Payment has been \n successfully added your Wallet .''',
          title: 'Payment Success',
          ontap: () {
            getWalletHistoryFn();
            Navigator.of(context).pop();
          },
        );
      } else {
        enterAmountController.clear();
        LoadingOverlay.of(context).hide();
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    } finally {
      notifyListeners();
    }
  }

//**End */

//**Get Wallet Payment History */
  GetWalletHistorystatus walletHistorystatus = GetWalletHistorystatus.initial;
  GetWalletHistoryModel getWalletHistoryModel =
      GetWalletHistoryModel(message: '', walletAmount: 0, walletData: []);
  Future getWalletHistoryFn() async {
    try {
      getWalletHistoryModel =
          GetWalletHistoryModel(message: '', walletAmount: 0, walletData: []);
      walletHistorystatus = GetWalletHistorystatus.loading;
      List response = await ServerClient.get(
        Urls.getWalletHistory,
      );

      if (response.first >= 200 && response.first < 300) {
        getWalletHistoryModel = GetWalletHistoryModel.fromJson(response.last);
        walletHistorystatus = GetWalletHistorystatus.loaded;
      } else {
        walletHistorystatus = GetWalletHistorystatus.error;
        getWalletHistoryModel =
            GetWalletHistoryModel(message: '', walletAmount: 0, walletData: []);
      }
    } catch (e) {
      getWalletHistoryModel =
          GetWalletHistoryModel(message: '', walletAmount: 0, walletData: []);
      walletHistorystatus = GetWalletHistorystatus.error;
    } finally {
      notifyListeners();
    }
    notifyListeners();
  }

  String convertUtcToLocalDateTime(String utcString) {
    DateTime dateTime = DateTime.parse(utcString).toLocal();

    String formattedDate = DateFormat("MMMM d y HH:mm").format(dateTime);
    print(formattedDate);
    return formattedDate;
  }
//**End */

//** Paypal Payment Start */

  String paypalUrl = '';
  String paypalSuccessUrl = '';
  String paypalCancelUrl = '';
  Future createPaypalFn({required BuildContext context}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.walletPaypal,
        data: {"amount": enterAmountController.text},
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        isCompleted = false;
        notifyListeners();
        LoadingOverlay.of(context).hide();
        paypalUrl = response.last['url'];
        paypalSuccessUrl = response.last['successUrl'];
        paypalCancelUrl = response.last['cancelUrl'];

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ConnectPaypalScreen(),
        ));
      } else {
        LoadingOverlay.of(context).hide();
        toast(context, title: response.last, backgroundColor: Colors.red);
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    }
  }

  //validate payment
  bool isCompleted = false;
  Future paypalPaymentValidationFn(
      {required String paymentId,
      required String payerID,
      required BuildContext context,
      required WebViewController controller}) async {
    try {
      LoadingOverlay.of(context).show();
      List response = await ServerClient.post(
        Urls.walletPaypalValidation,
        data: {
          "payerId": payerID,
          "paymentId": paymentId,
          "payAmount": enterAmountController.text
        },
        post: true,
      );

      if (response.first >= 200 && response.first < 300) {
        successPopUp(
          image: AppImages.successmark,
          context: context,
          content: '''Payment has been \n successfully added your Wallet .''',
          title: 'Payment Success',
          ontap: () async {
            isCompleted = true;
            paypalSuccessUrl = '';
            notifyListeners();
            enterAmountController.clear();
            controller.clearCache();
            controller.clearLocalStorage();

            bool? value;

            value = await controller.canGoBack();
            await getWalletHistoryFn();
            if (value == true) {
              controller.goBack();
            } else {
              Navigator.of(context).pop();
            }
          },
        );
      } else {
        LoadingOverlay.of(context).hide();
      }
    } catch (e) {
      LoadingOverlay.of(context).hide();
    } finally {
      notifyListeners();
    }
  }
//**End */
}
