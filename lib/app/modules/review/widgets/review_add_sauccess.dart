import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_images.dart';

Future<dynamic> reviewAddedSuccessSheetFn(
    BuildContext context, String productId) {
  return showModalBottomSheet(
    isDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        context.pushReplacementNamed(AppRouter.allReviewScreen,
                            queryParameters: {"productId": productId});
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              Image.asset(
                AppImages.successmark,
                height: 100,
                width: 100,
              ),
              const SizeBoxH(50),
              CustomTextWidgets(
                textAlign: TextAlign.center,
                text: 'successfully added your \nReview',
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizeBoxH(20),
              CustomTextWidgets(
                textAlign: TextAlign.center,
                text: '''Your Review details will be on the\n review section''',
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xFF8390A1),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizeBoxH(20),
              CommonButton(
                btnName: "View",
                ontap: () {
                  context.pushReplacementNamed(AppRouter.allReviewScreen,
                      queryParameters: {"productId": productId});
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
