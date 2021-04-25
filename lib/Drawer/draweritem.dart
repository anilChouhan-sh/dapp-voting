import 'package:dapp_voting/Drawer/Myprofile.dart';
import 'package:dapp_voting/Firebase/auth.dart';
import 'package:dapp_voting/Sign-up/Login.dart';
import 'package:dapp_voting/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = new Auth();
    return DrawerHeader(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(CupertinoIcons.profile_circled),
            title: Text('My Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/myprofile');
            },
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.login_outlined),
              title: Text('Logout'),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text("Are you sure you want to Logout"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text(
                            "Logout",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            await auth.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => mainscreen()));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
