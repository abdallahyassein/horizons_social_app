import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/helpers/FriendRequestHelper.dart';
import 'package:social_app/helpers/SearchUserHelper.dart';
import 'package:social_app/pages/profile_page.dart';
import 'package:social_app/providers/UserProvider.dart';
import 'package:social_app/widgets/loading_progress.dart';

class SearchPage extends StatefulWidget {
  final String searchData;

  SearchPage(this.searchData);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchData = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var token = Provider.of<UserProvider>(context).getToken();
    var users = SearchUserHelper.getUsers(widget.searchData, token);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(100, 100, 100, 1),
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          automaticallyImplyLeading: false,
          title: Container(
            child: TextField(
              controller: searchData,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.all(5),
                  hintText: "Search Friends"),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                if (searchData.text.isNotEmpty) {
                  Navigator.push(
                      context,
                      (MaterialPageRoute(
                          builder: (context) => SearchPage(searchData.text))));
                }
              },
            )
          ],
        ),
        body: FutureBuilder(
          future: users,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //print(snapshot.data);
              return LoadingProgress();
            } else if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasData) {
              return Center(
                child: Text("there are no users with this name"),
              );
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Text(
                  "there are no users with this name",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              // print(snapshot.data);
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/social_media2.jpg"),
                      fit: BoxFit.cover),
                ),
                child: ListView.builder(
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
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                    }),
              );
            }
          },
        ),
      ),
    );
  }
}
