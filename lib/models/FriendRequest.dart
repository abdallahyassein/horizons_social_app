import 'dart:convert';

class FriendRequest {

      final String userId;
      final String authId;
  
  FriendRequest({
    this.userId,
    this.authId,
  
  });



  

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'auth_id': authId,
    };
  }

  static FriendRequest fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return FriendRequest(
      userId: map['user_id'],
      authId: map['auth_id'],
    );
  }

  String toJson() => json.encode(toMap());

  static FriendRequest fromJson(String source) => fromMap(json.decode(source));
}
