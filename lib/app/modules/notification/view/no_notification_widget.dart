import 'package:flutter/material.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/utils/app_images.dart';
import 'package:zoco/app/utils/extentions.dart';

class NoNotificationWidget extends StatelessWidget {
  const NoNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Responsive.width * 100,
      child: Column(
        children: [
          Image.asset(
            AppImages.noNotifications,
            height: 300,
            width: 300,
          ),
          CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 24,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
            text: 'No notifications',
          ),
          const SizeBoxH(10),
          CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(0xFF8390A1),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
            text:
                'You have no notifications yet.\n      Please come back later.',
          ),
          const SizeBoxH(15),
        ],
      ),
    );
  }
}
