import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_app/helpers/FriendHelper.dart';
import 'package:social_app/helpers/FriendRequestHelper.dart';
import 'package:social_app/helpers/PostHelper.dart';
import 'package:social_app/helpers/UserHelper.dart';
import 'package:social_app/pages/messages_page.dart';
import 'package:social_app/providers/UserProvider.dart';
import 'package:social_app/widgets/loading_progress.dart';
import 'package:social_app/widgets/post_widget.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  ProfilePage(this.userId);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController description = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var token = Provider.of<UserProvider>(context).getToken();
    var profile = UserHelper.profile(widget.userId, token);
    var user = Provider.of<UserProvider>(context).getUserInf();

    File _image;
    final picker = ImagePicker();

    List<File> postimages = List<File>();

    Future uploadMultipuleImages() async {
      try {
        final pickedFile = await picker.getImage(
          source: ImageSource.gallery,
          imageQuality: 100,
        );

        postimages.add(File(pickedFile.path));
        print(postimages);
      } catch (e) {
        print(e);
      }
    }

    editAddressOrBio(type, description, userId) {
      GlobalKey<FormState> _formKey = GlobalKey<FormState>();
      TextEditingController data = new TextEditingController();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: data,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () =>
                                FocusScope.of(context).nextFocus(),
                            decoration: InputDecoration(
                                hintText: description,
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'you did not write anything';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: Text("Submit"),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                if (type == "address") {
                                  UserHelper.updateAddress(data.text, token)
                                      .then((value) {
                                    Navigator.push(
                                        context,
                                        (MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage(userId))));
                                  });
                                } else if (type == "bio") {
                                  UserHelper.updateBio(data.text, token)
                                      .then((value) {
                                    Navigator.push(
                                        context,
                                        (MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage(userId))));
                                  });
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    }

    Future updateProfilePage() async {
      try {
        final pickedFile = await picker.getImage(
          source: ImageSource.gallery,
          imageQuality: 100,
        );

        if (pickedFile != null) {
          setState(() {
            _image = File(pickedFile.path);

            UserHelper.updateProfilePicture(_image, token);
          });
        }
      } catch (e) {
        print(e);
      }
    }

    checkFriend(bool checkYourProfile, bool isFriend, bool sentFriendRequest,
        bool userSentRequest) {
      if (checkYourProfile) {
        return Text("");
      } else if (isFriend) {
        return Card(
          color: Colors.greenAccent,
          child: FlatButton(
              onPressed: () {
                FriendHelper.unFriend(widget.userId, token);
                setState(() {});
              },
              child: Text("Friend")),
        );
      } else if (sentFriendRequest) {
        return Card(
          color: Colors.yellow,
          child: FlatButton(
              onPressed: () {
                FriendRequestHelper.cancelFriendRequest(widget.userId, token);
                setState(() {});
              },
              child: Text("Cancal Friend Request")),
        );
      } else if (userSentRequest) {
        return Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    FriendRequestHelper.acceptFriendRequest(
                        widget.userId, token);

                    setState(() {});
                  },
                  child: Text(
                    "Accept",
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    FriendRequestHelper.refuseFriendRequest(
                        widget.userId, token);

                    setState(() {});
                  },
                  child: Text("Refuse", style: TextStyle(color: Colors.white))),
            ],
          ),
        );
      } else if (!sentFriendRequest) {
        return Card(
          color: Colors.green[200],
          child: FlatButton(
              onPressed: () {
                FriendRequestHelper.sendFriendRequest(widget.userId, token);
                setState(() {});
              },
              child: Text("Send Friend Request")),
        );
      }
    }

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: profile,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingProgress();
              } else if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasData) {
                return Center(
                  child: Text("there is no data right now"),
                );
              } else {
                bool checkYourProfile =
                    snapshot.data.user.id == user.id ? true : false;

                // print(snapshot.data.isFriend);
                //  print(snapshot.data.sentFriendRequest);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/images/blue_back.jpg"),
                                fit: BoxFit.cover),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 350.0,
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            "http://127.0.0.1:8000/storage/pic_url/" +
                                                snapshot.data.user.picUrl,
                                          ),
                                          radius: 50.0,
                                        ),
                                        checkYourProfile
                                            ? Positioned(
                                                bottom: 1,
                                                right: 1,
                                                child: InkWell(
                                                  onTap: () {
                                                    updateProfilePage();
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/cam-icon.png",
                                                    width: 35,
                                                    height: 35,
                                                  ),
                                                ),
                                              )
                                            : Text(""),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      snapshot.data.user.name,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Card(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5.0),
                                      clipBehavior: Clip.antiAlias,
                                      color: Colors.white,
                                      elevation: 5.0,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    "Posts",
                                                    style: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    snapshot.data.posts.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.pinkAccent,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    "Friends",
                                                    style: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    snapshot.data.friends.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.pinkAccent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    checkFriend(
                                        checkYourProfile,
                                        snapshot.data.isFriend,
                                        snapshot.data.sentFriendRequest,
                                        snapshot.data.userSentRequest),
                                    !checkYourProfile
                                        ? Card(
                                            color: Colors.yellow[200],
                                            child: FlatButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      (MaterialPageRoute(
                                                          builder: (context) =>
                                                              MessagePage(
                                                                  snapshot.data
                                                                      .user.id,
                                                                  token))));
                                                },
                                                child: Text("Send Message")),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      Card(
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30.0, horizontal: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      "Address:",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 28.0),
                                    ),
                                    checkYourProfile
                                        ? FlatButton(
                                            onPressed: () {
                                              editAddressOrBio(
                                                  "address",
                                                  "please write your Address here",
                                                  snapshot.data.user.id);
                                            },
                                            child: Text(
                                              "add",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))
                                        : Text("")
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                snapshot.data.user.address == ""
                                    ? Text(
                                        "this user did not submit his address yet",
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          letterSpacing: 2.0,
                                        ),
                                      )
                                    : Text(
                                        snapshot.data.user.address,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Bio:",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 28.0),
                                    ),
                                    checkYourProfile
                                        ? FlatButton(
                                            onPressed: () {
                                              editAddressOrBio(
                                                  "bio",
                                                  "please write your Bio here",
                                                  snapshot.data.user.id);
                                            },
                                            child: Text(
                                              "add",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))
                                        : Text("")
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                snapshot.data.user.bio == ""
                                    ? Text(
                                        "this user did not add his Bio yet",
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          letterSpacing: 2.0,
                                        ),
                                      )
                                    : Text(
                                        snapshot.data.user.bio,
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      checkYourProfile
                          ? Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    "Add Post",
                                    style: GoogleFonts.abel(
                                        textStyle: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic,
                                    )),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLength: null,
                                      maxLines: null,
                                      style: TextStyle(
                                        height: 2,
                                      ),
                                      controller: description,
                                      decoration: InputDecoration(
                                        hintText: "description .......",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FlatButton(
                                    child: Text(
                                      "Add Images",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      uploadMultipuleImages();
                                      // print(images);
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FlatButton(
                                    color: Colors.blue[300],
                                    child: Text("Post"),
                                    onPressed: () {
                                      if (description.text.length != 0) {
                                        PostHelper.newPost(description.text,
                                                postimages, token)
                                            .then((value) {
                                          description.text = "";
                                          setState(() {});
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      snapshot.data.posts.length == 0
                          ? Text(
                              "There are no posts until now",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/social_media2.jpg"),
                                    fit: BoxFit.cover),
                              ),
                              child: ListView.builder(
                                  itemCount: snapshot.data.posts.length,
                                  itemBuilder: (context, i) {
                                    var allposts = snapshot.data.posts;

                                    return PostWithImage(allposts[i], token,
                                        () {
                                      Navigator.push(
                                          context,
                                          (MaterialPageRoute(
                                              builder: (context) => ProfilePage(
                                                  snapshot.data.user.id))));
                                    });
                                  }),
                            ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
