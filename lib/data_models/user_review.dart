class UserReview {
  // ignore: non_constant_identifier_names
  String rating, comment, date, reviewed_user_id, target_user_id;

  UserReview(
      {this.rating,
      this.comment,
      this.date,
      // ignore: non_constant_identifier_names
      this.reviewed_user_id,
      // ignore: non_constant_identifier_names
      this.target_user_id});

  factory UserReview.fromJSON(var map) {
    return UserReview(
        comment: map['comment'],
        date: map['date'],
        rating: map['rating'],
        reviewed_user_id: map['reviewed_user_id'],
        target_user_id: map['target_user_id']);
  }

  static Map<String, dynamic> toJSON(UserReview userReview) {
    return {
      "comment": userReview.comment,
      "date": userReview.date,
      "rating": userReview.rating,
      "reviewed_user_id": userReview.reviewed_user_id,
      "target_user_id": userReview.target_user_id
    };
  }

  static List<UserReview> fromJSONList(var jsonList){
    List<UserReview> reviews = [];
    for(var a in jsonList){
      reviews.add(UserReview.fromJSON(a));
    }
    return reviews;
  }

  @override
  String toString() {
    return 'UserReview{rating: $rating, comment: $comment, date: $date, reviewed_user_id: $reviewed_user_id, target_user_id: $target_user_id}';
  }


}
