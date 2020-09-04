import 'package:flutter/material.dart';
import '../widgets/widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 90.0, bottom: 40.0),
                  child: Image.asset('assets/icons/handle-chat-logo-shadow.png',
                      width: 170.0),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  width: double.infinity,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    autofocus: false,
                    decoration: usernameTextFieldInputDecoration('username'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20.0,
                  ),
                  width: double.infinity,
                  child: TextField(
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
                    onPressed: () {},
                    textColor: Colors.white,
                    padding: const EdgeInsets.only(
                      top: 17.0,
                      right: 30.0,
                      bottom: 17.0,
                      left: 30.0,
                    ),
                    child: const Text(
                      'SIGN IN',
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
                      'SIGN IN WITH GOOGLE',
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
                  child: const Text(
                    "Don't have an account? Register Now",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
