import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:social_app/helpers/PostHelper.dart';
import 'package:social_app/helpers/UserHelper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  File _image;
  final picker = ImagePicker();

  List<File> images = List<File>();

  Future uploadMultipuleImages() async {
    try {
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      setState(() {
        images.add(File(pickedFile.path));
        print(images);
      });
    } catch (e) {
      print(e);
    }
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);

          UserHelper.updateProfilePicture(_image,
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNGIzMTBiZGUzMTRmZDU4ZGJlMzU5NDhiOTFlNGM2MDlkNWI2Y2ZjMzExNjQ1MmNiMjg4ZTQ2Mzk2Y2Q3M2ZkZjBjZmY1ODVmOTc4NGFhMDQiLCJpYXQiOjE1OTUxODUwMzQsIm5iZiI6MTU5NTE4NTAzNCwiZXhwIjoxNjI2NzIxMDM0LCJzdWIiOiIxMDEiLCJzY29wZXMiOltdfQ.fkaGFM9iXV5fq0FfQYqHK3EM54hSmlKtFii_0pWymYV4-bxJ_lcgjffT_HSCHOaqLfvA82liQ07ylllVHm7dHJJJOgnMk6fItlnGOxPyuovyumMUzNDpUSynRZ8Fgn3eJ4TP5jfWpiDw9wgi5iOWHdgtVy8cfswnq4I3lpMYNWHk2hgQErDMHeOEOaVnY0IlU_wQF02smEa515UmQQx-HaeCgvT4tBYmtVGaYkpGxlxtmMQjRxwI5QQFopp4qJY2bDvy7Lg6OkYHZNBOMs_JybjNBBvEegjZOJ_9xR2vtN5Va30vKdyxhc9xCZUGm8vcFJantc9UhNfKxSG7WZ90UbfSR0BGa19Xb4Kc2JXMHtHs5OWP8fwKnJI_Do63Xqba-AkhPzidLaAf5MRlVkjrE7H4LGYuJPWiC6XI7xgddB25vJjn3pGEbB2B3cJj1RQqeWBxlBJe8XbDH8ajXBXvx2VK18TrBGwqPcQuLfsvvoUQivtWEqoY5qzawT7iA8GEQaHnQLVlWyRYqoEgNTwjJueqep_IvjT16HPOqI2cYwlljPA3VFGvr8fXjVtHeK7dNrGWIodFe_iqYj3QLP1u5dfbaahHKYqOuOXyMQ3Ztur-sfjCr3ne_MyhZB_T4NmCxqXqo3OVSU558YCHpNl1HOVkVw47PS4o66CcDg9PVIw");
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //  PostHelper.newPost("Hiasd","1","eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNGIzMTBiZGUzMTRmZDU4ZGJlMzU5NDhiOTFlNGM2MDlkNWI2Y2ZjMzExNjQ1MmNiMjg4ZTQ2Mzk2Y2Q3M2ZkZjBjZmY1ODVmOTc4NGFhMDQiLCJpYXQiOjE1OTUxODUwMzQsIm5iZiI6MTU5NTE4NTAzNCwiZXhwIjoxNjI2NzIxMDM0LCJzdWIiOiIxMDEiLCJzY29wZXMiOltdfQ.fkaGFM9iXV5fq0FfQYqHK3EM54hSmlKtFii_0pWymYV4-bxJ_lcgjffT_HSCHOaqLfvA82liQ07ylllVHm7dHJJJOgnMk6fItlnGOxPyuovyumMUzNDpUSynRZ8Fgn3eJ4TP5jfWpiDw9wgi5iOWHdgtVy8cfswnq4I3lpMYNWHk2hgQErDMHeOEOaVnY0IlU_wQF02smEa515UmQQx-HaeCgvT4tBYmtVGaYkpGxlxtmMQjRxwI5QQFopp4qJY2bDvy7Lg6OkYHZNBOMs_JybjNBBvEegjZOJ_9xR2vtN5Va30vKdyxhc9xCZUGm8vcFJantc9UhNfKxSG7WZ90UbfSR0BGa19Xb4Kc2JXMHtHs5OWP8fwKnJI_Do63Xqba-AkhPzidLaAf5MRlVkjrE7H4LGYuJPWiC6XI7xgddB25vJjn3pGEbB2B3cJj1RQqeWBxlBJe8XbDH8ajXBXvx2VK18TrBGwqPcQuLfsvvoUQivtWEqoY5qzawT7iA8GEQaHnQLVlWyRYqoEgNTwjJueqep_IvjT16HPOqI2cYwlljPA3VFGvr8fXjVtHeK7dNrGWIodFe_iqYj3QLP1u5dfbaahHKYqOuOXyMQ3Ztur-sfjCr3ne_MyhZB_T4NmCxqXqo3OVSU558YCHpNl1HOVkVw47PS4o66CcDg9PVIw");

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          FlatButton(
            child: Text("Update Profile Image"),
            onPressed: () {
              getImage();
            },
          ),
          RaisedButton(
            child: Text("Upload Multiple Images to posts"),
            onPressed: () {
              uploadMultipuleImages();
              print(images);
            },
          ),
          RaisedButton(
            child: Text("Post"),
            onPressed: () {
              PostHelper.newPost("description", images,
                  "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNGIzMTBiZGUzMTRmZDU4ZGJlMzU5NDhiOTFlNGM2MDlkNWI2Y2ZjMzExNjQ1MmNiMjg4ZTQ2Mzk2Y2Q3M2ZkZjBjZmY1ODVmOTc4NGFhMDQiLCJpYXQiOjE1OTUxODUwMzQsIm5iZiI6MTU5NTE4NTAzNCwiZXhwIjoxNjI2NzIxMDM0LCJzdWIiOiIxMDEiLCJzY29wZXMiOltdfQ.fkaGFM9iXV5fq0FfQYqHK3EM54hSmlKtFii_0pWymYV4-bxJ_lcgjffT_HSCHOaqLfvA82liQ07ylllVHm7dHJJJOgnMk6fItlnGOxPyuovyumMUzNDpUSynRZ8Fgn3eJ4TP5jfWpiDw9wgi5iOWHdgtVy8cfswnq4I3lpMYNWHk2hgQErDMHeOEOaVnY0IlU_wQF02smEa515UmQQx-HaeCgvT4tBYmtVGaYkpGxlxtmMQjRxwI5QQFopp4qJY2bDvy7Lg6OkYHZNBOMs_JybjNBBvEegjZOJ_9xR2vtN5Va30vKdyxhc9xCZUGm8vcFJantc9UhNfKxSG7WZ90UbfSR0BGa19Xb4Kc2JXMHtHs5OWP8fwKnJI_Do63Xqba-AkhPzidLaAf5MRlVkjrE7H4LGYuJPWiC6XI7xgddB25vJjn3pGEbB2B3cJj1RQqeWBxlBJe8XbDH8ajXBXvx2VK18TrBGwqPcQuLfsvvoUQivtWEqoY5qzawT7iA8GEQaHnQLVlWyRYqoEgNTwjJueqep_IvjT16HPOqI2cYwlljPA3VFGvr8fXjVtHeK7dNrGWIodFe_iqYj3QLP1u5dfbaahHKYqOuOXyMQ3Ztur-sfjCr3ne_MyhZB_T4NmCxqXqo3OVSU558YCHpNl1HOVkVw47PS4o66CcDg9PVIw");
            },
          ),
        ],
      ),
    );
  }
}
