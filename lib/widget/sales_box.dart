import 'package:flutter/material.dart';
import 'package:flutter_hotel/model/common_model.dart';
import 'package:flutter_hotel/model/sales_box_model.dart';
import 'package:flutter_hotel/widget/webview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///活动卡片
class SalesBox extends StatelessWidget {
  SalesBoxModel salesBox;

  SalesBox({@required this.salesBox});

  @override
  Widget build(BuildContext context) {
    if (salesBox == null) return null;
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: <Widget>[
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xfff2f2f2), width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.network(
                  salesBox.icon,
                  fit: BoxFit.fill,
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WebView(
                                  url: salesBox.moreUrl,
                                  title: "更多活动",
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
                    margin: EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(colors: [
                          Color(0xffff4e63),
                          Color(0xffff6cc9),
                        ])),
                    child: Text(
                      '获取更多福利>',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          _items(context, salesBox.bigCard1, salesBox.bigCard2, true),
          _items(context, salesBox.smallCard1, salesBox.smallCard2, false),
          _items(context, salesBox.smallCard3, salesBox.smallCard4, false),
        ],
      ),
    );
  }

  _items(
      BuildContext context, CommonModel model, CommonModel model2, bool isBig) {
    return Row(
      children: <Widget>[
        Expanded(
            child: GestureDetector(
          onTap: () {
            _worp(context, model);
          },
          child: Container(
            margin: EdgeInsets.only(right: 1),
            child: Image.network(
              model.icon,
              height: isBig ? 129 : 80,
            ),
          ),
        )),
        Expanded(
            child: GestureDetector(
                onTap: () {
                  _worp(context, model);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                    color: Color(0xfff2f2f2),
                    width: 1,
                  ))),
                  child: Image.network(
                    model2.icon,
                    height: isBig ? 129 : 80,
                  ),
                )))
      ],
    );
  }

  //点击跳转
  _worp(BuildContext context, CommonModel model) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebView(
                  title: '热门活动',
                  url: model.url,
                  statusBarColor: model.statusBarColor,
                  hideAppBar: model.hideAppBar,
                )));
  }
}
