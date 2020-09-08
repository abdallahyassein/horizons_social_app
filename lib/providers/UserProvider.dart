import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_app/models/User.dart';

class UserProvider extends ChangeNotifier {
  User _user;
  var _token;

  User getUserInf() {
    return _user;
  }

  getToken() {
    return _token;
  }

  setUserInf(User user) {
    _user = user;
    print(_user.email);
    notifyListeners();
  }

  setToken(token) {
    _token = token;
    notifyListeners();
  }

  Future<dynamic> login(String email, String password) async {
    var body = {'email': email, 'password': password};
    var result = false;

    Dio dio = new Dio();
    await dio
        .post(
      'http://127.0.0.1:8000/api/login',
      data: body,
    )
        .then((response) {
      if (response.statusCode == 200) {
        print(response.data["success"]["token"]);

        setToken(response.data["success"]["token"]);
        setUserInf(User.fromMap(response.data["success"]["user"]));
        result = true;
      }
    }).catchError((error) => print(error));

    return result;
  }

  Future register(String name, String username, String email, String password,
      String confirmPassword) async {
    bool result = false;

    var body = {
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'c_password': confirmPassword
    };

    Dio dio = new Dio();
    await dio
        .post(
      "http://127.0.0.1:8000/api/register",
      data: body,
    )
        .then((response) {
      print(response.data["success"]["token"]);
      setToken(response.data["success"]["token"]);
      // setUserInf(User.fromMap(response.data["success"]["user"]));
      result = true;
    }).catchError((error) => print(error));

    return result;
  }

  Future logout() async {
    await setToken("");

    return true;
  }
}
