import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sendly_chat/widgets/widget.dart';
import 'package:sendly_chat/services/database.dart';
import 'package:sendly_chat/services/constants.dart';
import 'package:sendly_chat/views/conversation.dart';

class SearchUser extends StatefulWidget {
  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapshot;

  getSearch() async {
    databaseMethods
        .getUserByUsername(searchTextEditingController.text)
        .then((val) {
      print(val.toString());
      print(searchTextEditingController.text.toString());
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                userName: searchSnapshot.docs[index].data()["name"],
                userEmail: searchSnapshot.docs[index].data()["email"],
              );
            })
        : Container();
  }

  createNewConversation({String userName}) {
    print("${Constants.myName}");
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {"users": users, "chatid": chatRoomId};
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ConversationScreen()));
    } else {
      print("Error");
    }
  }

  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white12,
      ),
      margin: const EdgeInsets.only(
        left: 30.0,
        right: 30.0,
        bottom: 5.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 5.0,
          top: 15.0,
          bottom: 15.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  userEmail,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              child: MaterialButton(
                color: Color(0xFFd83256),
                shape: CircleBorder(),
                onPressed: () {
                  createNewConversation(userName: userName);
                },
                padding: EdgeInsets.all(12),
                child: Image.asset('assets/icons/sendly-white.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUserInfo(String name) async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: name)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  @override
  void initState() {
    getUserInfo(searchTextEditingController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1f1e30),
        elevation: 0,
      ),
      backgroundColor: Color(0xFF1f1e30),
      body: ScrollConfiguration(
        behavior: new ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              bottom: 30.0,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: TextFormField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[a-z0-9_]")),
                    ],
                    textCapitalization: TextCapitalization.none,
                    controller: searchTextEditingController,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      return val.isEmpty || val.length < 4
                          ? "Please enter username"
                          : null;
                    },
                    style: TextStyle(color: Colors.white),
                    autofocus: false,
                    decoration:
                        usernameTextFieldInputDecoration('search by username'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 30.0,
                    bottom: 30.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  width: double.infinity,
                  child: RaisedButton(
                    color: Color(0xFFd83256),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      getSearch();
                    },
                    padding: const EdgeInsets.only(
                      top: 17.0,
                      right: 30.0,
                      bottom: 17.0,
                      left: 30.0,
                    ),
                    child: const Text(
                      'SEARCH',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                searchList(),
              ],
            ),
          ),
        ),
      ),
    );
    // appBar: appBarMain(context),);
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
