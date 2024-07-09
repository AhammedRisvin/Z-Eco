import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/sections%20and%20details/view%20model/section_provider.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../theme/theme_provider.dart';
import '../../../utils/app_constants.dart';
import '../../sections and details/widgets/product_filter_shimmer_widget.dart';
import '../widget/brand_section.dart';
import '../widget/color_section.dart';
import '../widget/gender_section.dart';
import '../widget/new_arrivals_section.dart';
import '../widget/price_section.dart';
import '../widget/rating_section.dart';
import '../widget/size_section.dart';
import '../widget/sort_by_section.dart';

class FilterScreen extends StatefulWidget {
  final String? subCategory;
  const FilterScreen({super.key, this.subCategory});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  SectionProvider? filterProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      filterProvider = context.read<SectionProvider>();
      filterProvider?.getProductFilterDataFn(widget.subCategory.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        context.read<SectionProvider>().selectedBrandListt.clear();
        context.read<SectionProvider>().clearSelectedFiltrartiopns();
        context
            .read<SectionProvider>()
            .getProductProductsFn(catagoryId: widget.subCategory ?? "");
        context.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomTextWidgets(
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  color: context.watch<ThemeProvider>().isDarkMode == true
                      ? AppConstants.white
                      : AppConstants.black,
                  fontWeight: FontWeight.w500,
                ),
            text: "Filters",
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<SectionProvider>().selectedBrandListt.clear();
                context.read<SectionProvider>().clearSelectedFiltrartiopns();
                context
                    .read<SectionProvider>()
                    .getProductProductsFn(catagoryId: widget.subCategory ?? "");
                context.pop();
              },
              child: CustomTextWidgets(
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xff2F4EFF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                text: "Close",
              ),
            ),
            SizeBoxV(Responsive.width * 1)
          ],
        ),
        body: SizedBox(
          height: Responsive.height * 100,
          width: Responsive.width * 100,
          child: Selector<SectionProvider, int>(
            selector: (p0, p1) => p1.index,
            builder: (context, value, child) => value == 0
                ? const ProductFilterShimmerWidget()
                : Consumer<SectionProvider>(
                    builder: (context, value, child) => Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: ListView.builder(
                              itemCount: filterProvider?.filterOptions.length,
                              itemBuilder: (context, index) {
                                String title =
                                    filterProvider?.filterOptions[index] ?? '';
                                return Selector<SectionProvider, int>(
                                  selector: (p0, p1) => p1.selectedIndex,
                                  builder: (context, filterProvider, child) =>
                                      ListTile(
                                    tileColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    title: CustomTextWidgets(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 15,
                                            color: context
                                                        .watch<ThemeProvider>()
                                                        .isDarkMode ==
                                                    true
                                                ? AppConstants.white
                                                : AppConstants.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      text: title,
                                    ),
                                    onTap: () {
                                      context
                                          .read<SectionProvider>()
                                          .selectedOption(index);
                                    },
                                    selected:
                                        index == filterProvider ? true : false,
                                    selectedTileColor: context
                                                .watch<ThemeProvider>()
                                                .isDarkMode ==
                                            true
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
                                  ? FilterPriceSection(
                                      sectionProvider: filterProvider)
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
                                                      filterProvider:
                                                          filterProvider,
                                                    )
                                                  : data == 5
                                                      ? ColorSectionWidget(
                                                          filterProvider:
                                                              filterProvider,
                                                        )
                                                      : data == 6
                                                          ? NewArrivalsSection(
                                                              filterProvider:
                                                                  filterProvider,
                                                            )
                                                          : SortBySection(
                                                              filterProvider:
                                                                  filterProvider,
                                                            ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        bottomNavigationBar: Container(
          height: Responsive.height * 11.5,
          width: Responsive.width * 100,
          padding: const EdgeInsets.all(15),
          child: Align(
            alignment: Alignment.centerRight,
            child: CommonInkwell(
              onTap: () {
                context.read<SectionProvider>().productFilterFun(
                    categor: widget.subCategory ?? '', context: context);
              },
              child: Container(
                width: Responsive.width * 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff2F4EFF),
                ),
                child: const Center(
                  child: CustomTextWidgets(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xffffffff),
                    ),
                    text: "Show Result",
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
