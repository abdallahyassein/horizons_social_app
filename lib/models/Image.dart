import 'dart:convert';

class ImageClass {
  String id;
  String postId;
  String imageUrl;
  ImageClass({
    this.id,
    this.postId,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'post_id': postId,
      'image_url': imageUrl,
    };
  }

  factory ImageClass.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ImageClass(
      id: map['id'].toString(),
      postId: map['post_id'].toString(),
      imageUrl: map['image_url'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageClass.fromJson(String source) =>
      ImageClass.fromMap(json.decode(source));
}
