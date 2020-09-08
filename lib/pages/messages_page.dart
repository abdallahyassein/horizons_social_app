import 'package:flutter/material.dart';
import 'package:social_app/helpers/MessageHelper.dart';
import 'package:social_app/widgets/loading_progress.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class MessagePage extends StatefulWidget {
  final String friendId;
  final String token;
  MessagePage(this.friendId, this.token);
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var messages = MessageHelper.getMessages(widget.friendId, widget.token);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Chat Room"),
        ),
        body: FutureBuilder(
          future: messages,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingProgress();
            } else if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasData) {
              return Center(
                child:
                    Text("there are no messages between you and this person"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    var messages = snapshot.data;
                    bool checkYourProfile =
                        messages[i].user.id == widget.friendId ? false : true;
                    //  print(i);
                    return Container(
                      padding: EdgeInsets.all(40),
                      child: Card(
                        color: checkYourProfile
                            ? Color.fromRGBO(203, 221, 244, 0.95)
                            : Colors.white,
                        child: Row(
                          children: [
                            checkYourProfile
                                ? CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        "http://127.0.0.1:8000/storage/pic_url/" +
                                            messages[i].user.picUrl))
                                : Container(),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                messages[i].message,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            !checkYourProfile
                                ? CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        "http://127.0.0.1:8000/storage/pic_url/" +
                                            messages[i].user.picUrl))
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
        bottomSheet: SolidBottomSheet(
          headerBar: Container(
            color: Colors.blue[200],
            height: 50,
            child: Center(
              child: Text("Swipe to send message"),
            ),
          ),
          body: Container(
              height: kToolbarHeight,
              color: Colors.blue[200],
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: message,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Send Message",
                    suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (message.text.isNotEmpty) {
                            MessageHelper.sendMessage(
                                    widget.friendId, message.text, widget.token)
                                .then((value) {
                              message.clear();
                              setState(() {});
                            });
                          }
                        })),
              )),
        ),
      ),
    );
  }
}
