import 'package:flutter/material.dart';
import 'package:handle_chat/widgets/widget.dart';
import 'package:handle_chat/services/authentication.dart';
import 'package:handle_chat/views/chatRoom.dart';
import 'package:handle_chat/views/signIn.dart';

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
        // print("${val.uid}");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1f1e30),
        elevation: 0,
      ),
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
                  child: Center(
                    child: Column(
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 15.0),
                                child: Text(
                                  "Create an Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 40.0),
                                child: Text(
                                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Neque egestas congue quisque egestas diam in arcu cursus. ",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20.0,
                                ),
                                width: double.infinity,
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  validator: (val) {
                                    return val.isEmpty || val.length < 4
                                        ? "Please enter handle"
                                        : null;
                                  },
                                  controller: userNameTextEditingController,
                                  style: TextStyle(color: Colors.white),
                                  autofocus: false,
                                  decoration: usernameTextFieldInputDecoration(
                                      'handle'),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  bottom: 20.0,
                                ),
                                width: double.infinity,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+|.[a-zA-Z]+")
                                            .hasMatch(val)
                                        ? null
                                        : "Please enter a valid handle";
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
                                  keyboardType: TextInputType.visiblePassword,
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
                                    'CREATE ACCOUNT',
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
                                width: double.infinity,
                                child: GestureDetector(
                                  child: const Text(
                                    "Already have an account? Sign In",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()),
                                    );
                                  },
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
            ),
    );
  }
}
