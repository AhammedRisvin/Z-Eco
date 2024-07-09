import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/utils/app_constants.dart';

import '../../../helpers/common_widgets.dart';
import '../../../utils/extentions.dart';
import '../../home/widgets/product_search_and_cart_widget.dart';
import '../../sections and details/view model/section_provider.dart';

class BrandSectionWidget extends StatelessWidget {
  const BrandSectionWidget({
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
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductSearchAndCartWidget(
              onChange: (p0) => context
                  .read<SectionProvider>()
                  .filterBrandSearchFn(enteredKeyword: p0),
              onTap: () {},
              width: Responsive.width * 60,
              isFromFilter: true,
            ),
            SizeBoxH(Responsive.height * 2),
            Consumer<SectionProvider>(
              builder: (context, value, child) => ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizeBoxH(5);
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.productBrandShowListForFilter.length,
                  itemBuilder: (context, index) {
                    var data = value.productBrandShowListForFilter[index];
                    return CommonInkwell(
                      onTap: () => value.addAndRemoveBeand(data.id ?? ''),
                      child: Container(
                        height: 35,
                        color: value.selectedBrandListt.contains(data.id)
                            ? AppConstants.appPrimaryColor
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomTextWidgets(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 14),
                              text: data.name ?? '',
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
