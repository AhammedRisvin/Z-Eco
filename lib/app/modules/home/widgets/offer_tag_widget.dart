import 'package:flutter/material.dart';

import '../../../helpers/common_widgets.dart';

class OfferTagWidget extends StatelessWidget {
  final num offer;
  const OfferTagWidget({super.key, this.offer = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 24,
      decoration: const ShapeDecoration(
        color: Color(0xFFDB3022),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
      ),
      child: Center(
        child: CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
            text: "$offer%"),
      ),
    );
  }
}
