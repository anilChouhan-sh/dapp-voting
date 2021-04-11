import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
            // decoration: BoxDecoration(
            //     color: Colors.white12,
            //     borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(50),
            //         bottomRight: Radius.circular(20))),
          ),
          Text("   Participants list ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontStyle: FontStyle.italic)),
          ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 10,
                  margin: const EdgeInsets.fromLTRB(40, 0, 40, 5),
                  shadowColor: Colors.orange[50],
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue,
                        height: 250,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Image.asset("images/profile.jpg"),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Lakshay",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontStyle: FontStyle.italic)),
                                Expanded(
                                  child: RaisedButton(
                                    color: Colors.orange,
                                    child: Text(
                                      "VOTE",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                );
              })
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
