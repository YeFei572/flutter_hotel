import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_hotel/model/search_model.dart';
//import 'package:http/http.dart'; //包名重复用as 进行改名

//首页大接口
class SearchDao {
  static Future<SearchModel> fetch(String url, String text) async {
    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      //彩蛋 ，解决解析中文乱码
//      Utf8Decoder utf8decoder = Utf8Decoder();
//      var result = json.decode(utf8decoder.convert(response.data));

      SearchModel model = SearchModel.fromJson(response.data);
      model.keyword = text;
      return model;
    } else {
      throw Exception('Failed to load home_page.json');
    }
  }
}
