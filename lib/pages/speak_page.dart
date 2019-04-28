import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hotel/pages/search_page.dart';
import 'package:flutter_hotel/plugin/as_manager.dart';
import 'package:flutter_hotel/widget/custom_route_widget.dart';
import 'package:provide/provide.dart';
import 'package:flutter_hotel/provide/speak_provide.dart';

enum NAVIGATOR_TYPE { home, search }

class SpeakPage extends StatefulWidget {
  final NAVIGATOR_TYPE navigator_type;

  SpeakPage({Key key, this.navigator_type = NAVIGATOR_TYPE.home})
      : super(key: key);

  @override
  _SpeakPageState createState() => _SpeakPageState();
}

class _SpeakPageState extends State<SpeakPage>
    with SingleTickerProviderStateMixin {
  String speakTips = "长按说话";
  String speakResult = '';
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        print('动画状态 $status');
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[_topItem(), _bottomItem()],
      ),
    ));
  }

  ///开启动画
  _speakStart() {
    print('_speakStart 开启动画 ');
    controller.forward();
    setState(() {
      speakTips = '- 识别中 - ';
    });
    AsrManager.start().then((text) {
      if (text != null && text.length > 0) {
        setState(() {
          speakResult = text;
        });

        Provide.value<SpeakProvide>(context).setSearchResult(speakResult);

        ///先关闭当前页面，再进行跳转
        if (widget.navigator_type == NAVIGATOR_TYPE.home) {
          Navigator.pop(context);
          Navigator.of(context)
              .push(CustomRoute(SearchPage(keyWord: speakResult,)));
        } else {
          Navigator.pop(context,speakResult);
        }
      }
    }).catchError((e) {
      print('-----语言识别 error-----' + e.toString());
    });
  }

  _speakStop() {
    setState(() {
      speakTips = '长按说话';
    });

    ///恢复原位
    controller.reset();
    controller.stop();
    AsrManager.stop();
  }

  ///顶部案例提示
  _topItem() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Text(
              '你可以这样说',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            )),
        Text(
          '故宫门票\n北京一日游\n迪士尼乐园',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            speakResult,
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

  ///底部说话按钮
  _bottomItem() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTapDown: (e) {
              _speakStart();
            },
            onTapUp: (e) {
              _speakStop();
            },

            ///长按滑出按钮
            onTapCancel: () {
              _speakStop();
            },
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      speakTips,
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        ///占坑，避免动画执行过程中导致父布局变大
                        height: MIC_SIZE,
                        width: MIC_SIZE,
                      ),
                      Center(
                        child: AnimatedMic(
                          animation: animation,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 30,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.grey,
                ),
              ))
        ],
      ),
    );
  }
}

const double MIC_SIZE = 80;

class AnimatedMic extends AnimatedWidget {
  ///透明度补间动画
  ///缩放补间动画
  static final _opacityTween = Tween<double>(begin: 1, end: 0.5);
  static final _sizeTween = Tween<double>(begin: MIC_SIZE, end: MIC_SIZE - 20);

  AnimatedMic({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        height: _sizeTween.evaluate(animation),
        width: _sizeTween.evaluate(animation),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(MIC_SIZE / 2)),
        child: Icon(
          Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
