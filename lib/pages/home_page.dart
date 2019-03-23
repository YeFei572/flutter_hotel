import 'package:flutter/material.dart';
import 'package:flutter_xiecheng/dao/home_dao.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String resultString = " 数据展示";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(resultString),
      ),
    );
  }

//  String text() {
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    });
//  }
}
