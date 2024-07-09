import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/view%20model/section_provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import 'common_filter_container.dart';

class SortBySection extends StatefulWidget {
  const SortBySection({
    super.key,
    required this.filterProvider,
  });

  final SectionProvider? filterProvider;

  @override
  State<SortBySection> createState() => _SortBySectionState();
}

class _SortBySectionState extends State<SortBySection> {
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
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            text: "Sort By",
          ),
          SizeBoxH(
            Responsive.height * 2,
          ),
          Wrap(
            spacing: Responsive.width * 3.5,
            runSpacing: Responsive.height * 1.5,
            children: widget.filterProvider!.sortBy.map((text) {
              return IntrinsicWidth(
                child: CommonFilterContainer(
                  onTap: () {
                    context.read<SectionProvider>().selecteSortByFn(text);
                  },
                  text: text,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
