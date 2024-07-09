import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/sized_box.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../view model/section_provider.dart';

class DotListWidget extends StatelessWidget {
  final bool isProductDetails;
  final List<dynamic>? carousalBaanner;
  final List<String>? productDetailsImages;
  const DotListWidget(
      {super.key,
      this.isProductDetails = false,
      this.carousalBaanner,
      this.productDetailsImages});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 8,
        width: Responsive.width * 100,
        child: Selector<SectionProvider, int>(
            selector: (p0, p1) => p1.caroselPageChange,
            builder: (context, value, child) => Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return DotWidget(
                          color: value == index
                              ? isProductDetails == true
                                  ? AppConstants.appPrimaryColor
                                  : context.watch<ThemeProvider>().isDarkMode ==
                                          true
                                      ? const Color(0xFFF9F9FB)
                                      : AppConstants.containerColor
                              : Colors.grey);
                    },
                    separatorBuilder: (context, index) => const SizeBoxV(8),
                    itemCount: isProductDetails == true
                        ? productDetailsImages?.length ?? 0
                        : carousalBaanner?.length ?? 0,
                  ),
                )));
  }
}

class DotWidget extends StatelessWidget {
  final Color color;
  const DotWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  }
}
