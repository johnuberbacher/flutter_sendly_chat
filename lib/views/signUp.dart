import 'package:flutter/material.dart';
import 'package:handle_chat/widgets/widget.dart';
import 'package:handle_chat/services/authentication.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  signUpAccount() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        print("$val");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1e30),
      // appBar: appBarMain(context),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ScrollConfiguration(
              behavior: new ScrollBehavior()
                ..buildViewportChrome(context, null, AxisDirection.down),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 0.0, bottom: 40.0),
                              child: Image.asset(
                                  'assets/icons/handle-chat-logo-shadow.png',
                                  width: 170.0),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20.0,
                              ),
                              width: double.infinity,
                              child: TextFormField(
                                validator: (val) {
                                  return val.isEmpty || val.length < 4
                                      ? "Please enter username"
                                      : null;
                                },
                                controller: userNameTextEditingController,
                                style: TextStyle(color: Colors.white),
                                autofocus: false,
                                decoration: usernameTextFieldInputDecoration(
                                    'username'),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20.0,
                              ),
                              width: double.infinity,
                              child: TextFormField(
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+|.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Please enter a valid email address";
                                },
                                controller: emailTextEditingController,
                                style: TextStyle(color: Colors.white),
                                autofocus: false,
                                decoration: emailTextFieldInputDecoration(
                                    'email address'),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                bottom: 20.0,
                              ),
                              width: double.infinity,
                              child: TextFormField(
                                validator: (val) {
                                  return val.length > 6
                                      ? null
                                      : "Password must be greater than 6 characters";
                                },
                                controller: passwordTextEditingController,
                                style: TextStyle(color: Colors.white),
                                autofocus: false,
                                decoration:
                                    textFieldInputDecoration('password'),
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
                                  signUpAccount();
                                },
                                textColor: Colors.white,
                                padding: const EdgeInsets.only(
                                  top: 17.0,
                                  right: 30.0,
                                  bottom: 17.0,
                                  left: 30.0,
                                ),
                                child: const Text(
                                  'SIGN UP',
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
                                  'SIGN UP WITH GOOGLE',
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
                                "Have an Account already? Sign in Now",
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
