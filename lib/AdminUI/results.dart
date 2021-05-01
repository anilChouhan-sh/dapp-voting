import 'package:dapp_voting/Firebase/Providers/candidatesProvider.dart';
import 'package:dapp_voting/Firebase/candidates.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    var candidateProvider = Provider.of<CandidatesProvider>(context);

    double getheight(int votes, double _total) {
      if (_total == 0) return 0;
      double percent = (votes / _total) * 200;
      print(percent);
      return percent;
    }

    return StreamBuilder<List<Candidates>>(
        stream: candidateProvider.candidates,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            snapshot.data.sort((a, b) => b.votes - a.votes);
            double _total = 0;
            snapshot.data.forEach((a) => _total += a.votes);

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
                      "Congratulations",
                      style: TextStyle(fontSize: 40, color: Colors.orange),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 0),
                    child: ListView.builder(
                        itemCount: snapshot.data.length <= 3
                            ? snapshot.data.length
                            : 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 100,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(snapshot.data[index].votes.toString(),
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 16)),
                                Card(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    height: getheight(
                                        snapshot.data[index].votes, _total),
                                    width: 100,
                                    child: Center(
                                        // child: Text(
                                        //     snapshot.data[index].votes
                                        //         .toString(),
                                        //     style: TextStyle(
                                        //         color: Colors.white,
                                        //         fontSize: 20))
                                        ),
                                  ),
                                ),
                                Text(snapshot.data[index].name)
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: 50),
                  snapshot.data.length - 3 > 0
                      ? Card(

                          //height: 200,
                          child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length - 3,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "Name:${snapshot.data[index + 3].name}  Votes: ${snapshot.data[index + 3].votes}"),
                            );
                          },
                        ))
                      : Container()
                ],
              ),
            );
          }
          return Center(
            child: Text("loading results"),
          );
        });
  }
}
