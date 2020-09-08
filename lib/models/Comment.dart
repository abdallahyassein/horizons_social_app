import 'dart:convert';

class Comment {
  final String userId;
  final String username;
  final String picUrl;
  final String postId;
  final String comment;

  Comment({
    this.userId,
    this.username,
    this.picUrl,
    this.postId,
    this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'comment_user_id': userId,
      'user_name': username,
      'pic_url': picUrl,
      'comment_post_id': postId,
      'post_comment': comment,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      userId: map['comment_user_id'].toString(),
      username: map['user_name'].toString(),
      picUrl: map['pic_url'].toString(),
      postId: map['comment_post_id'].toString(),
      comment: map['post_comment'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));
}
