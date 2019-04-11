import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hotel/dao/home_dao.dart';
import '../model/common_model.dart';
import '../model/config_model.dart';
import '../model/grid_nav_model.dart';
import '../model/home_model.dart';
import '../model/sales_box_model.dart';
import '../pages/search_page.dart';
import '../widget/loading_container.dart';
import '../widget/grid_nav.dart';
import '../widget/local_nav.dart';
import '../widget/sales_box.dart';
import '../widget/search_bar.dart';
import '../widget/sub_nav.dart';
import '../widget/web_view.dart';
import 'dart:convert';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../widget/custom_route_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../pages/speak_page.dart';
import '../model/config_model.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网上打卡地 景点 酒店 美食';

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
  bool _loading = true;

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
    ///初始化刷新
    _onHanderRefresh();
    print('homepage initState');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0Xfff2f2f2),
        body: LoadingContainer(
            isLoading: _loading,
            child: Stack(
              children: <Widget>[
                ///移除顶部的消息栏padding
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,

                  ///滚动监听
                  child: RefreshIndicator(
                    onRefresh: _onHanderRefresh,
                    child: NotificationListener(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification &&
                            scrollNotification.depth == 0) {
                          ///scrollNotification is ScrollUpdateNotification滚动且是列表滚动的时候
                          ///scrollNotification.depth == 0 包裹第一个子类滚动时
                          _onScroll(scrollNotification.metrics.pixels);
                        }
                      },
                      child: _listWidget(context),
                    ),
                  ),
                ),

                ///顶部搜索appBar
                _searchAppBar()
              ],
            )));
  }

  ///搜索AppBar
  Widget _searchAppBar() {
    ///appBar滚动消失
//    return Opacity(
//      opacity: appBarAlpha,
//      child: Container(
//        height: 80,
//        decoration: BoxDecoration(color: Colors.white),
//        child: Center(
//          child: Padding(
//            padding: EdgeInsets.only(top: 20),
//            child: Text('首页'),
//          ),
//        ),
//      ),
//    );
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: 80.0,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha * 225).toInt(), 225, 225, 225),
            ),
            child: SearchBar(
              searchBarType: appBarAlpha > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),

        ///AppBar底部阴影
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Colors.greenAccent, blurRadius: 0.5)
          ]),
        )
      ],
    );
  }

  ///list主布局
  _listWidget(context) {
    return ListView(
      children: <Widget>[
        _banner,
//        car_banner,
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
        SalesBox(
          salesBox: salesBox,
        ),
      ],
    );
  }

  //TODO 广告轮播图
  Widget get _banner {
    return Container(
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
                            statusBarColor: bannerList[index].statusBarColor,
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
    );
  }

  Widget get car_banner {
    int _current = 0;
    return Stack(
      children: <Widget>[
        CarouselSlider(
//        items: _banneritem(),
          //是否自动轮播，默认为false
          autoPlay: true,
          //当前视图中占用空间，默认为0.8
          viewportFraction: 1.0,
          //图片的宽高比，默认为16/9
          aspectRatio: 2.0,
          //滑动时出去的大小逐渐变小，进来的逐渐变大，默认为true
//        distortion: true,
          //视图页面更新时滴回调函数
          onPageChanged: (index) {
            setState(() {
              print('========= $index');
              _current = index;
            });
          },
          height: 160.0,
          items: bannerList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Image.network(
                    i.icon,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
            left: 0.0,
            right: 40.0,
            bottom: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [0, 1, 2, 3].map((i) {
                return Container(
                  width: 6.0,
                  height: 6.0,
                  margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == i ? Colors.blue : Colors.greenAccent),
                );
              }).toList(),
            ))
      ],
    );
  }

  //TODO 刷新数据
  Future<void> _onHanderRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      print("加载数据...${bannerList.length}");
      setState(() {
        localNavList = model.localNavList;
        gridNav = model.gridNav;
        subNavList = model.subNavList;
        bannerList = model.bannerList;
        salesBox = model.salesBox;
        config = model.config;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  // TODO: implement wantKeepAlive 数据保存
  bool get wantKeepAlive => true;

  _jumpToSearch() {
//    CustomRoute(SearchPage());
    Navigator.of(context).push(CustomRoute(SearchPage(
      hideLeft: false,
      hint: SEARCH_BAR_DEFAULT_TEXT,
    )));
  }

  void _jumpToSpeak() {
    Navigator.of(context).push(CustomRoute(SpeakPage(navigator_type: NAVIGATOR_TYPE.home,)));
  }
}
