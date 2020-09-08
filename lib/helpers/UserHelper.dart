import 'dart:io';
import 'package:dio/dio.dart';
import 'package:social_app/models/Profile.dart';

String url = 'http://127.0.0.1:8000/api/';

class UserHelper {
  static Future<Profile> profile(id, token) async {
    var data;
    Profile profile;
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    await dio
        .get(
      url + "profile/$id",
    )
        .then((response) {
      data = response.data;

      profile = Profile.fromMap(data);

      print(profile.user.name);
    }).catchError((error) => print(error));

    //posts.shuffle();
    return profile;
  }

  static getUserDetails(token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    dio
        .get(
          url + "details",
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static searchUsers(String data, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    dio
        .get(
      url + "livesearch?data=$data",
    )
        .then((response) {
      if (response.data["users"].length == 0) {
        print("There are no Users With this name");
      } else {
        print(response.data["users"]);
      }
    }).catchError((error) => print(error));
  }

  static Future updateBio(String bio, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    var body = {"bio": bio};
    await dio
        .post(
          url + "updatebio",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static Future updateAddress(String address, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    var body = {"address": address};
    await dio
        .post(
          url + "updateaddress",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static void updateProfilePicture(File file, token) async {
    String fileName = file.path.split('/').last;
    //print(fileName);
    FormData data = FormData.fromMap({
      "pic_url": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio
        .post(
          url + "updateavatar",
          data: data,
        )
        .then((response) => print(response))
        .catchError((error) => print(error));
  }
}
