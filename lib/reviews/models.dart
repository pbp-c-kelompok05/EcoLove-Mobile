class Review {
  final String id;
  final String owner;
  String text;
  int rating;
  int likeCount;
  int dislikeCount;
  bool isLiked;
  bool isDisliked;
  final bool isDeletable;
  final bool isOwner;

  Review(
    this.id, this.owner,
    this.text, this.rating,
    this.likeCount, this.dislikeCount,
    this.isLiked, this.isDisliked,
    this.isDeletable, this.isOwner
  );
}