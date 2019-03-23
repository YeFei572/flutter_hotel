import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pinkAccent),
//        home: IndexPage(),
      ),
    );
  }
}
