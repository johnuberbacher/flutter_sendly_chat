import 'package:flutter/material.dart';
import 'package:sendly_chat/services/authenticate.dart';
import 'package:sendly_chat/services/authentication.dart';
import 'package:sendly_chat/views/profile.dart';

Widget appBarChatRoom(BuildContext context) {
  AuthMethods authMethods = new AuthMethods();
  return AppBar(
    backgroundColor: Color(0xFF1f1e30),
    elevation: 0,
    automaticallyImplyLeading: false,
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.person,
          color: Colors.white,
        ),
        onPressed: () {
          authMethods.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        },
      )
    ],
  );
}

InputDecoration usernameTextFieldInputDecoration(String hintText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(20.0),
    border: new OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    filled: true,
    fillColor: Color(0xFF373753),
    prefixIcon: Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        bottom: 1.0,
      ),
      child: Icon(
        Icons.person,
        color: Color(0xFF1f1e30),
      ),
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      color: Color(0xFFb1b2c4),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white38),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(20.0),
    border: new OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    filled: true,
    fillColor: Color(0xFF373753),
    hintText: hintText,
    prefixIcon: Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        bottom: 1.0,
      ),
      child: Icon(
        Icons.remove_red_eye,
        color: Color(0xFF1f1e30),
      ),
    ),
    hintStyle: TextStyle(
      color: Color(0xFFb1b2c4),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white38),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

InputDecoration emailTextFieldInputDecoration(String hintText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(20.0),
    border: new OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    filled: true,
    fillColor: Color(0xFF373753),
    hintText: hintText,
    prefixIcon: Padding(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
        bottom: 1.0,
      ),
      child: Icon(
        Icons.mail_outline,
        color: Color(0xFF1f1e30),
      ),
    ),
    hintStyle: TextStyle(
      color: Color(0xFFb1b2c4),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white38),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
