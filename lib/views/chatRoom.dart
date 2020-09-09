import 'package:flutter/material.dart';
import 'package:sendly_chat/services/constants.dart';
import 'package:sendly_chat/services/database.dart';
import 'package:sendly_chat/services/functions.dart';
import 'package:sendly_chat/views/conversation.dart';
import 'package:sendly_chat/widgets/widget.dart';
import 'package:sendly_chat/services/authentication.dart';
import 'package:sendly_chat/views/searchUser.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRoomListStream;

  Widget ChatRoomList() {
    return StreamBuilder(
      stream: chatRoomListStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomTile(
                      snapshot.data.documents[index]
                          .data()["chatid"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.documents[index].data()["chatid"]);
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNamePreference();
    setState(() {
      databaseMethods.getChats(Constants.myName).then((value) {
        setState(() {
          chatRoomListStream = value;
        });
      });
    });
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
        body: ChatRoomList(),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatId;
  ChatRoomTile(this.userName, this.chatId);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConversationScreen(chatId),
            ));
      },
      child: Container(
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20.0),
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Color(0xFFd83256),
                    borderRadius: BorderRadius.circular(40)),
                child: Text(
                  "${userName.substring(0, 1).toUpperCase()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                userName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
