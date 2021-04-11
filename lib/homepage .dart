import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Firebase/auth.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerItem(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 280,

            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: ClipPath(
              child: Image.asset(
                'images/vote.jpg',
              ),
              clipper: CustomClipPath(),
            ),
          ),
          Text("   Participants list ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontStyle: FontStyle.italic)),
          Expanded(
              child: SizedBox(
            height: 500,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.fromLTRB(35, 5, 35, 5),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.blue,
                    child: Container(
                      height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Image.asset("images/profile.jpg"),
                          ),
                          Text("Lakshay",
                              style: TextStyle(
                                  fontSize: 35, fontStyle: FontStyle.italic)),
                          RaisedButton(
                            color: Colors.orange,
                            child: Text(
                              "VOTE",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ))
        ],
      ),
    );
  }
}

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
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MyProfile()));
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
                              Navigator.pushNamed(context, '/');
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.elliptical(30, 10));
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
