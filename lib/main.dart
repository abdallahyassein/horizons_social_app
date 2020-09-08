import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/pages/login_page.dart';
import 'package:social_app/providers/UserProvider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

          providers: [
            ChangeNotifierProvider(create: (_) => UserProvider()),
          ],
          child: MaterialApp(
          title: 'Social App',
          theme: ThemeData(

      primarySwatch: Colors.blue,

      visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Login(),
        ),
    );
  }
}


