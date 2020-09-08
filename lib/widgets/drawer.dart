import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_app/providers/UserProvider.dart';
import 'package:social_app/widgets/drawer_header.dart';
import 'package:social_app/pages/login_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHead("assets/images/social_media.jpg"),
          SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.redAccent,
            ),
            title: Text(
              "Log out",
              style: GoogleFonts.abel(
                  textStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              )),
            ),
            onTap: () {
              Provider.of<UserProvider>(context, listen: false).logout().then(
                  (value) => Navigator.push(context,
                      (MaterialPageRoute(builder: (context) => Login()))));
            },
          )
        ],
      ),
    );
  }
}
