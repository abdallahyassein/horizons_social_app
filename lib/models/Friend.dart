import 'dart:convert';

class Friend {

      final String userId;
      final String friendId;
  
  Friend({
    this.userId,
    this.friendId,
  
  });




  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'friend_id': friendId,
    };
  }

  static Friend fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Friend(
      userId: map['user_id'],
      friendId: map['friend_id'],
    );
  }

  String toJson() => json.encode(toMap());

  static Friend fromJson(String source) => fromMap(json.decode(source));
}
