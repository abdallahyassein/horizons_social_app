import 'package:flutter/material.dart';
import 'package:social_app/helpers/PostHelper.dart';
import 'package:social_app/models/Post.dart';
import 'package:social_app/pages/profile_page.dart';
import 'package:social_app/widgets/comment_widget.dart';

class PostWithImage extends StatefulWidget {
  final Post post;
  final String token;
  final Function gotoWhenComment;

  PostWithImage(this.post, this.token, this.gotoWhenComment);

  @override
  _PostWithImageState createState() => _PostWithImageState();
}

class _PostWithImageState extends State<PostWithImage>
    with AutomaticKeepAliveClientMixin {
  bool isLiked;

  int numberOfLikes;

  TextEditingController comment = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    isLiked = widget.post.isLiked;
    numberOfLikes = widget.post.likes.length;

    super.initState();
  }

  submitComment(postId, comment, token) {
    if (_formKey.currentState.validate()) {
      PostHelper.commentPost(postId, comment, token);
      widget.gotoWhenComment();
    }
  }

  List<Widget> getImages() {
    List<Widget> widgets = [];

    for (int i = 0; i < widget.post.images.length; i++) {
      widgets.add(Image.network(
        "http://127.0.0.1:8000/storage/images/" +
            widget.post.images[i].imageUrl,
        height: 200,
        width: 300,
        fit: BoxFit.cover,
      ));
      widgets.add(Padding(padding: EdgeInsets.only(bottom: 10)));
    }
    return widgets.toList();
  }

  List<Widget> getComments() {
    List<Widget> widgets = [];

    for (int i = 0; i < widget.post.comments.length; i++) {
      widgets.add(CommentWidget(widget.post.comments[i]));

      widgets.add(Padding(padding: EdgeInsets.only(bottom: 10)));
    }

    return widgets.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(203, 221, 244, 0.95),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            "http://127.0.0.1:8000/storage/pic_url/" +
                                widget.post.user.picUrl,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.post.user.name,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        (MaterialPageRoute(
                            builder: (context) =>
                                ProfilePage(widget.post.user.id))));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(widget.post.description),
                SizedBox(
                  height: 20,
                ),
                widget.post.images.length == 0
                    ? Text("")
                    : Container(
                        width: double.infinity,
                        child: IntrinsicHeight(
                            child: Column(
                          children: getImages(),
                        )),
                      ),
              ],
            ),
          ),
          Divider(),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: EdgeInsets.all(10),
            color: Color.fromRGBO(203, 221, 244, 0.95),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.black26,
                          size: 40,
                        ),
                        onPressed: () {
                          PostHelper.likePost(widget.post.id, widget.token);

                          if (isLiked) {
                            isLiked = false;
                            numberOfLikes--;
                          } else {
                            isLiked = true;
                            numberOfLikes++;
                          }

                          setState(() {});
                        }),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      (numberOfLikes).toString(),
                      style: TextStyle(color: Colors.black26),
                    ),
                  ],
                ),
                Container(height: 80, child: VerticalDivider()),
                IconButton(
                    icon: Icon(
                      Icons.comment,
                      size: 40,
                      color: Colors.black26,
                    ),
                    onPressed: () {
                      submitComment(widget.post.id, comment.text, widget.token);
                    }),
              ],
            ),
          ),
          Divider(),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        controller: comment,
                        decoration: InputDecoration(
                            hintText: "Comment here.....",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                        validator: (val) {
                          if (val.isEmpty) {
                            return "please write a comment";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )),
          ),
          Divider(),
          widget.post.comments.length == 0
              ? Text("")
              : Column(
                  children: getComments(),
                ),
        ],
      ),
    );
  }
}
