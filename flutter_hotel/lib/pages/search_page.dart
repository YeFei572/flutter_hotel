import 'package:flutter/material.dart';
import 'package:flutter_hotel/pages/home_page.dart';
import 'package:flutter_hotel/pages/speak_page.dart';
import 'package:flutter_hotel/widget/custom_route_widget.dart';
import 'package:flutter_hotel/widget/search_bar.dart';
import 'package:flutter_hotel/model/search_model.dart';
import 'package:flutter_hotel/dao/search_dao.dart';
import 'package:flutter_hotel/widget/webview.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];
const URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
   String keyWord;
  final String hint;

  SearchPage(
      {this.hideLeft = true,
      this.searchUrl = URL,
      this.keyWord,
      this.hint = SEARCH_BAR_DEFAULT_TEXT});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;
  ///路由语音返回值
  String resultText;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.keyWord != null) {
      _onTextChange(widget.keyWord);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                  flex: 1,
                  child: ListView.builder(
                      itemCount: searchModel?.data?.length,
                      itemBuilder: (context, index) {
                        return _item(index);
                      })))
        ],
      ),
    );
  }

  //TODO 请求搜索内容
  _onTextChange(String text) {
    keyword = text;
    if (text.trim().length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    print('====text==== $text');
    String url = widget.searchUrl + text;
    SearchDao.fetch(url, text).then((SearchModel model) {
      ///只有当当前输入的内容和服务端返回的内容一致时才渲染
      if (model.keyword == text) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      print(' search_page == error:   $e');
    });
  }

  _appBar() {
    print(' _appbar ======  ${widget.keyWord}');
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Container(
        padding: EdgeInsets.only(top: 20),
        height: 80,
        decoration: BoxDecoration(color: Colors.white),
        child: SearchBar(
          hideLeft: widget.hideLeft,
          defaultText: widget.keyWord,
          speakClick: _jumpToSpeak,
          hint: widget.hint,
          leftButtonClick: () {
            Navigator.pop(context);
          },
          onChanged: _onTextChange,
          resultText: resultText,
        ),
      ),
    );
  }

  _jumpToSpeak() async {
    String result = await Navigator.of(context).push(CustomRoute(SpeakPage(
      navigator_type: NAVIGATOR_TYPE.search,
    ))) as String;

    print('_jumpToSpeak $result');

    setState(() {
      resultText = result ?? '';
    });

    _onTextChange(result ?? '');
  }

  Widget _item(int position) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem item = searchModel.data[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: item.url,
                      title: '详情',
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(2),
              child: Image(
                  height: 26,
                  width: 26,
                  image: AssetImage(_typeImage(item.type))),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 300,
                  child: _title(item),
                ),
                Container(width: 300, child: _subTitle(item)),
              ],
            )
          ],
        ),
      ),
    );
  }

  ///匹配图标
  String _typeImage(String type) {
    if (type == null) return 'images/type_channelgroup.png';
    var path = 'type_channelgroup';
    for (var value in TYPES) {
      if (type.contains(value)) {
        path = value;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  ///第一行文字展示
  _title(SearchItem item) {
    if (item == null) {
      return null;
    }
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel.keyword));
    spans.add(TextSpan(
        text: '  ' + item.districtname ?? '' + '  ' + item.zonename ?? '',
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(text: TextSpan(children: spans));
  }

  ///第二行文字展示
  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: (item.price ?? ''),
              style: TextStyle(color: Colors.orange, fontSize: 16)),
          TextSpan(
              text: '  ' + (item.star ?? ''),
              style: TextStyle(color: Colors.grey, fontSize: 12))
        ],
      ),
    );
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.length == 0) return spans;
    List<String> arr = word.split(keyword);
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    for (int i = 0; i < arr.length; i++) {
      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      String val = arr[i];
      if (val != null && val.length > 0) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
