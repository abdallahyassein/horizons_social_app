import 'dart:convert';

import 'package:social_app/models/User.dart';

class Message {
  User user;
  User friend;
  String message;
  Message({
    this.user,
    this.friend,
    this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(),
      'friend': friend?.toMap(),
      'message': message,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Message(
      user: User.fromMap(map['user']),
      friend: User.fromMap(map['friend']),
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
