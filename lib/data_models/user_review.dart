class UserReview {
  String rating, comment, date, reviewedUserId, targetUserId;

  UserReview(
      {this.rating,
      this.comment,
      this.date,
      this.reviewedUserId,
      this.targetUserId});

  factory UserReview.fromJSON(var map) {
    return map == null
        ? UserReview()
        : UserReview(
            comment: map['comment'],
            date: map['date'],
            rating: map['rating'],
            reviewedUserId: map['reviewed_user_id'],
            targetUserId: map['target_user_id']);
  }

  static Map<String, dynamic> toJSON(UserReview userReview) {
    return {
      "comment": userReview.comment,
      "date": userReview.date,
      "rating": userReview.rating,
      "reviewed_user_id": userReview.reviewedUserId,
      "target_user_id": userReview.targetUserId
    };
  }

  static List<UserReview> fromJSONList(var jsonList) {
    List<UserReview> reviews = [];
    if (jsonList == null) return reviews;
    for (var a in jsonList) {
      reviews.add(UserReview.fromJSON(a));
    }
    return reviews;
  }

  @override
  String toString() {
    return 'UserReview{rating: $rating, comment: $comment, date: $date,'
        'reviewed_user_id: $reviewedUserId, target_user_id: $targetUserId}';
  }
}
