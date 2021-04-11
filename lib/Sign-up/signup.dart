import 'package:dapp_voting/Firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Auth auth = new Auth();
  var username = new TextEditingController();
  var password = new TextEditingController();
  var name = new TextEditingController();
  var voterID = new TextEditingController();
  //var  = new TextEditingController();
  GlobalKey<FormState> _formkey = new GlobalKey<FormState>();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Signup',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextFormField(
                  //for name
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: name,
                  cursorColor: Colors.teal[700],
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.ac_unit,
                      color: Colors.teal[700],
                    ),
                    hintText: 'Name',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: TextFormField(
                  //for name
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: voterID,
                  cursorColor: Colors.teal[700],
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.ac_unit,
                      color: Colors.teal[700],
                    ),
                    hintText: 'voterID',
                    border: InputBorder.none,
                  ),
                ),
              ),
              //for Email !!!!!
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
                      Icons.email,
                      color: Colors.teal[700],
                    ),
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),

              //password
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
                      icon: Icon(Icons.visibility),
                      onPressed: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      color: Colors.teal[700],
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),

              RaisedButton(
                color: Colors.teal[700],
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    print('hogayaa     bhai 23 ');
                    User x = await auth.createUser(
                        username.text, password.text, voterID.text, name.text);
                    if (x != null) {
                      Navigator.pop(context);
                    }
                    ;
                  }

                  print('hogayaa     bhai');
                },
                child: Text(
                  'Sign-up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
