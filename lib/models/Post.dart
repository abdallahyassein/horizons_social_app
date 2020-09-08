import 'dart:convert';

import 'package:social_app/models/Comment.dart';
import 'package:social_app/models/Image.dart';
import 'package:social_app/models/User.dart';

import 'Like.dart';

class Post {
  final String id;
  final String userId;
  final String description;
  final String isHit;
  final String isPopular;
  final User user;
  final List<Comment> comments;
  final List<Like> likes;
  final List<ImageClass> images;
  final bool isLiked;

  Post(this.id, this.userId, this.description, this.isHit, this.isPopular,
      this.user, this.comments, this.likes, this.images, this.isLiked);

  Map<String, dynamic> toMap() {
    return {
      'post' 'id': id,
      'post' 'user_id': userId,
      'post' 'description': description,
      'post' 'is_hit': isHit,
      'post' 'is_popular': isPopular,
      "user": user?.toMap(),
      'comments': comments?.map((x) => x?.toMap())?.toList(),
      'likes': likes?.map((x) => x?.toMap())?.toList(),
      'images': likes?.map((x) => x?.toMap())?.toList(),
      "is_liked": isLiked,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      map['post']['id'].toString(),
      map['post']['user_id'].toString(),
      map['post']['description'],
      map['post']['is_hit'].toString(),
      map['post']['is_popular'].toString(),
      User.fromMap(map["user"]),
      List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
      List<Like>.from(map['likes']?.map((x) => Like.fromMap(x))),
      List<ImageClass>.from(map['images']?.map((x) => ImageClass.fromMap(x))),
      map['is_liked'],
    );
  }

  factory Post.fromMapProfile(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      map['id'].toString(),
      map['user_id'].toString(),
      map['description'],
      map['is_hit'].toString(),
      map['is_popular'].toString(),
      User.fromMap(map["user"]),
      List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
      List<Like>.from(map['likes']?.map((x) => Like.fromMap(x))),
      List<ImageClass>.from(map['images']?.map((x) => ImageClass.fromMap(x))),
      map['is_liked'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));
}
