import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/extentions.dart';

class ActiveSubShimmer extends StatelessWidget {
  const ActiveSubShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: Responsive.width * 100,
        height: Responsive.height * 40,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
      ),
    );
  }
}
