import 'package:dapp_voting/Blockchain/contract_linking.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    var linkPorvider = Provider.of<ContractLinking>(context);
    Map res;
    List parseresults() {
      List ans = linkPorvider.ans;
      List temp;
      if (ans != null) {
        res = Map.fromIterables(ans[0], ans[1]);
        setState(() {});
      } else {
        ans = [
          [0, 0],
          [0, 0],
          [0, 0]
        ];
      }
      print("ans ---- > $res");
      return ans;
    }

    List _final = parseresults();
    return res[32] <= 0
        ? Scaffold(
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
                    "Congratulations",
                    style: TextStyle(fontSize: 40, color: Colors.orange),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(res[31]),
                          Card(
                            color: Colors.green,
                            // margin: EdgeInsets.fromLTRB(25, 20, 5, 0),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Center(
                                  child: Text("2",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))),
                            ),
                          ),
                          Text("Candidate 1")
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(res[32]),
                          Card(
                            color: Colors.orange,
                            // margin: EdgeInsets.fromLTRB(25, 20, 5, 5),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.white70, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: 120,
                              width: 100,
                              child: Center(
                                  child: Text("1",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))),
                            ),
                          ),
                          Text("Candidate 2")
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(res[13]),
                          Card(
                            color: Colors.blue,
                            //margin: EdgeInsets.fromLTRB(25, 20, 5, 0),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                            ),
                          ),
                          Text("Candidate 1")
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        : Text("Waiting");
  }
}
