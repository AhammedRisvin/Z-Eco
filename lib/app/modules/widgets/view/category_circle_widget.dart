import 'package:flutter/material.dart';

import '../../../helpers/common_widgets.dart';

class CategoryCircleTabWidget extends StatelessWidget {
  final void Function()? onTap;
  final double? radius;
  final String name;
  final String? imageUrl;
  const CategoryCircleTabWidget(
      {super.key,
      required this.onTap,
      required this.name,
      this.radius = 30,
      this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: radius,
            child: CachedImageWidget(
              height: 57,
              width: 57,
              imageUrl: imageUrl ?? "",
              borderRadius: BorderRadius.circular(radius!),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 60,
            // height: 30,
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              name,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
