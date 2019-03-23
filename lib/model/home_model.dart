import 'package:flutter_xiecheng/model/common_model.dart';
import 'package:flutter_xiecheng/model/config_model.dart';
import 'package:flutter_xiecheng/model/sales_box_model.dart';
import 'grid_nav_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel(
      {this.bannerList,
      this.localNavList,
      this.subNavList,
      this.gridNav,
      this.salesBox,
      this.config});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((i) {
      return CommonModel.fromJson(i);
    }).toList();
    var localNavlistJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavlistJson.map((i) => CommonModel.fromJson(i)).toList();
    var subNavlistJson = json['subNavList'] as List;
    List<CommonModel> subNavList = subNavlistJson.map((i) {
      return CommonModel.fromJson(i);
    }).toList();
    return HomeModel(
      bannerList: bannerList,
      localNavList: localNavList,
      subNavList: subNavList,
      config: ConfigModel.fromJson(json['config']),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }
}
