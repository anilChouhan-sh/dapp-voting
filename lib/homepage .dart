import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'image/vote.jpg',
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
          Expanded(
              child: SizedBox(
            height: 500,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
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
                            child: Image.asset("image/profile.jpg"),
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
