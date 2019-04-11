import 'package:flutter/material.dart';
import 'package:flutter_hotel/model/common_model.dart';
import 'package:flutter_hotel/widget/web_view.dart';

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
    int separate = (subnavList.length / 2 + 0.5).toInt();
    subnavList.forEach((mode) {
      items.add(_item(context, mode));
    });

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.sublist(0, separate),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.sublist(separate, subnavList.length),
          ),
        )
      ],
    );
  }
}

Widget _item(BuildContext context, CommonModel model) {
  return Expanded(
    flex: 1,
      child: GestureDetector(
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
          width: 25,
          height: 25,
        ),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(
            model.title,
            style: TextStyle(fontSize: 12),
          ),
        )
      ],
    ),
  ));
}
