import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/main_page.dart';
import 'package:social_app/pages/register_page.dart';
import 'package:social_app/providers/UserProvider.dart';
import 'package:social_app/widgets/loading_progress.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  bool isLoading = false;

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('please insert right credintionals.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
          ],
        );
      },
    );
  }

  _login() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await Provider.of<UserProvider>(context, listen: false)
          .login(email.text, password.text)
          .then((value) {
        // print(value);
        if (value == true) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        } else {
          _showMyDialog();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? LoadingProgress()
            : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/main_back.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Card(
                              color: Color.fromRGBO(56, 56, 56, 0.9),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      "HORIZONS",
                                      style: GoogleFonts.abel(
                                          textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 45,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.italic,
                                      )),
                                    ),
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: TextFormField(
                                                  controller: email,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  onEditingComplete: () =>
                                                      FocusScope.of(context)
                                                          .nextFocus(),
                                                  decoration: InputDecoration(
                                                      hintText: "Email",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'please write the email';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              child: TextFormField(
                                                  controller: password,
                                                  onEditingComplete: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                      hintText: "Password",
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      border: InputBorder.none),
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'please write the password';
                                                    }
                                                    return null;
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    InkWell(
                                      child: Container(
                                        height: 50,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 50),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.blue[300]),
                                        child: Center(
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      onTap: _login,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    FlatButton(
                                        child: Text(
                                          "Register",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Register()));
                                        })
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
