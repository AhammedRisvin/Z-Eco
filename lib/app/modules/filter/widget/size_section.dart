import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../../sections and details/model/get_filter_details_model.dart';
import '../../sections and details/view model/section_provider.dart';

class SizeSectionWidget extends StatelessWidget {
  const SizeSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      height: Responsive.height * 100,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width * 2,
        vertical: Responsive.height * 2,
      ),
      child: const ContainerList(),
    );
  }
}

class ContainerList extends StatelessWidget {
  const ContainerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidgets(
          textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
          text: "Sizes",
        ),
        SizeBoxH(Responsive.height * 2),
        Selector<SectionProvider, GetFilterDetailsModel>(
          selector: (p0, p1) => p1.getFilterDetailsModel,
          builder: (context, value, child) => value.sizes?.isNotEmpty ?? false
              ? Wrap(
                  spacing: Responsive.width * 3.5,
                  runSpacing: Responsive.height * 1.5,
                  children: value.sizes!.map((text) {
                    return CommonInkwell(
                      onTap: () => context
                          .read<SectionProvider>()
                          .addAndRemoveSize(text),
                      child: Consumer<SectionProvider>(
                        builder: (context, value, child) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8),
                          decoration: BoxDecoration(
                            color: value.selectedSizeList.contains(text)
                                ? const Color(0xff2F4EFF)
                                : const Color(0xFFDCE4F2),
                            border: Border.all(
                              color: const Color(0xFFDCE4F2),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: CustomTextWidgets(
                            text: text,
                            textStyle: TextStyle(
                                fontSize: 15,
                                color: value.selectedSizeList.contains(text)
                                    ? AppConstants.white
                                    : const Color(0xff8391A1)),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
