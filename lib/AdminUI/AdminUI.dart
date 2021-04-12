import 'package:dapp_voting/Blockchain/contract_linking.dart';
import 'package:dapp_voting/Drawer/draweritem.dart';
import 'package:dapp_voting/Firebase/Providers/candidatesProvider.dart';
import 'package:dapp_voting/Firebase/candidates.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../homepage .dart';

class AdminUI extends StatelessWidget {
  var name = new TextEditingController();
  var id = new TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    var linkPorvider = Provider.of<ContractLinking>(context);
    var candidates = Provider.of<CandidatesProvider>(context);
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
                      // var height = MediaQuery.of(context).size.height;
                      // var width = MediaQuery.of(context).size.width;
                      return AlertDialog(
                        content: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
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
                              candidates.changeid = int.parse(id.text.trim());
                              candidates.changename = name.text.trim();
                              candidates.savecandidates();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
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
            child: StreamBuilder<List<Candidates>>(
                stream: candidates.candidates,
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
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
                              child: Text(snapshot.data[index].name)),
                        );
                      });
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
                onPressed: () {
                  linkPorvider.start_voting(myToast);
                },
              ),
              SizedBox(
                width: 10,
              ),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  "Stop Voting",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  linkPorvider.start_voting(myToast);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
