import 'package:flutter/material.dart';
import 'package:flutter_hotel/model/common_model.dart';
import 'package:flutter_hotel/widget/webview.dart';

class SubNav extends StatelessWidget {
  final List<CommonModel> subnavList;

  const SubNav({Key key, @required this.subnavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          //设置圆角
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  Widget _items(BuildContext context) {
    if (subnavList == null) return null;
    List<Widget> items = [];
    subnavList.forEach((model) {
      items.add(_item(context, model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items,
    );
  }
}

Widget _item(BuildContext context, CommonModel model) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebView(
                    url: model.url,
                    statusBarColor: model.statusBarColor,
                    hideAppBar: model.hideAppBar,
                  )));
    },
    child: Column(
      children: <Widget>[
        Image.network(
          model.icon,
          width: 18,
          height: 18,
        ),
        Text(
          model.title,
          style: TextStyle(fontSize: 12),
        )
      ],
    ),
  );
}
