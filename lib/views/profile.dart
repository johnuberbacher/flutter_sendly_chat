import 'package:flutter/material.dart';
import 'package:sendly_chat/services/authenticate.dart';
import 'package:sendly_chat/services/authentication.dart';

class ProfileScreen extends StatelessWidget {
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1f1e30),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
          )
        ],
      ),
    );
  }
}
