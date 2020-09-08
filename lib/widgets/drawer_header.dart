import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_app/providers/UserProvider.dart';

class DrawerHead extends StatelessWidget {
  final String image;

  DrawerHead(this.image);

  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context, listen: false).getUserInf();

    return Container(
      child: DrawerHeader(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    "http://127.0.0.1:8000/storage/pic_url/" +
                        userProvider.picUrl,
                  ),
                  radius: 35.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  userProvider.name,
                  style: GoogleFonts.antic(
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    fontSize: 17,
                  ),
                ),
                Text(
                  userProvider.address,
                  style: GoogleFonts.antic(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    fontSize: 13,
                  ),
                ),
                Text(
                  userProvider.email,
                  style: GoogleFonts.antic(
                    textStyle: TextStyle(
                      color: Colors.white,
                    ),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(103, 147, 203, 1),
        ),
      ),
    );
  }
}
