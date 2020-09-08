import 'dart:convert';

import 'package:social_app/models/Post.dart';
import 'package:social_app/models/User.dart';

class Profile {
  final User user;
  final List<User> friends;
  final List<Post> posts;
  final bool isFriend;
  final bool sentFriendRequest;
  final bool userSentRequest;

  Profile(this.user, this.friends, this.posts, this.isFriend,
      this.sentFriendRequest, this.userSentRequest);

  factory Profile.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Profile(
      User.fromMap(map['user']),
      List<User>.from(
          map['user']['friends']?.map((x) => User.fromMap(x['friend']))),
      List<Post>.from(map['user']['posts']?.map((x) => Post.fromMapProfile(x))),
      map['is_friend'],
      map['sent_friend_request'],
      map['user_sent_request'],
    );
  }

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));
}
