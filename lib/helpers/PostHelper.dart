import 'dart:io';

import 'package:dio/dio.dart';

import 'package:social_app/models/Post.dart';
import 'package:social_app/models/User.dart';

String url = 'http://127.0.0.1:8000/api/';

class PostHelper {
  static Future newPost(String description, List<File> images, token) async {
    List<MultipartFile> multiparts = new List<MultipartFile>();
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";

    for (int i = 0; i < images.length; i++) {
      String fileName = images[i].path.split('/').last;
      print(fileName);
      multiparts.add(await MultipartFile.fromFile(
        images[i].path,
        filename: fileName,
      ));
    }

    FormData data =
        FormData.fromMap({"description": description, "images": multiparts});

    await dio
        .post(
          url + "new-post",
          data: data,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static commentPost(String postId, String comment, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    var body = {"post_id": postId, "comment": comment};
    await dio
        .post(
          url + "comment",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static likePost(String postId, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";

    await dio
        .post(
          url + "like/$postId",
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static Future<User> getUser(id, token) async {
    var data;

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    await dio
        .get(
      url + "getuser/$id",
    )
        .then((response) {
      data = response.data["user"];
    }).catchError((error) => print(error));

    User user = User(
      name: data["name"],
      picUrl: data["pic_url"],
      address: data["address"],
      bio: data["bio"],
      email: data["email"],
      username: data["username"],
    );

    return user;
  }

  static Future<List<Post>> getMainPosts(token) async {
    var data;
    List<Post> posts = [];
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    await dio
        .get(
      url + "posts",
    )
        .then((response) {
      data = response.data["posts"];

      int dataLength = data.length;
      // print(dataLength);

      for (int i = 0; i < dataLength; i++) {
        //print(data["post"]["comments"]);
        Post post = Post.fromMap(data[i]);

        posts.add(post);
      }
    }).catchError((error) => print(error));

    //posts.shuffle();
    return posts;
  }

  // static Future<List<Comment>> getPostComments(postId, token) async {
  //   var data;
  //   List<Comment> comments = [];
  //   Dio dio = new Dio();
  //   dio.options.headers["Authorization"] = "Bearer $token";
  //   dio.options.headers["Content-Type"] = 'application/json';
  //   dio.options.headers["Accept"] = 'application/json';
  //   dio
  //       .get(
  //     url + "postcomments/$postId",
  //   )
  //       .then((response) {
  //     data = response.data["comments"];
  //     int dataLength = data.length;
  //     for (int i = 0; i < dataLength; i++) {
  //       Comment comment = Comment.fromMap(data[i]);
  //       print(comment.comment);
  //       comments.add(comment);
  //     }
  //   }).catchError((error) => print(error));
  //   print(comments);
  //   return comments;
  // }

  // static Future<List<ImageClass>> getPostImages(postId, token) async {
  //   var data;
  //   List<ImageClass> images = [];
  //   Dio dio = new Dio();
  //   dio.options.headers["Authorization"] = "Bearer $token";
  //   dio.options.headers["Content-Type"] = 'application/json';
  //   dio.options.headers["Accept"] = 'application/json';
  //   await dio
  //       .get(
  //     url + "postimages/$postId",
  //   )
  //       .then((response) {
  //     data = response.data["images"];
  //     // print(data.length);
  //   }).catchError((error) => print(error));

  //   for (int i = 0; i < data.length; i++) {
  //     ImageClass image = new ImageClass(
  //       postId: data[i]["post_id"].toString(),
  //       imageUrl: data[i]["image_url"].toString(),
  //     );
  //     images.add(image);
  //   }
  //   // print(images);
  //   return images;
  // }

  // static Future<Map<User, Map<Post, List<ImageClass>>>> getPostsWithImages(
  //     token) async {
  //   //  print("1");
  //   Map<User, Map<Post, List<ImageClass>>> alldata =
  //       new Map<User, Map<Post, List<ImageClass>>>();
  //   Map<Post, List<ImageClass>> postsImages = new Map<Post, List<ImageClass>>();
  //   //  print("2");
  //   var posts = await getUserPosts(token);
  //   // print("3");
  //   for (int i = 0; i < posts.length; i++) {
  //     //  print("4");
  //     var user = await getUser(posts[i].userId, token);
  //     //print(user.name);
  //     var images = await getPostImages(posts[i].id, token);
  //     postsImages.putIfAbsent(posts[i], () => images);
  //     alldata.putIfAbsent(user, () => postsImages);
  //   }

  //   // print(alldata);
  //   return alldata;
  // }
}
