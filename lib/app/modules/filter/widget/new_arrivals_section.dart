import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../../sections and details/view model/section_provider.dart';
import 'common_filter_container.dart';

class NewArrivalsSection extends StatelessWidget {
  const NewArrivalsSection({
    super.key,
    required this.filterProvider,
  });

  final SectionProvider? filterProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      height: Responsive.height * 100,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width * 2,
        vertical: Responsive.height * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomTextWidgets(
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            text: "New Arrivals",
          ),
          SizeBoxH(Responsive.height * 3),
          Wrap(
            spacing: Responsive.width * 3.5,
            runSpacing: Responsive.height * 1.5,
            children: filterProvider!.newArrivals.map((text) {
              return IntrinsicWidth(
                child: CommonFilterContainer(
                  onTap: () {
                    context.read<SectionProvider>().selecteNewArrivalsFn(text);
                  },
                  text: text,
                  isNewArrival: true,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
