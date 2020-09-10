import 'package:flutter/material.dart';
import 'package:sendly_chat/services/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sendly_chat/services/authenticate.dart';
import 'package:sendly_chat/services/authentication.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthMethods authMethods = new AuthMethods();

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get()
        .catchError((e) {
      print(e.toString());
    });
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
    print(Constants.myName);
    getUserByUserEmail(Constants.myName);
    getUserInfo(Constants.myName);
    super.initState();
    print(Constants.myName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1e30),
      appBar: AppBar(
        backgroundColor: Color(0xFF1f1e30),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
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
      body: ScrollConfiguration(
        behavior: new ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 30.0),
                  height: 130,
                  child: MaterialButton(
                    color: Color(0xFFd83256),
                    shape: CircleBorder(),
                    onPressed: () {},
                    padding: EdgeInsets.all(30),
                    child: Image.asset('assets/icons/sendly-white.png'),
                  ),
                ),
                Text(
                  Constants.myName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  Constants.myEmail,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
