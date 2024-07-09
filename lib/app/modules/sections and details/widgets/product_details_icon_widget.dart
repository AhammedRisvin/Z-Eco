import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';

class ProductDetailsIconWidget extends StatelessWidget {
  final IconData? icon;
  final Color iconColor;
  const ProductDetailsIconWidget({
    super.key,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: context.watch<ThemeProvider>().isDarkMode == true
            ? AppConstants.containerColor
            : AppConstants.white,
        borderRadius: BorderRadius.circular(50),
        border: Border(
          bottom: BorderSide(
            width: 3,
            color: Colors.black.withOpacity(.10),
          ),
        ),
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: 18,
        ),
      ),
    );
  }
}
