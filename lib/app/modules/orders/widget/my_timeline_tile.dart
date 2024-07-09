import 'package:zoco/app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'timeline_card.dart';

class MyTimeLineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final child;

  const MyTimeLineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: isFirst,
      isLast: isLast,
      alignment: TimelineAlign.start,
      beforeLineStyle: LineStyle(
        color: isPast
            ? AppConstants.appPrimaryColor
            : AppConstants.appMainGreyColor,
      ),
      indicatorStyle: IndicatorStyle(
        width: 25,
        color: isPast
            ? AppConstants.appPrimaryColor
            : AppConstants.appMainGreyColor,
        iconStyle: IconStyle(
          iconData: Icons.done,
          color: isPast ? AppConstants.white : AppConstants.appMainGreyColor,
        ),
      ),
      endChild: TimelineCard(
        isPast: isPast,
        child: child,
      ),
    );
  }
}
