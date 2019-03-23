import 'package:flutter/material.dart';
import 'package:flutter_hotel/model/common_model.dart';
import 'package:flutter_hotel/model/grid_nav_model.dart';
import 'package:flutter_hotel/widget/webview.dart';
import 'dart:convert';

class GridNav extends StatelessWidget {
  GridNavModel gridNav;

  GridNav({this.gridNav});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  //总的3个大块的布局
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNav == null) return items;
    if (gridNav.flight != null) {
      items.add(_gridNavItem(context, gridNav.flight, true));
    }
    if (gridNav.hotel != null) {
      items.add(_gridNavItem(context, gridNav.hotel, false));
    }
    if (gridNav.travel != null) {
      items.add(_gridNavItem(context, gridNav.travel, false));
    }
    return items;
  }

  //一个小块的子布局
  _gridNavItem(BuildContext context, GridNavItem gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));
    List<Widget> expandItems = [];
    items.forEach((item) {
      expandItems.add(Expanded(child: item, flex: 1));
    });
    Color startColor = Color(int.parse('0xff' + gridNavItem.startColor));
    Color endColor = Color(int.parse('0xff' + gridNavItem.endColor));
    return Container(
      height: 78,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(children: expandItems),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGestrue(
        context,
        Stack(
          children: <Widget>[
            Image.network(
              model.icon,
              fit: BoxFit.contain,
              width: 88,
              height: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              alignment: AlignmentDirectional.topCenter,
              child: Text(
                model.title,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            )
          ],
        ),
        model);
  }

  _doubleItem(
      BuildContext context, CommonModel topModel, CommonModel bottomMode) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: _item(context, topModel, true),
          ),
          Expanded(
            child: _item(context, bottomMode, false),
          )
        ],
      ),
    );
  }

  //单个右边小的item
  _item(BuildContext context, CommonModel model, bool isFirst) {
    BorderSide borderSide = BorderSide(color: Colors.white, width: 0.8);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        child: _wrapGestrue(
            context,
            Center(
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            model),
        decoration: BoxDecoration(
            border: Border(
                left: borderSide,
                bottom: isFirst ? borderSide : BorderSide.none)),
      ),
    );
  }

  //跳转webview
  _wrapGestrue(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: model.url,
                      statusBarColor: model.statusBarColor,
                      title: model.title,
                      hideAppBar: model.hideAppBar,
                    )));
      },
      child: widget,
    );
  }
}
