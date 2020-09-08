import 'package:flutter/material.dart';
import 'package:social_app/models/Comment.dart';
import 'package:social_app/pages/profile_page.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  CommentWidget(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  (MaterialPageRoute(
                      builder: (context) => ProfilePage(comment.userId))));
            },
            child: Row(
              children: [
                CircleAvatar(
                    radius: 17,
                    backgroundImage: NetworkImage(
                      "http://127.0.0.1:8000/storage/pic_url/" + comment.picUrl,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  comment.username,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            comment.comment,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
