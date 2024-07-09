import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/loading_overlay.dart';
import 'package:zoco/app/modules/cart/view/your_cart.dart';

import '../../../utils/app_images.dart';
import '../view_model/flicks_controller.dart';

class FlicksPaypalScreen extends StatefulWidget {
  const FlicksPaypalScreen({super.key});

  @override
  State<FlicksPaypalScreen> createState() => _FlicksPaypalScreenState();
}

class _FlicksPaypalScreenState extends State<FlicksPaypalScreen> {
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
            if (url.startsWith(
                context.read<FlicksController>().paypalSuccessUrl)) {
              try {
                final urlString = url;
                final Uri uri = Uri.parse(urlString);
                final queryParams = uri.queryParameters;
                final paymentId = queryParams['paymentId'];
                final payerId = queryParams['PayerID'];
                context.read<FlicksController>().paypalPaymentValidationFn(
                      context: context,
                      payerID: payerId.toString(),
                      paymentId: paymentId.toString(),
                      controller: controller,
                    );
              } catch (e) {
                debugPrint('Error occurred during upload: $e ');
              }

              break;
            } else if (url
                .startsWith(context.read<FlicksController>().paypalCancelUrl)) {
              successPopUp(
                image: AppImages.paymentFailed404,
                context: context,
                content: 'successfully subscribed Flicks',
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
        Uri.parse(context.read<FlicksController>().paypalUrl),
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
