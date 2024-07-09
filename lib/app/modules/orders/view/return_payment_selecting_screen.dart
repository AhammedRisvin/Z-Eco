import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/orders/view%20model/order_provider.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/common_widgets.dart';
import '../../../theme/theme_provider.dart';

class ReturnPaymentSelectingScreen extends StatefulWidget {
  const ReturnPaymentSelectingScreen({super.key});

  @override
  State<ReturnPaymentSelectingScreen> createState() =>
      _ReturnPaymentSelectingScreenState();
}

class _ReturnPaymentSelectingScreenState
    extends State<ReturnPaymentSelectingScreen> {
  OrderProvider? orderProvider;
  @override
  void initState() {
    super.initState();
    orderProvider = context.read<OrderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: '',
          onTap: () {
            context.pop();
            context.read<OrderProvider>().isReturnedTrueFnc(value: false);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        height: Responsive.height * 100,
        width: Responsive.width * 100,
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 2),
            ReturnPaymentSelectingContainer(
              onTap: () {},
            ),
            SizeBoxH(Responsive.height * 2),
            ReturnPaymentSelectingContainer(
              isFromSelectingPayment: true,
              onTap: () {
                orderProvider?.changePaymentOption(true);
              },
            ),
            SizeBoxH(Responsive.height * 2),
            ReturnPaymentSelectingContainer(
              isFromSelectingPayment: true,
              isFromBankOption: true,
              onTap: () {
                orderProvider?.changePaymentOption(false);
              },
            ),
            SizeBoxH(Responsive.height * 4),
            CommonButton(
              btnName: "Continue",
              ontap: () {
                if (orderProvider?.isBankSelected == true) {
                  context.pushNamed(AppRouter.bankDetailsScreen);
                } else {
                  if (orderProvider?.isReturnedTrue == true) {
                    orderProvider?.returnOrder(
                        context: context,
                        bookingId:
                            '${orderProvider?.cancelProduct.first.bookingId}',
                        productId:
                            '${orderProvider?.cancelProduct.first.productId}',
                        reason: '${orderProvider?.selectedCancellationReason}',
                        sizeId: '${orderProvider?.cancelProduct.first.sizeId}',
                        isWallet: true);
                  } else {
                    orderProvider?.cancelOrderFnc(
                        context: context,
                        bookingId:
                            '${orderProvider?.cancelProduct.first.bookingId}',
                        productId:
                            '${orderProvider?.cancelProduct.first.productId}',
                        reason: '${orderProvider?.selectedCancellationReason}',
                        sizeId: '${orderProvider?.cancelProduct.first.sizeId}',
                        isWallet: true);
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class ReturnPaymentSelectingContainer extends StatelessWidget {
  final bool isFromSelectingPayment;
  final bool isFromBankOption;
  final void Function() onTap;

  const ReturnPaymentSelectingContainer({
    super.key,
    this.isFromSelectingPayment = false,
    this.isFromBankOption = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = context.read<OrderProvider>();
    return Selector<OrderProvider, bool>(
      selector: (p0, p1) => p1.isBankSelected,
      builder: (context, value, _) {
        return CommonInkwell(
          onTap: onTap,
          child: Container(
            height: Responsive.height * 6,
            width: Responsive.width * 100,
            padding: EdgeInsets.symmetric(horizontal: Responsive.width * 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isFromSelectingPayment
                  ? context.watch<ThemeProvider>().isDarkMode == true
                      ? AppConstants.containerColor
                      : const Color(0xffffffff)
                  : context.watch<ThemeProvider>().isDarkMode == true
                      ? AppConstants.containerColor
                      : const Color(0xffEEF2FF),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    isFromSelectingPayment
                        ? isFromBankOption
                            ? Image.asset(
                                AppImages.refundToBank,
                                height: 20,
                                color:
                                    context.watch<ThemeProvider>().isDarkMode ==
                                            true
                                        ? const Color(0xffffffff)
                                        : const Color(0x33333333),
                              )
                            : Image.asset(
                                AppImages.refundToWallet,
                                height: 20,
                                color:
                                    context.watch<ThemeProvider>().isDarkMode ==
                                            true
                                        ? const Color(0xffffffff)
                                        : const Color(0x33333333),
                              )
                        : CustomTextWidgets(
                            textStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                            textAlign: TextAlign.center,
                            text: "Total Amount",
                          ),
                    isFromSelectingPayment
                        ? isFromBankOption
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomTextWidgets(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                  textAlign: TextAlign.center,
                                  text: "Refund your wallet",
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomTextWidgets(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                  textAlign: TextAlign.center,
                                  text: "Refund your Bank",
                                ),
                              )
                        : IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 22,
                            ),
                          ),
                  ],
                ),
                isFromSelectingPayment
                    ? isFromBankOption
                        ? CircleAvatar(
                            radius: 12,
                            backgroundColor: AppConstants.appPrimaryColor,
                            child: CircleAvatar(
                              radius: 10,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: orderProvider.isBankSelected
                                    ? AppConstants.white
                                    : AppConstants.appPrimaryColor,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 12,
                            backgroundColor: AppConstants.appPrimaryColor,
                            child: CircleAvatar(
                              radius: 10,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: orderProvider.isBankSelected
                                    ? AppConstants.appPrimaryColor
                                    : AppConstants.white,
                              ),
                            ),
                          )
                    : CustomTextWidgets(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                        textAlign: TextAlign.center,
                        text:
                            "${orderProvider.ordersModel.currency}  ${orderProvider.ordersModel.currencySymbol}${orderProvider.cancelProduct.first.price?.toStringAsFixed(2)}",
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
