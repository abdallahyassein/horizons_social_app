import 'package:dio/dio.dart';

String url = 'http://127.0.0.1:8000/api/';

class FriendHelper{


  static getuserFriends(String username) async {

    Dio dio = new Dio();

    var body = {"username": username};
      await dio
        .post(
          url + "friends",
          data: body,
        )
        .then((response) => print(response.data["friends"]))
        .catchError((error) => print(error));
   
  
  }

    static unFriend(String friendId,token) async {

    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    var body = {"friend_id": friendId};
      await dio
        .post(
          url + "unfriend",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
   
  
  }

  



}