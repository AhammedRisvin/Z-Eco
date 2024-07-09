import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/sections%20and%20details/model/get_secdtion_homescreen_model.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../widgets/view/category_circle_widget.dart';
import '../view model/section_provider.dart';

class CategoryListWidget extends StatelessWidget {
  final void Function()? onTap;
  final String? categoryid;
  const CategoryListWidget({super.key, this.onTap, required this.categoryid});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeRight: true,
      removeBottom: true,
      child: SizedBox(
        height: Responsive.height * 12,
        // height: Responsive.height * 10,
        child: Selector<SectionProvider, GetSectionHomeModel>(
          selector: (p0, p1) => p1.getSectionHomeScreenModel,
          builder: (context, value, child) {
            return value.categories.isListNullOrEmpty()
                ? const SizedBox.shrink()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizeBoxV(15),
                    itemCount: value.categories?.length ?? 0,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final fashionCatagoryDetails = value.categories?[index];
                      return CategoryCircleTabWidget(
                        name: fashionCatagoryDetails?.name ?? '',
                        imageUrl: fashionCatagoryDetails?.image,
                        onTap: () {
                          context.read<SectionProvider>().getCategoryId2Fun(
                              fashionCatagoryDetails?.id ?? '');
                          context.read<SectionProvider>().getEachSubCatagoryFn(
                              subCatagory:
                                  fashionCatagoryDetails?.subCategories ?? []);
                          if (context
                              .read<SectionProvider>()
                              .fashionSubCatagory
                              .isNotEmpty) {
                            context
                                .read<SectionProvider>()
                                .selectCategoryFn(index);
                          } else {
                            context
                                .read<SectionProvider>()
                                .getProductProductsFn(
                                    catagoryId:
                                        fashionCatagoryDetails?.id ?? "");
                            context
                                .read<SectionProvider>()
                                .getIsCategoryOrBrandOrBanner('category=');

                            context.pushNamed(
                                AppRouter.productListByCategoryScreen,
                                queryParameters: {
                                  'categoryid': categoryid,
                                  'subCategoryId': fashionCatagoryDetails?.id,
                                  'categoryname':
                                      fashionCatagoryDetails?.name ?? ''
                                });
                          }
                        },
                        radius: context
                                .watch<SectionProvider>()
                                .fashionSubCatagory
                                .isNotEmpty
                            ? context
                                            .watch<SectionProvider>()
                                            .selectedCategoryIndex ==
                                        index &&
                                    context
                                        .watch<SectionProvider>()
                                        .isSelectCategory
                                ? 37
                                : 28
                            : 28,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
