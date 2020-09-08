import 'package:dio/dio.dart';

String url = 'http://127.0.0.1:8000/api/';

class TagHelper{

  static getTagPosts(String tag) async {
    
    Dio dio = new Dio();

      await dio
        .get(
          url + "tags/posts/$tag",
          
        )
        .then((response) {
      if (response.data["posts"].length == 0) {
        print("There are no Tag With this name");
      } else {
        print(response.data["posts"]);
      }
        
        })
        .catchError((error) => print(error));
  
    
  }

}