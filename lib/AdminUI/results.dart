import 'package:dapp_voting/Blockchain/contract_linking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Results extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var linkPorvider = Provider.of<ContractLinking>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Congratulation",
              style: TextStyle(fontSize: 40, color: Colors.orange),
            ),
          ),
          Row(
            children: [
              Card(
                color: Colors.orange,
                margin: EdgeInsets.fromLTRB(25, 20, 10, 5),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 120,
                  width: 100,
                  child: Center(
                      child: Text("1",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ),
              Card(
                color: Colors.green,
                margin: EdgeInsets.fromLTRB(25, 20, 10, 0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Center(
                      child: Text("2",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ),
              Card(
                color: Colors.blue,
                margin: EdgeInsets.fromLTRB(25, 20, 10, 0),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.white70, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 80,
                  width: 100,
                  child: Center(
                      child: Text(
                    "3",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
