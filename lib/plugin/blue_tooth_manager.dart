import 'package:flutter/services.dart';

class BlueToothManager {
  static const MethodChannel _channel =
      const MethodChannel('samples.flutter.io/bluetooth');

  ///打开蓝牙
  static Future<String> openBlueTooth() async {
    return await _channel.invokeMethod('openBuleTooth');
  }

  ///检测蓝牙状态
  static Future<String> getBlueTooth() async {
    return await _channel.invokeMethod('getBuleTooth');
  }
}
