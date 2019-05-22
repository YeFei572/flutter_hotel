import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_page/blue_tooth_page.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            ClipPath(
              clipper: BottomClipperTest(),
              child: Container(
                color: Colors.deepPurpleAccent,
                height: 200.0,
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://jspang.com/static//myimg/blogtouxiang.jpg',
                        scale: 36),
                  ),
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => BlueToothPage()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.black12,
                border: Border(
                    bottom: BorderSide(color: Colors.black12, width: 1))),
            child: ListTile(
              title: Text('蓝牙'),
            ),
          ),
        )
      ],
    ));
  }
}

class BottomClipperTest extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 30);
    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, size.height - 30);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
