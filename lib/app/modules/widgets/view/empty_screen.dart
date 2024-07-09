import 'package:flutter/material.dart';

import '../../../utils/extentions.dart';

class EmptyScreenWidget extends StatelessWidget {
  final String text;
  final String image;
  final double? height;
  const EmptyScreenWidget(
      {super.key,
      required this.text,
      required this.image,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: Responsive.width * 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: Responsive.height * 25,
            width: Responsive.width * 25,
          ),
          // const SizeBoxH(10),
          Text(
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
          ),
        ],
      ),
    );
  }
}
