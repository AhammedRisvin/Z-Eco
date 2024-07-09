import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/sections%20and%20details/view%20model/section_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/app_constants.dart';

class CommonFilterContainer extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final Color bgColor;
  final bool isFromColorsFilter;
  final bool isNewArrival;

  const CommonFilterContainer(
      {super.key,
      required this.onTap,
      required this.text,
      this.bgColor = Colors.amber,
      this.isFromColorsFilter = false,
      this.isNewArrival = false});

  @override
  Widget build(BuildContext context) {
    return Selector<SectionProvider, String>(
      selector: (p0, p1) => isNewArrival
          ? p1.selectedNewArrivaldataForUiUpdate
          : p1.selectedSortdataForUiUpdate,
      builder: (context, value, child) => CommonInkwell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          decoration: BoxDecoration(
            color: value != text
                ? const Color(0xFFDCE4F2)
                : const Color(0xff2F4EFF),
            border: Border.all(
              color: const Color(0xFFDCE4F2),
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: isFromColorsFilter
              ? Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.black38,
                        radius: 11,
                        child: CircleAvatar(
                          backgroundColor: bgColor,
                          radius: 10,
                        )),
                    const SizeBoxV(10),
                    CustomTextWidgets(
                      text: text,
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff8391A1),
                      ),
                    ),
                  ],
                )
              : CustomTextWidgets(
                  text: text,
                  textStyle: TextStyle(
                      fontSize: 15,
                      color: value != text
                          ? const Color(0xff8391A1)
                          : AppConstants.white),
                ),
        ),
      ),
    );
  }
}
