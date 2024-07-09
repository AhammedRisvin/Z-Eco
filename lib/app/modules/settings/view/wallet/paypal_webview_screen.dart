import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/loading_overlay.dart';
import 'package:zoco/app/modules/settings/view%20model/wallet_provider.dart';

import '../../../../utils/app_images.dart';

class ConnectPaypalScreen extends StatefulWidget {
  const ConnectPaypalScreen({super.key});

  @override
  State<ConnectPaypalScreen> createState() => _ConnectPaypalScreenState();
}

class _ConnectPaypalScreenState extends State<ConnectPaypalScreen> {
  bool isCompleted = false;
  String paypal = '';
  late WebViewController controller;
  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            isCompleted = false;
          });
          LoadingOverlay.of(context).show();
        },
        onUrlChange: (change) {},
        onPageFinished: (url) async {
          LoadingOverlay.of(context).hide();
          for (var i = 0; i < 5; i++) {
            debugPrint('Page finished loading:   $url');
            debugPrint('Page finished loading:111   $url');
            if (url
                .startsWith(context.read<WalletProvider>().paypalSuccessUrl)) {
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

                if (isCompleted == false) {
                  setState(() {
                    isCompleted = true;
                  });
                  await context
                      .read<WalletProvider>()
                      .paypalPaymentValidationFn(
                          context: context,
                          payerID: payerId ?? '',
                          paymentId: paymentId ?? '',
                          controller: controller);

                  break;
                }
              } catch (e) {
                debugPrint('Error occurred during upload: $e ');
              }

              break;
            } else if (url
                .startsWith(context.read<WalletProvider>().paypalCancelUrl)) {
              // toast(context)

              successPopUp(
                image: AppImages.paymentFailed404,
                context: context,
                content: '''.''',
                title: 'Payment Failed',
                ontap: () async {
                  controller.clearCache();
                  controller.clearLocalStorage();
                  bool? value;

                  value = await controller.canGoBack();

                  if (value == true) {
                    controller.goBack();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              );
            }
          }
        },
      ))
      ..loadRequest(
        Uri.parse(context.read<WalletProvider>().paypalUrl),
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
