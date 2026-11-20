import 'package:ecolove/features/reviews/models.dart';
import 'package:flutter/material.dart';
import 'package:ecolove/features/reviews/widgets.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Review> dummyReviews = [
      Review("0", "A", "A review", 1, 12, 13, false, true, false, false),
      Review("2", "B", "B review", 5, 1123, 13, true, false, false, false)
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: dummyReviews.map((review) => ReviewBubble(review)).toList(),
      ),
    );
  }
}