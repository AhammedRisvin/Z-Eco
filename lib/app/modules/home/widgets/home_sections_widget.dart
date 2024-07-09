import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../../widgets/view/category_circle_widget.dart';
import '../model/main_categories_model.dart';
import '../view_model/home_provider.dart';

class HomeSectionsWidget extends StatelessWidget {
  const HomeSectionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, List<SectionElement>>(
      selector: (p0, provider) => provider.sectionList,
      builder: (context, value, _) {
        return value.isEmpty
            ? const SizedBox.shrink()
            : Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizeBoxH(10),
                    CustomTextWidgets(
                      textStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 20,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                      text: 'Category',
                    ),
                    const SizeBoxH(15),
                    MediaQuery.removePadding(
                      context: context,
                      removeBottom: true,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: Responsive.height * 0.085,
                          crossAxisCount: 5,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return value[index].name == 'Accessories'
                              ? const SizedBox.shrink()
                              : CategoryCircleTabWidget(
                                  imageUrl: value[index].image,
                                  name: value[index].name.toString(),
                                  radius: 30,
                                  onTap: () {
                                    if (value[index].name == 'Deals') {
                                      context.pushNamed(
                                        AppRouter.dealsScreen,
                                      );
                                    } else {
                                      navigateToCategoryScreenBasedOnSectionFn(
                                          context: context,
                                          sectionId: value[index].id ?? '',
                                          sectionName: value[index].name ?? '');
                                    }
                                  },
                                );
                        },
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
