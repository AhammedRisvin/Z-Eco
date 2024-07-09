import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/loading_overlay.dart';
import 'package:zoco/app/modules/cart/view%20model/cart_provider.dart';
import 'package:zoco/app/modules/cart/view/your_cart.dart';

import '../../../utils/app_images.dart';

class CartPaypalScreen extends StatefulWidget {
  const CartPaypalScreen({super.key});

  @override
  State<CartPaypalScreen> createState() => _CartPaypalScreenState();
}

class _CartPaypalScreenState extends State<CartPaypalScreen> {
  String paypal = '';
  late WebViewController controller;
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          LoadingOverlay.of(context).show();
        },
        onPageFinished: (url) {
          LoadingOverlay.of(context).hide();
          for (var i = 0; i < 10; i++) {
            debugPrint('Page finished loading:   $url');
            debugPrint('Page finished loading:111   $url');
            if (url.startsWith(context.read<CartProvider>().paypalSuccessUrl)) {
              try {
                // The URL you want to parse
                final urlString = url;

                // Parse the URL
                final Uri uri = Uri.parse(urlString);

                // Extract the query parameters as a map
                final queryParams = uri.queryParameters;

                // Extract paymentId and PayerID values
                final paymentId = queryParams['paymentId'];
                final payerId = queryParams['PayerID'];

                // Print the extracted values
                debugPrint('paymentId: $paymentId');
                debugPrint('PayerID: $payerId');
                context.read<CartProvider>().paypalPaymentValidationFn(
                    context: context,
                    payerID: payerId.toString(),
                    paymentId: paymentId.toString(),
                    controller: controller);
              } catch (e) {
                debugPrint('Error occurred during upload: $e ');
              }

              break;
            } else if (url
                .startsWith(context.read<CartProvider>().paypalCancelUrl)) {
              successPopUp(
                image: AppImages.paymentFailed404,
                context: context,
                content:
                    '''Payment has been \n successfully added your Wallet .''',
                title: 'Payment Success',
                ontap: () async {
                  controller.clearCache();
                  controller.clearLocalStorage();
                  bool value = await controller.canGoBack();

                  if (value) {
                    controller.goBack();
                  } else {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const YourCartScreen()),
                    );
                  }
                },
              );
            }
          }
        },
      ))
      ..loadRequest(
        Uri.parse(context.read<CartProvider>().paypalUrl),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              bool value = await controller.canGoBack();
              if (value) {
                controller.goBack();
              } else {
                context.pop();
              }
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: CustomTextWidgets(
          text: 'Connect Paypal',
          textStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
