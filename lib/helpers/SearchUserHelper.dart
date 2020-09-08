import 'package:dio/dio.dart';
import 'package:social_app/models/User.dart';

String url = 'http://127.0.0.1:8000/api/';

class SearchUserHelper {
  static Future<List<User>> getUsers(searchData, token) async {
    var data;
    List<User> users = [];
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.options.headers["Content-Type"] = 'application/json';
    dio.options.headers["Accept"] = 'application/json';
    await dio
        .get(
      url + "livesearch?data=$searchData",
    )
        .then((response) {
      if (response.data["users"] == null ||
          response.data["users"].length == 0) {
        print("There are no Friend Requests right now");
      } else {
        data = response.data["users"]["data"];
        int dataLength = data.length;
        // print(dataLength);

        for (int i = 0; i < dataLength; i++) {
          //print(data["post"]["comments"]);
          User user = User.fromMap(data[i]);

          users.add(user);

          print(user.bio);
        }
      }
    }).catchError((error) => print(error));

    return users;
  }
}
