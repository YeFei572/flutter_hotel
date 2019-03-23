import 'dart:async';
import 'dart:convert';
import 'package:flutter_hotel/model/home_model.dart';
import 'package:dio/dio.dart';
//import 'package:http/http.dart'; //包名重复用as 进行改名

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

//首页大接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    final response = await Dio().get(HOME_URL);
    if (response.statusCode == 200) {
      //彩蛋 ，解决解析中文乱码
//      Utf8Decoder utf8decoder = Utf8Decoder();
//      var result = json.decode(utf8decoder.convert(response.data));
      return HomeModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
