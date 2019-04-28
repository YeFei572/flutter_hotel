import 'package:flutter/material.dart';
import 'package:flutter_hotel/pages/tab_navigator.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    //开启动画
    _animation.addStatusListener((staus) => () {
          if (staus == AnimationStatus.completed) {
//            动画完成跳转
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => TabNavigatorPage()),
                (route) => route == null);
          }
        });
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Image.network(
            'https://jspang.com/static//myimg/blogtouxiang.jpg',
            fit: BoxFit.fill),
      ),
    );
  }
}
