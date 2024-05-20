import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String review;
  String userId;
  String userName;
  int rate;
  DocumentReference userRef;
  Timestamp addedDate;

  Review({
    required this.review,
    required this.userId,
    required this.userName,
    required this.rate,
    required this.userRef,
    required this.addedDate,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      review: json['review'] ?? '',
      userId: json['review'],
      userName: json['userName'] ?? '',
      rate: json['rate'] ?? 0,
      userRef: json['userRef'],
      addedDate: json['addedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "review": review,
      "userId": userId,
      "userName": userName,
      "rate": rate,
      "userRef": userRef,
      "addedDate": addedDate
    };
  }
}
