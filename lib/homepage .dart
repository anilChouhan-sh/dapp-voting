import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dapp_voting/AdminUI/AdminUI.dart';
import 'package:dapp_voting/Firebase/Providers/candidatesProvider.dart';
import 'package:dapp_voting/Firebase/Providers/userProviders.dart';
import 'package:dapp_voting/Firebase/candidates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'Blockchain/contract_linking.dart';
import 'Drawer/draweritem.dart';
import 'Firebase/users.dart';

class Homepage extends StatelessWidget {
  String admin = "ZEaA8e7mTOU07JysJtqIQobP4ON2";
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
    var contractLink = Provider.of<ContractLinking>(context, listen: false);
    var candidatesProvider =
        Provider.of<CandidatesProvider>(context, listen: false);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    Future<void> user() async {
      DocumentSnapshot x = await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get();

      userProvider.changeCurrentUser = Users.fromJson(x.data());

      print("key updated");
    }

    user().whenComplete(() {
      contractLink.changekey = userProvider.currentUser.privatekey;
      contractLink.getCredentials(true);
    });
    print("builing it?");
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Scaffold(
        drawer: Drawer(
          child: DrawerItem(),
        ),
        body: FirebaseAuth.instance.currentUser.uid == admin
            ? AdminUI()
            : Column(
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
                  Row(
                    children: [
                      Text("   Participants list ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontStyle: FontStyle.italic)),
                      FlatButton(
                        child: Text(
                          'Show Result',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                        onPressed: () {},
                      )
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 500,
                      child: StreamBuilder<List<Candidates>>(
                        stream: candidatesProvider.candidates,
                        builder: (context, snapshot) {
                          if (snapshot.data.length == 0) {
                            return Center(
                              child: Text(
                                "Voting has not started(:",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.orange),
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.fromLTRB(35, 5, 35, 5),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.blue,
                                  child: Container(
                                    height: 200,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child:
                                              Image.asset("images/profile.jpg"),
                                        ),
                                        Text(snapshot.data[index].name,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 35,
                                                fontStyle: FontStyle.italic)),
                                        RaisedButton(
                                          color: Colors.orange,
                                          child: Text(
                                            "VOTE",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            contractLink.givevoteTo(
                                                BigInt.from(
                                                    snapshot.data[index].id),
                                                myToast,
                                                context);
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
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
