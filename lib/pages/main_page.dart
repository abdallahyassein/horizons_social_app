import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/friend_requests_page.dart';
import 'package:social_app/pages/posts_page.dart';
import 'package:social_app/pages/profile_page.dart';
import 'package:social_app/pages/search_page.dart';
import 'package:social_app/providers/UserProvider.dart';
import 'package:social_app/widgets/drawer.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;
  TextEditingController searchData = new TextEditingController();
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).getUserInf();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          drawer: MainDrawer(),
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
                            builder: (context) =>
                                SearchPage(searchData.text))));
                  }
                },
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/social_media2.jpg"),
                  fit: BoxFit.cover),
            ),
            child: PageView(
                children: [
                  PostsPage(),
                  FriendRequestsPage(),
                  ProfilePage(user.id),
                ],

                /// Specify the page controller
                controller: _pageController,
                onPageChanged: onPageChanged),
          ),
          bottomNavigationBar: new BottomNavigationBar(
              backgroundColor: Colors.deepOrange[100],
              items: [
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.announcement),
                    title: new Text("posts")),
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.people), title: new Text("requests")),
                new BottomNavigationBarItem(
                    icon: new Icon(Icons.account_box),
                    title: new Text("profile")),
              ],

              /// Will be used to scroll to the next page
              /// using the _pageController
              onTap: navigationTapped,
              currentIndex: _page)),
    );
  }

  /// Called when the user presses on of the
  /// [BottomNavigationBarItem] with corresponding
  /// page index
  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
