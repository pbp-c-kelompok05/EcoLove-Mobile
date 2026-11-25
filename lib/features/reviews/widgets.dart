import 'package:flutter/material.dart';
import 'package:ecolove/features/reviews/models.dart';

class ReviewBubble extends StatefulWidget {
  final Review review;

  const ReviewBubble(this.review, {super.key});

  @override
  State<ReviewBubble> createState() => _ReviewBubbleState();
}

class _ReviewBubbleState extends State<ReviewBubble> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.review.owner} ⭐(${widget.review.rating})"),
            const SizedBox(height: 6),
            Text(widget.review.text),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: widget.review.isLiked
                    ? Colors.green
                    : Color.fromRGBO(216, 216, 216, 1),
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    hoverColor: Color.fromRGBO(0, 0, 0, 0.1),
                    onTap: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text("Liked!"))
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Text("👍 ${widget.review.likeCount}"),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Material(
                  color: widget.review.isDisliked
                    ? Colors.red
                    : Color.fromRGBO(216, 216, 216, 1),
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    hoverColor: Color.fromRGBO(0, 0, 0, 0.1),
                    onTap: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(content: Text("Disliked!"))
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Text("👎 ${widget.review.dislikeCount}"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}