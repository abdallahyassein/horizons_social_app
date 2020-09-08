import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/helpers/FriendRequestHelper.dart';
import 'package:social_app/pages/profile_page.dart';
import 'package:social_app/providers/UserProvider.dart';
import 'package:social_app/widgets/loading_progress.dart';

class FriendRequestsPage extends StatefulWidget {
  @override
  _FriendRequestsPageState createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  @override
  Widget build(BuildContext context) {
    var token = Provider.of<UserProvider>(context).getToken();
    var users = FriendRequestHelper.getFriendRequests(token);

    return FutureBuilder(
      future: users,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //print(snapshot.data);
          return LoadingProgress();
        } else if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasData) {
          return Center(
            child: Text("there are no friend requests right now"),
          );
        } else if (snapshot.data.length == 0) {
          return Center(
            child: Text(
              "there are no friend requests right now",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          // print(snapshot.data);
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                var allusers = snapshot.data;
                print(snapshot.data);
                return Card(
                  color: Color.fromRGBO(203, 221, 244, 0.95),
                  child: InkWell(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    "http://127.0.0.1:8000/storage/pic_url/" +
                                        allusers[i].picUrl,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                allusers[i].name,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                  color: Colors.greenAccent,
                                  onPressed: () {
                                    FriendRequestHelper.acceptFriendRequest(
                                        allusers[i].id, token);

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
                                        allusers[i].id, token);

                                    setState(() {});
                                  },
                                  child: Text("Refuse",
                                      style: TextStyle(color: Colors.white))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          (MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(allusers[i].id))));
                    },
                  ),
                );
              });
        }
      },
    );
  }
}
