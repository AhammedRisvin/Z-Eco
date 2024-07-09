import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';

class ReviewUserCaptureProductimageWidget extends StatelessWidget {
  final String? reviewImage;
  const ReviewUserCaptureProductimageWidget({super.key, this.reviewImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
          color: context.watch<ThemeProvider>().isDarkMode == true
              ? AppConstants.containerColor
              : const Color(0xFFF9F9FB),
          borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        clipBehavior: Clip.antiAlias,
        child: Image.network(fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            AppImages.paymentFailed404,
            fit: BoxFit.fill,
          );
        }, reviewImage ?? ""),
      ),
    );
  }
}
