import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_hotel/dao/home_dao.dart';
import 'package:flutter_hotel/pages/my_page.dart';
import 'package:flutter_hotel/pages/search_page.dart';
import 'package:flutter_hotel/pages/travel_page.dart';
import 'package:flutter_hotel/pages/home_page.dart';

class TabNavigatorPage extends StatefulWidget {
  @override
  _TabNavigatorPageState createState() => _TabNavigatorPageState();
}

class _TabNavigatorPageState extends State<TabNavigatorPage> {

  int _currentIndex = 0;

  PageController _pageController = PageController(
      initialPage: 0
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          SearchPage(),
          TravelPage(),
          MyPage()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex:_currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index){
            _pageController.jumpToPage(index);
            setState(() {
              _currentIndex=index;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('搜索')),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt), title: Text('旅拍')),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), title: Text('我的')),
          ]),

    );
  }

//  String text() {
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result.toJson());
//      });
//    }).catchError((e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    });
//  }
}















































