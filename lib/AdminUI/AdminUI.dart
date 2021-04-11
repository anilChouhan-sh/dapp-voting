import 'package:dapp_voting/Drawer/draweritem.dart';
import 'package:flutter/material.dart';

import '../homepage .dart';

class AdminUI extends StatelessWidget {
  var name = new TextEditingController();
  var id = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerItem(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Text(
            "Hello Admin",
            style: TextStyle(fontSize: 40),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(300),
                ),
                elevation: 3,
                child: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;
                      return SizedBox(
                        height: height - 400,
                        width: width - 400,
                        child: AlertDialog(
                          content: Container(
                            height: 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: name,
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    //border: InputBorder.none,
                                  ),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: id,
                                  decoration: InputDecoration(
                                    hintText: 'Id',
                                    //border: InputBorder.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.green,
                              child: Text(
                                "ADD",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Add Candidates",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 300,
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white70, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    margin: EdgeInsets.fromLTRB(25, 8, 25, 8),
                    child: SizedBox(
                        height: 50,
                        child: Column(
                          children: [],
                        )),
                  );
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.green,
                child: Text(
                  "Start Voting",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  "Stop Voating",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
