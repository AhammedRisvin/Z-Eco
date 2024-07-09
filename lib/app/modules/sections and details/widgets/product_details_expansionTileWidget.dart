import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';

import '../../../helpers/common_widgets.dart';
import '../../../theme/theme_provider.dart';
import '../../../utils/app_images.dart';

class ExpansionTileWidget extends StatelessWidget {
  final bool value;
  final String title;
  final String subText;
  final String? imageUrl;
  final bool isFromBrandInfo;
  final void Function(bool)? onExpansionChanged;
  const ExpansionTileWidget({
    super.key,
    required this.value,
    required this.title,
    required this.subText,
    required this.onExpansionChanged,
    this.imageUrl,
    required this.isFromBrandInfo,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      childrenPadding: EdgeInsets.zero,
      tilePadding: EdgeInsets.zero,
      expandedAlignment: Alignment.topLeft,
      title: isFromBrandInfo
          ? Row(
              children: [
                CachedImageWidget(
                  imageUrl: imageUrl?.isEmpty == true || imageUrl == null
                      ? "https://images.unsplash.com/photo-1709625862206-84f82e0754a8?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8fA=="
                      : imageUrl ??
                          'https://images.unsplash.com/photo-1709625862206-84f82e0754a8?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8NXx8fGVufDB8fHx8fA==',
                  height: 25,
                  width: 25,
                  borderRadius: BorderRadius.circular(100),
                ),
                const SizeBoxV(10),
                CustomTextWidgets(
                  text: title,
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            )
          : CustomTextWidgets(
              text: title,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
            ),
      onExpansionChanged: onExpansionChanged,
      trailing: Image.asset(
        AppImages.arrowDownIcon,
        height: 20,
        width: 20,
        color: context.watch<ThemeProvider>().isDarkMode == true
            ? Colors.white
            : Colors.black,
      ),
      initiallyExpanded: value,
      children: <Widget>[
        Text(
          subText,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xff8391A1),
              ),
        ),
      ],
    );
  }
}
