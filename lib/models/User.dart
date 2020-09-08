import 'dart:convert';

class User {
  final String id;
  final String username;
  final String name;
  final String email;
  final String picUrl;
  final String bio;
  final String address;
  User({
    this.id,
    this.username,
    this.name,
    this.email,
    this.picUrl,
    this.bio,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'pic_url': picUrl,
      'bio': bio,
      'address': address,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'].toString(),
      username: map['username'],
      name: map['name'],
      email: map['email'],
      picUrl: map['pic_url'],
      bio: map['bio'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
