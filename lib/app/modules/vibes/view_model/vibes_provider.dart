import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zoco/app/backend/urls.dart';

import '../../../backend/server_client_services.dart';
import '../../../helpers/common_widgets.dart';
import '../../../utils/enums.dart';
import '../../cart/view model/cart_provider.dart';
import '../model/get_vibes_model.dart';

class VibesProvider extends ChangeNotifier {
  //GET VIBES START

  GetVibesStatus getVibesStatus = GetVibesStatus.initial;
  GetVibesModel getVibesData = GetVibesModel();

  Future<void> getVibesFn(String vibesCatagoryId, bool isFromCatagory) async {
    try {
      getVibesData = GetVibesModel();

      getVibesStatus = GetVibesStatus.loading;
      List response = await ServerClient.get(
        isFromCatagory
            ? Urls.getVibesUrlWithCatId + vibesCatagoryId
            : Urls.getVibesUrl + vibesCatagoryId,
      );

      if (response.first >= 200 && response.first < 300) {
        getVibesData = GetVibesModel.fromJson(response.last);

        getVibesStatus = GetVibesStatus.loaded;
        notifyListeners();
      } else {
        getVibesStatus = GetVibesStatus.error;
        getVibesData = GetVibesModel();
      }
    } catch (e) {
      getVibesStatus = GetVibesStatus.error;
      getVibesData = GetVibesModel();
    } finally {
      notifyListeners();
    }
  }

  bool isProductAddedToCart = false;

  Future addToCartFn({
    required BuildContext context,
    required String productId,
    required String sizeId,
  }) async {
    try {
      List response = await ServerClient.post(
        Urls.postAddToCartUrl,
        data: {
          "productId": productId,
          "sizeId": sizeId,
        },
      );

      if (response.first >= 200 && response.first < 300) {
        context.read<CartProvider>().getCartFn();

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

  void shareVibesUrl({required String vibesUrl, required String subject}) {
    Share.share(
      vibesUrl,
      subject: subject,
    );
  }
}
