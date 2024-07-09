import 'package:flutter/material.dart';

class TimelineCard extends StatelessWidget {
  final child;
  final bool isPast;
  const TimelineCard({
    super.key,
    this.child,
    required this.isPast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      padding: const EdgeInsets.all(15),
      child: isPast ? child : const SizedBox.shrink(),
    );
  }
}
