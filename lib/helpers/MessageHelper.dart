import 'package:dio/dio.dart';
import 'package:social_app/models/Message.dart';

String url = 'http://127.0.0.1:8000/api/';

class MessageHelper {
  static Future sendMessage(String friendId, String message, token) async {
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    var body = {"friend_id": friendId, "message": message};
    await dio
        .post(
          url + "sendmessage",
          data: body,
        )
        .then((response) => print(response.data["success"]))
        .catchError((error) => print(error));
  }

  static getMessages(String friendId, token) async {
    var data;
    List<Message> messages = [];
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    var body = {
      "friend_id": friendId,
    };
    await dio
        .post(
      url + "messages",
      data: body,
    )
        .then((response) {
      data = response.data["messages"];

      int dataLength = data.length;
      // print(dataLength);

      for (int i = 0; i < dataLength; i++) {
        //print(data["post"]["comments"]);
        Message message = Message.fromMap(data[i]);

        messages.add(message);
        //print(message.message);
      }
    }).catchError((error) => print(error));

    return messages;
  }
}
