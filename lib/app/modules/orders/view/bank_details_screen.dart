import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/orders/view%20model/order_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  OrderProvider? orderProvider;
  @override
  void initState() {
    super.initState();
    orderProvider = context.read<OrderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          title: "Bank Details",
          isLeadingIconBorder: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizeBoxH(20),
              CustomTextWidgets(
                text: 'Full Name',
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
              ),
              const SizeBoxH(10),
              CustomTextFormFieldWidget(
                controller: orderProvider?.fullNameCntrlr,
                hintText: 'Full Name',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
              ),
              const SizeBoxH(20),
              CustomTextWidgets(
                text: 'Account Number',
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
              ),
              const SizeBoxH(10),
              CustomTextFormFieldWidget(
                controller: orderProvider?.accountNumberCntrlr,
                hintText: 'Account Number',
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizeBoxH(20),
              CustomTextWidgets(
                text: 'Bank Name',
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
              ),
              const SizeBoxH(10),
              CustomTextFormFieldWidget(
                controller: orderProvider?.branchNameCntrlr,
                hintText: 'Bank Name',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
              ),
              const SizeBoxH(20),
              CustomTextWidgets(
                text: 'IBan',
                textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
              ),
              const SizeBoxH(10),
              CustomTextFormFieldWidget(
                controller: orderProvider?.ifscCodeCntrlr,
                hintText: 'IBan',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
              ),
              const SizeBoxH(50),
              CommonButton(
                btnName: "Continue",
                ontap: () {
                  if (orderProvider?.isReturnedTrue == true) {
                    orderProvider?.returnOrder(
                        context: context,
                        bookingId:
                            '${orderProvider?.cancelProduct.first.bookingId}',
                        productId:
                            '${orderProvider?.cancelProduct.first.productId}',
                        reason: '${orderProvider?.selectedCancellationReason}',
                        sizeId: '${orderProvider?.cancelProduct.first.sizeId}',
                        isWallet: false,
                        accountNumber: orderProvider?.accountNumberCntrlr.text,
                        branchName: orderProvider?.branchNameCntrlr.text,
                        fullName: orderProvider?.fullNameCntrlr.text,
                        ifscCode: orderProvider?.ifscCodeCntrlr.text);
                  } else {
                    orderProvider?.cancelOrderFnc(
                        context: context,
                        bookingId:
                            '${orderProvider?.cancelProduct.first.bookingId}',
                        productId:
                            '${orderProvider?.cancelProduct.first.productId}',
                        reason: '${orderProvider?.selectedCancellationReason}',
                        sizeId: '${orderProvider?.cancelProduct.first.sizeId}',
                        isWallet: false,
                        accountNumber: orderProvider?.accountNumberCntrlr.text,
                        branchName: orderProvider?.branchNameCntrlr.text,
                        fullName: orderProvider?.fullNameCntrlr.text,
                        ifscCode: orderProvider?.ifscCodeCntrlr.text);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
