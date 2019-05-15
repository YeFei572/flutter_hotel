import 'package:flutter/material.dart';
import 'package:flutter_hotel/plugin/blue_tooth_manager.dart';

//蓝牙模块
class BlueToothPage extends StatefulWidget {
  @override
  _BlueToothPageState createState() => _BlueToothPageState();
}

class _BlueToothPageState extends State<BlueToothPage> {
  String _message = '未开启';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('blueTooth'),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('蓝牙状态:'),
                    Text(
                      _message,
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text('打开蓝牙'),
                            onPressed: () {
                              _openBlueTooth();
                            }),
                        RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text('检测蓝牙状态'),
                            onPressed: () {
                              _getBlueTooth();
                            }),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _openBlueTooth() {
    BlueToothManager.openBlueTooth().then((onValue) {
      setState(() {
        _message = onValue;
      });
    });
  }

  void _getBlueTooth() {
    BlueToothManager.getBlueTooth().then((onValue) {
      setState(() {
        _message = onValue;
      });
    });
  }
}
