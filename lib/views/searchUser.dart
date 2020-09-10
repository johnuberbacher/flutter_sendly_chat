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
        ? Expanded(
            child: ListView.builder(
                itemCount: searchSnapshot.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SearchTile(
                    userName: searchSnapshot.docs[index].data()["name"],
                    userEmail: searchSnapshot.docs[index].data()["email"],
                  );
                }),
          )
        : Container();
  }

  createNewConversation({String userName}) {
    // print logged in users name
    print("${Constants.myName}");
    if (userName != Constants.myName) {
      print(userName);
      String chatId = getchatId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {"users": users, "chatid": chatId};
      DatabaseMethods().createChatRoom(chatId, chatRoomMap);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ConversationScreen(chatId)));
    } else {
      // if you try to have a conversation with yourself
      print("Error");
    }
  }

  Widget SearchTile({String userName, String userEmail}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(50),
      ),
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
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
            Container(
              height: 50,
              child: MaterialButton(
                color: Color(0xFFd83256),
                shape: CircleBorder(),
                onPressed: () {
                  createNewConversation(userName: userName);
                },
                padding: EdgeInsets.all(12),
                child: Image.asset('assets/icons/sendly_white.png'),
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
      body: Container(
        margin: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: 30.0,
        ),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[a-z0-9_]")),
                ],
                textCapitalization: TextCapitalization.none,
                controller: searchTextEditingController,
                autofocus: true,
                keyboardType: TextInputType.text,
                validator: (val) {
                  return val.isEmpty || val.length < 4
                      ? "Please enter username"
                      : null;
                },
                style: TextStyle(color: Colors.white),
                decoration:
                    usernameTextFieldInputDecoration('search by username'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
                bottom: 20.0,
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
                  right: 20.0,
                  bottom: 17.0,
                  left: 20.0,
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
    );
    // appBar: appBarMain(context),);
  }
}

getchatId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
