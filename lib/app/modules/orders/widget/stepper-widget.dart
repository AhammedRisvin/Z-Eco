import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../view model/order_provider.dart';

class StepperWidget extends StatefulWidget {
  final int? orderStatus;
  const StepperWidget({
    this.orderStatus,
    super.key,
  });

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, stepperModel, _) => EasyStepper(
        activeStep: widget.orderStatus ?? 0,
        lineStyle: LineStyle(
          lineLength: Responsive.width * 14,
          activeLineColor: AppConstants.appPrimaryColor,
          lineType: LineType.normal,
          finishedLineColor: AppConstants.appPrimaryColor,
          lineThickness: 3,
          unreachedLineColor: const Color(0xffC7D5FF),
        ),
        activeStepTextColor: context.watch<ThemeProvider>().isDarkMode == true
            ? const Color(0xffffffff)
            : AppConstants.black,
        finishedStepTextColor: context.watch<ThemeProvider>().isDarkMode == true
            ? const Color(0xffffffff)
            : AppConstants.black,
        internalPadding: 0,
        showLoadingAnimation: false,
        stepRadius: 8,
        showStepBorder: false,
        unreachedStepTextColor: AppConstants.appMainGreyColor,
        steps: List.generate(
          stepperModel.deliveryList.length,
          (index) => EasyStep(
              customStep: CircleAvatar(
                radius: 10,
                backgroundColor: stepperModel.activeStep >= 0
                    ? AppConstants.appPrimaryColor
                    : const Color(0xffC7D5FF),
                child: const Icon(
                  Icons.check,
                  color: AppConstants.white,
                  size: 10,
                ),
              ),
              title: stepperModel.deliveryList[index].status,
              topTitle: index.isOdd),
        ),
        onStepReached: (index) =>
            stepperModel.goToStep(stepperModel.deliveryList.length),
      ),
    );
  }
}
