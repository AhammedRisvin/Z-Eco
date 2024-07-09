import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/view%20model/section_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';

class FilterPriceSection extends StatelessWidget {
  const FilterPriceSection({
    super.key,
    required this.sectionProvider,
  });

  final SectionProvider? sectionProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      height: Responsive.height * 100,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width * 2,
        vertical: Responsive.height * 2,
      ),
      child: ListView.separated(
        itemCount: sectionProvider?.priceOption.length ?? 0,
        separatorBuilder: (context, index) {
          return SizeBoxH(Responsive.height * 2);
        },
        itemBuilder: (context, index) {
          String title = sectionProvider!.priceOption[index];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Selector<SectionProvider, String>(
                    selector: (p0, p1) => p1.selectedPrice,
                    builder: (context, value, child) => CommonInkwell(
                      onTap: () =>
                          context.read<SectionProvider>().selectePriceFn(title),
                      child: Container(
                        height: Responsive.height * 3,
                        width: Responsive.width * 6,
                        decoration: BoxDecoration(
                          color: value != title
                              ? Colors.transparent
                              : const Color(0xff4D9FFF),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: const Color(0xff4D9FFF), width: 1),
                        ),
                      ),
                    ),
                  ),
                  SizeBoxV(Responsive.width * 5),
                  CustomTextWidgets(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                    text: title,
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
