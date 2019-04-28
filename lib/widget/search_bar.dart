import 'package:flutter/material.dart';
import 'package:flutter_hotel/provide/speak_provide.dart';
import 'package:provide/provide.dart';

/*
 * home 首页上面
 * normal 首页默认搜索appbar
 * homeLight 首页滚动显示高光搜索appbar
 */
enum SearchBarType { home, normal, homeLight }

class SearchBar extends StatefulWidget {
  ///是否禁止搜索
  final bool enabled;

  ///左边是否隐藏
  final bool hideLeft;

  ///3种枚举状态下的搜索栏，
  final SearchBarType searchBarType;

  ///默认提示文案
  final String hint;

  ///首页默认文字
  final String defaultText;

  ///左边按钮点击回调
  final void Function() leftButtonClick;

  ///右边按钮点击回调
  final void Function() rightButtonClick;

  ///语言回调
  final void Function() speakClick;

  ///输入框的点击回调
  final void Function() inputBoxClick;

  ///内容变化的回调
  final ValueChanged<String> onChanged;

  SearchBar(
      {Key key,
      this.enabled = true,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftButtonClick,
      this.rightButtonClick,
      this.speakClick,
      this.inputBoxClick,
      this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;

//  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    print('search_bar  initState ${widget.defaultText}');
//    if (widget.defaultText != null) {
//      _controller.text = widget.defaultText;
//    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  ///搜索界面展示
  _genNormalSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
                child: widget?.hideLeft ?? false
                    ? null
                    : Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey,
                        size: 26,
                      ),
              ),
              widget.leftButtonClick),
          Expanded(
            flex: 1,
            child: _inputBox(),
          ),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  '搜索',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                ),
              ),
              widget.rightButtonClick)
        ],
      ),
    );
  }

  ///首页搜索展示
  _genHomeSearch() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
            child: Row(
              children: <Widget>[
                Text(
                  '上海',
                  style: TextStyle(fontSize: 14, color: _homeFontColor()),
                ),
                _wrapTap(
                    Container(
                      child: Icon(
                        Icons.expand_more,
                        color: _homeFontColor(),
                        size: 22,
                      ),
                    ),
                    widget.leftButtonClick),
              ],
            ),
          ),
          Expanded(
            child: _inputBox(),
            flex: 1,
          ),
          _wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Icon(
                  Icons.comment,
                  color: _homeFontColor(),
                  size: 26,
                ),
              ),
              widget.rightButtonClick)
        ],
      ),
    );
  }

  _homeFontColor() {
    ///首页输入框高亮时是灰色，置顶时是白色
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }

  ///搜索 输入栏
  Widget _inputBox() {
    print('_inputBox');
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = Color(int.parse('0xffEDEDED'));
    }

    return Provide<SpeakProvide>(builder: (context, child, speakProvide) {
      return Container(
        height: 30,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
            color: inputBoxColor,
            borderRadius: BorderRadius.circular(
                widget.searchBarType == SearchBarType.normal ? 5 : 15)),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              size: 20,
              color: widget.searchBarType == SearchBarType.normal
                  ? Color(int.parse('0xffA9A9A9'))
                  : Colors.blue,
            ),
            Expanded(
                flex: 1,
                child: widget.searchBarType == SearchBarType.normal
                    ? TextField(
                        controller: speakProvide.controller,
                        onChanged: _onChanged,
                        autofocus: true,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),

                        ///输入文本的样式
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          border: InputBorder.none,
                          hintText: widget.hint ?? '',
                          hintStyle: TextStyle(fontSize: 15),
                        ),
                      )
                    : _wrapTap(
                        Container(
                          child: Text(
                            widget.defaultText,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        widget.inputBoxClick)),
            !showClear
                ? _wrapTap(
                    Icon(Icons.mic,
                        size: 22,
                        color: widget.searchBarType == SearchBarType.normal
                            ? Colors.blue
                            : Colors.grey),
                    widget.speakClick)
                : _wrapTap(
                    Icon(
                      Icons.clear,
                      size: 22,
                      color: Colors.grey,
                    ), () {
                    setState(() {
                      speakProvide.controller.clear();
                    });
                    _onChanged('');
                  })
          ],
        ),
      );
    });
  }

  ///设置按钮封装
  Widget _wrapTap(Widget child, void Function() callBack) {
    return GestureDetector(
      onTap: () {
        if (callBack != null) callBack();
      },
      child: child,
    );
  }

  _onChanged(String text) {
    print('search_bar  _onChanged $text');
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }
}
