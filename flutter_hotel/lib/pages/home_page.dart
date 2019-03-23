import 'package:flutter/material.dart';
import 'package:flutter_hotel/dao/home_dao.dart';
import 'package:flutter_hotel/model/common_model.dart';
import 'package:flutter_hotel/model/config_model.dart';
import 'package:flutter_hotel/model/grid_nav_model.dart';
import 'package:flutter_hotel/model/home_model.dart';
import 'package:flutter_hotel/model/sales_box_model.dart';
import 'package:flutter_hotel/widget/grid_nav.dart';
import 'package:flutter_hotel/widget/local_nav.dart';
import 'package:flutter_hotel/widget/sub_nav.dart';
import 'package:flutter_hotel/widget/webview.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  double appBarAlpha = 0;
  ConfigModel config;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  GridNavModel gridNav;
  SalesBoxModel salesBox;

  _onScroll(double offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    print('offser  $offset  alpha $alpha');
  }

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    print('homepage initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0Xfff2f2f2),
        body: Stack(
          children: <Widget>[
            //移除顶部的消息栏padding
            MediaQuery.removePadding(
              removeTop: true,
              context: context,
              //滚动监听
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    //scrollNotification is ScrollUpdateNotification滚动且是列表滚动的时候
                    //scrollNotification.depth == 0 包裹第一个子类滚动时
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: _listWidget(context),
              ),
            ),
            //顶部搜索appBar
            _searchAppBar()
          ],
        ));
  }

  Widget _searchAppBar() {
    return Opacity(
      opacity: appBarAlpha,
      child: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text('首页'),
          ),
        ),
      ),
    );
  }

  //list布局
  _listWidget(context) {
    return ListView(
      children: <Widget>[
        Container(
          height: 160,
          child: Swiper(
            itemCount: bannerList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebView(
                                url: bannerList[index].url,
                                statusBarColor:
                                    bannerList[index].statusBarColor,
                                hideAppBar: bannerList[index].hideAppBar,
                              )));
                },
                child: Image.network(
                  bannerList[index].icon,
                  fit: BoxFit.cover,
                ),
              );
            },
            autoplay: true,
            pagination: SwiperPagination(),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(
            loaclnavList: localNavList,
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: GridNav(gridNav: gridNav)),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: SubNav(
            subnavList: subNavList,
          ),
        ),
        Container(
          height: 800,
          child: Text('sdfhsf'),
        )
      ],
    );
  }

  void loadData() async {
    try {
      HomeModel model = await HomeDao.fetch();
      bannerList = model.bannerList;
      bannerList.removeAt(0);
      print("加载数据...${bannerList.length}");
      List<CommonModel> lsit = [];
      setState(() {
        localNavList = model.localNavList;
        gridNav = model.gridNav;
        subNavList = model.subNavList;
        this.bannerList = bannerList;
        salesBox = model.salesBox;
        config = model.config;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
