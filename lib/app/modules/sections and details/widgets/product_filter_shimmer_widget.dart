import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/helpers/common_widgets.dart';

import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../filter/widget/brand_section.dart';
import '../../filter/widget/color_section.dart';
import '../../filter/widget/gender_section.dart';
import '../../filter/widget/new_arrivals_section.dart';
import '../../filter/widget/price_section.dart';
import '../../filter/widget/rating_section.dart';
import '../../filter/widget/size_section.dart';
import '../../filter/widget/sort_by_section.dart';
import '../view model/section_provider.dart';

class ProductFilterShimmerWidget extends StatelessWidget {
  const ProductFilterShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SectionProvider filterProvider = context.read<SectionProvider>();
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: filterProvider.filterOptions.length,
                itemBuilder: (context, index) {
                  String title = filterProvider.filterOptions[index];
                  return Selector<SectionProvider, int>(
                    selector: (p0, p1) => p1.selectedIndex,
                    builder: (context, filterProvider, child) => ListTile(
                      tileColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      title: CustomTextWidgets(
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                              fontSize: 15,
                              color:
                                  context.watch<ThemeProvider>().isDarkMode ==
                                          true
                                      ? AppConstants.white
                                      : AppConstants.black,
                              fontWeight: FontWeight.w600,
                            ),
                        text: title,
                      ),
                      onTap: () {
                        context.read<SectionProvider>().selectedOption(index);
                      },
                      selected: index == filterProvider ? true : false,
                      selectedTileColor:
                          context.watch<ThemeProvider>().isDarkMode == true
                              ? AppConstants.black
                              : AppConstants.white,
                    ),
                  );
                },
              ),
            ),
          ),
          Selector<SectionProvider, int>(
            selector: (p0, p1) => p1.selectedIndex,
            builder: (context, data, child) {
              return Expanded(
                flex: 2,
                child: data == 0
                    ? FilterPriceSection(sectionProvider: filterProvider)
                    : data == 1
                        ? BrandSectionWidget(
                            filterProvider: filterProvider,
                          )
                        : data == 2
                            ? const RatingSectionWidget()
                            : data == 3
                                ? const SizeSectionWidget()
                                : data == 4
                                    ? GenderSectionWidget(
                                        filterProvider: filterProvider,
                                      )
                                    : data == 5
                                        ? ColorSectionWidget(
                                            filterProvider: filterProvider,
                                          )
                                        : data == 6
                                            ? NewArrivalsSection(
                                                filterProvider: filterProvider,
                                              )
                                            : SortBySection(
                                                filterProvider: filterProvider,
                                              ),
              );
            },
          ),
        ],
      ),
    );
  }
}
