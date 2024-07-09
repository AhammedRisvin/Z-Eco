import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../view model/order_provider.dart';

class OrderDetailsStepperScreen extends StatefulWidget {
  const OrderDetailsStepperScreen({super.key});

  @override
  State<OrderDetailsStepperScreen> createState() =>
      _OrderDetailsStepperScreenState();
}

class _OrderDetailsStepperScreenState extends State<OrderDetailsStepperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 1,
        leading: const SizedBox.shrink(),
        flexibleSpace: const CustomAppBarWidget(
          isLeadingIconBorder: true,
          title: 'Back',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<OrderProvider>(
          builder: (context, obj, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: obj.deliveryList.length,
                    itemBuilder: (context, index) {
                      final items = obj.deliveryList[index];
                      return StepperWidget(
                        text: items.status,
                        date: items.date,
                        subText: items.message,
                        length: obj.deliveryList.length,
                        index: index,
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class StepperWidget extends StatelessWidget {
  final String? text;
  final DateTime? date;
  final String? subText;
  final int length, index;
  const StepperWidget({
    this.date,
    this.subText,
    this.text,
    super.key,
    required this.length,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const CircleAvatar(
              radius: 15,
              backgroundColor: AppConstants.appPrimaryColor,
              child: Icon(
                Icons.check,
                color: AppConstants.white,
                size: 20,
              ),
            ),
            Visibility(
              visible: length != index + 1,
              child: SizedBox(
                height: Responsive.height * 10,
                child: const VerticalDivider(
                  color: AppConstants.appPrimaryColor,
                  thickness: 3,
                ),
              ),
            ),
          ],
        ),
        SizeBoxV(Responsive.width * 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: "${text ?? ""}  "),
                    TextSpan(
                      text: context
                          .read<OrderProvider>()
                          .formatSpecialDate(date ?? DateTime.now()),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff8391A1)),
                    ),
                  ],
                ),
              ),
              SizeBoxH(Responsive.width * 3),
              CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                maxLines: 3,
                text: subText ?? "",
              ),
            ],
          ),
        )
      ],
    );
  }
}
