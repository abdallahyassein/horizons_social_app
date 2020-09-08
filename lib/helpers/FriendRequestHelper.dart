import 'package:dio/dio.dart';
import 'package:social_app/models/User.dart';

String url = 'http://127.0.0.1:8000/api/';

class FriendRequestHelper {
  static sendFriendRequest(String userId, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    var body = {"user_id": userId};
    await dio
        .post(
          url + "friendrequest",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static Future<List<User>> getFriendRequests(token) async {
    var data;
    List<User> users = [];
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    await dio
        .get(
      url + "friendrequests",
    )
        .then((response) {
      if (response.data["users"] == null ||
          response.data["users"].length == 0) {
        print("There are no Friend Requests right now");
      } else {
        data = response.data["users"];
        int dataLength = data.length;
        // print(dataLength);

        for (int i = 0; i < dataLength; i++) {
          //print(data["post"]["comments"]);
          User user = User.fromMap(data[i]);

          users.add(user);

          print(users);
        }
      }
    }).catchError((error) => print(error));

    return users;
  }

  static checkFriendRequest(String userId, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    var body = {"user_id": userId};
    dio
        .post(
          url + "checkfriendrequest",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static acceptFriendRequest(String authId, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    var body = {"auth_id": authId};
    dio
        .post(
          url + "acceptfriendrequest",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static refuseFriendRequest(String authId, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    var body = {"auth_id": authId};
    dio
        .post(
          url + "refusefriendrequest",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static cancelFriendRequest(String userId, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    var body = {"user_id": userId};
    dio
        .post(
          url + "cancelfriendrequest",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }
}
