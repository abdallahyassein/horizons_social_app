import 'dart:convert';

class Like {
  final String userId;
  final String username;
  final String picUrl;
  final String postId;
  Like({
    this.userId,
    this.username,
    this.picUrl,
    this.postId,
  });

  Map<String, dynamic> toMap() {
    return {
      'like_user_id': userId,
      'user_name': username,
      'pic_url': picUrl,
      'like_post_id': postId,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Like(
      userId: map['like_user_id'].toString(),
      username: map['user_name'],
      picUrl: map['pic_url'],
      postId: map['like_post_id'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));
}
