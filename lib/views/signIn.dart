import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sendly_chat/services/authentication.dart';
import 'package:sendly_chat/services/database.dart';
import 'package:sendly_chat/widgets/widget.dart';
import 'package:sendly_chat/services/functions.dart';
import 'package:sendly_chat/views/chatRoom.dart';

@override
class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  userSignIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailPreference(emailTextEditingController.text);

      databaseMethods
          .getUserByUserEmail(emailTextEditingController.text)
          .then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserNamePreference(
            snapshotUserInfo.docs[0].data()["name"]);
      });
      setState(() {
        isLoading = true;
      });
      authMethods
          .signInWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1e30),
      // appBar: appBarMain(context),
      body: ScrollConfiguration(
        behavior: new ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 120.0, bottom: 100.0),
                      width: 100,
                      height: 100,
                      child:
                          Image.asset('assets/icons/handle.png', width: 100.0),
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          color: Color(0x32d83256),
                        )
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      width: double.infinity,
                      child: TextFormField(
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+|.[a-zA-Z]+")
                                  .hasMatch(val)
                              ? null
                              : "Please enter a valid email address";
                        },
                        style: TextStyle(color: Colors.white),
                        autofocus: false,
                        decoration:
                            usernameTextFieldInputDecoration('email address'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      width: double.infinity,
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (val) {
                          return val.length > 6
                              ? null
                              : "Password must be greater than 6 characters";
                        },
                        controller: passwordTextEditingController,
                        style: TextStyle(color: Colors.white),
                        autofocus: false,
                        decoration: textFieldInputDecoration('password'),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color(0xFFd83256),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        onPressed: () {
                          userSignIn();
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.only(
                          top: 17.0,
                          right: 30.0,
                          bottom: 17.0,
                          left: 30.0,
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color(0xFFf3f3f3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        onPressed: () {},
                        padding: const EdgeInsets.only(
                          top: 17.0,
                          right: 30.0,
                          bottom: 17.0,
                          left: 30.0,
                        ),
                        child: const Text(
                          'LOGIN WITH GOOGLE',
                          style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      width: double.infinity,
                      child: GestureDetector(
                        child: const Text(
                          "Don't have an account? Register Now",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          widget.toggle();
                        },
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
