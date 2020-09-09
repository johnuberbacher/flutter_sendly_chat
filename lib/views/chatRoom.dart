import 'package:flutter/material.dart';
import 'package:sendly_chat/services/constants.dart';
import 'package:sendly_chat/services/functions.dart';
import 'package:sendly_chat/widgets/widget.dart';
import 'package:sendly_chat/services/authentication.dart';
import 'package:sendly_chat/views/searchUser.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNamePreference();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: new Scaffold(
        appBar: appBarChatRoom(context),
        floatingActionButton: Container(
          width: 70,
          height: 70,
          child: FloatingActionButton(
            backgroundColor: Color(0xFFd83256),
            child: Image.asset('assets/icons/sendly-white.png', width: 30.0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchUser()),
                // to logout:   MaterialPageRoute(builder: (context) => SearchUser()),
              );
            },
          ),
        ),
        backgroundColor: Color(0xFF1f1e30),
        // appBar: appBarMain(context),
        body: ScrollConfiguration(
          behavior: new ScrollBehavior()
            ..buildViewportChrome(context, null, AxisDirection.down),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(30.0),
              child: Column(),
            ),
          ),
        ),
      ),
    );
  }
}
