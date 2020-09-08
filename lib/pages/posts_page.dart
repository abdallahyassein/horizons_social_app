import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/helpers/PostHelper.dart';
import 'package:social_app/pages/main_page.dart';
import 'package:social_app/providers/UserProvider.dart';
import 'package:social_app/widgets/loading_progress.dart';
import 'package:social_app/widgets/post_widget.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    var token = Provider.of<UserProvider>(context).getToken();
    var posts = PostHelper.getMainPosts(token);

    return FutureBuilder(
      future: posts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingProgress();
        } else if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasData) {
          return Center(
            child: Text("there are no posts right now"),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                var allposts = snapshot.data;
                //  print(i);
                return PostWithImage(allposts[i], token, () {
                  Navigator.push(context,
                      (MaterialPageRoute(builder: (context) => MainPage())));
                });
              });
        }
      },
    );
  }
}
