import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/modules/orders/view%20model/order_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../../cart/widget/cartproduct_details_screen.dart';

class CancelOrderScreen extends StatefulWidget {
  const CancelOrderScreen({super.key});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  OrderProvider? orderProvider;

  @override
  void initState() {
    super.initState();
    orderProvider = context.read<OrderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        context.read<OrderProvider>().isReturnedTrueFnc(value: false);
        context.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leadingWidth: 1,
          leading: const SizedBox.shrink(),
          flexibleSpace: Selector<OrderProvider, bool>(
              selector: (p0, p1) => p1.isReturnedTrue,
              builder: (context, value, child) {
                return CustomAppBarWidget(
                  isLeadingIconBorder: true,
                  title: value ? 'Return order' : 'Cancel order',
                );
              }),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          height: Responsive.height * 100,
          width: Responsive.width * 100,
          child: SingleChildScrollView(
            child: Consumer<OrderProvider>(builder: (context, value, child) {
              return Column(
                children: [
                  SizeBoxH(Responsive.height * 4),
                  CartProductDetailsContainer(
                    isFromOrders: true,
                    isFromOrderDetails: true,
                    singleCartData: orderProvider?.cancelProduct.first,
                  ),
                  SizeBoxH(Responsive.height * 4),
                  CommonInkwell(
                    onTap: () {},
                    child: Container(
                      height: Responsive.height * 6,
                      width: Responsive.width * 100,
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width * 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppConstants.appMainGreyColor),
                        color: context.watch<ThemeProvider>().isDarkMode == true
                            ? AppConstants.containerColor
                            : const Color(0xffffffff),
                      ),
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          value.isReturnedTrue
                              ? "Return reason (optional)"
                              : 'Cancellation reason (optional)',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color:
                                    context.watch<ThemeProvider>().isDarkMode ==
                                            true
                                        ? const Color(0xffffffff)
                                        : AppConstants.appPrimaryColor,
                              ),
                        ),
                        items: [
                          'Order Created by Mistake',
                          'Item(s)  Would Not Arrived on Time',
                          'Shipping Cost Too High',
                          'Item Price Too High',
                          'Found Cheaper Somewhere Else',
                          'Need to Change Shipping Address',
                          'Need to Change Payment Method',
                          'Other',
                        ].map((String reason) {
                          return DropdownMenuItem<String>(
                            value: reason,
                            child: Text(reason),
                          );
                        }).toList(),
                        value: orderProvider?.selectedCancellationReason,
                        onChanged: (String? value) {
                          orderProvider?.updateCancellationReason(value);
                        },
                      ),
                    ),
                  ),
                  value.selectedCancellationReason == 'Other'
                      ? Column(
                          children: [
                            SizeBoxH(Responsive.height * 2),
                            CustomTextFormFieldWidget(
                              controller: orderProvider?.otherReasonCntrlr,
                              hintText: '',
                              maxLines: 5,
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  SizeBoxH(Responsive.height * 4),
                  CommonButton(
                    btnName:
                        value.isReturnedTrue ? "Return Order" : "Cancel Item",
                    ontap: () {
                      if (value.selectedCancellationReason == 'Other') {
                        value.updateCancellationReason(
                            value.otherReasonCntrlr.text);
                        context
                            .pushNamed(AppRouter.returnPaymentSelectingScreen);
                      } else {
                        context
                            .pushNamed(AppRouter.returnPaymentSelectingScreen);
                      }
                    },
                    bgColor: const Color(0xffEB002B),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
