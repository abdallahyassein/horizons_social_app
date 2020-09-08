import 'dart:convert';

class Tag {

    String tag;
  Tag({
    this.tag,
  });


  Map<String, dynamic> toMap() {
    return {
      'tag': tag,
    };
  }

  static Tag fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Tag(
      tag: map['tag'],
    );
  }

  String toJson() => json.encode(toMap());

  static Tag fromJson(String source) => fromMap(json.decode(source));
}
