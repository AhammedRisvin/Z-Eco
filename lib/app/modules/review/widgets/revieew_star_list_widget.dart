import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewStarListWidget extends StatelessWidget {
  final bool ignoreGestures;
  final double reviewedColorCount;
  const ReviewStarListWidget(
      {super.key,
      required this.reviewedColorCount,
      this.ignoreGestures = false});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      ignoreGestures: ignoreGestures,
      itemSize: 15,
      initialRating: reviewedColorCount,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        debugPrint(rating.toString());
      },
    );
  }
}
