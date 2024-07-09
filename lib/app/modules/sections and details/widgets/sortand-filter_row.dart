import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/router.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_images.dart';

class SortAndFilterRow extends StatelessWidget {
  final String? categoryId;
  final bool? isSearch;
  const SortAndFilterRow({this.isSearch = false, super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isSearch == true
            ? const SizedBox.shrink()
            : Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: .8, color: AppConstants.appBorderColor),
                  borderRadius: BorderRadius.circular(10),
                )),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image.asset(
                      AppImages.downVector,
                      height: Responsive.height * 1.3,
                    ),
                    const SizeBoxV(10),
                    Text(
                      'Sort by',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontFamily: 'Plus Jakarta Sans',
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
        const SizeBoxV(10),
        CommonInkwell(
          onTap: () {
            context.pushNamed(AppRouter.filterScreen, queryParameters: {
              'subCategory': categoryId ?? '',
            });
          },
          child: Container(
            decoration: ShapeDecoration(
                // color: const Color(0xfffffffff),
                shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: .8, color: AppConstants.appBorderColor),
              borderRadius: BorderRadius.circular(10),
            )),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Image.asset(
                  AppImages.filterImage,
                ),
                const SizeBoxV(10),
                Text(
                  'Filter',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
