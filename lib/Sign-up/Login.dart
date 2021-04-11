import 'package:dapp_voting/Firebase/Providers/userProviders.dart';
import 'package:dapp_voting/Firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User user = FirebaseAuth.instance.currentUser;
  Auth auth = new Auth();
  GlobalKey<FormState> _formlogin = new GlobalKey<FormState>();
  var username = new TextEditingController();
  var password = new TextEditingController();
  var name = new TextEditingController();
  myToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool obscure = false;
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return WillPopScope(
        onWillPop: () {
          SystemNavigator.pop();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.teal[700],
            title: Text(
              'DAPP_Voting',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Center(
            child: Form(
              key: _formlogin,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "DAPP_Voting",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: username,
                      cursorColor: Colors.teal[700],
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.teal[700],
                        ),
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  //  SizedBox(height: 10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      obscureText: obscure,
                      controller: password,
                      cursorColor: Colors.teal[700],
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: Colors.teal[700],
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          icon: Icon(
                            Icons.visibility,
                          ),
                          color: Colors.teal[700],
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text("LOGIN"),
                    onPressed: () async {
                      if (_formlogin.currentState.validate()) {
                        String x = await auth.signIn(
                            username.text.trim(), password.text);
                        if (x == null) {
                          showAboutDialog(context: context, children: [
                            Center(
                              child: LoadingBumpingLine.circle(
                                borderColor: Colors.teal[700],
                              ),
                            )
                          ]);
                        }
                        if (FirebaseAuth.instance.currentUser.emailVerified) {
                          Navigator.pushNamed(context, '/');
                        } else {
                          myToast('Email Not verified.');
                        }
                        //  await auth.currentUser(context);
                        print('haa bhai');
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text("SIGN UP"),
                    color: Colors.teal[100],
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
