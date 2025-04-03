import 'dart:convert';

class User {
  final String userType;
  final String userId;

  User({required this.userType, required this.userId});

  // Convert from Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userType: map["user_type"].toString(),
      userId: map["user_id"].toString(),
    );
  }

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      "user_type": userType,
      "user_id": userId,
    };
  }

  // Convert to JSON string
  String toJson() => jsonEncode(toMap());
}
