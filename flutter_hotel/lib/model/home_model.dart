
import 'common_model.dart';
import 'config_model.dart';
import 'grid_nav_model.dart';
import 'sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel>  bannerList;
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
    var localNavlistJson = json['localNavList'] as List;
    List<CommonModel> localNavList = localNavlistJson.map((i) => CommonModel.fromJson(i)).toList();

    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList = bannerListJson.map((i) {
      return CommonModel.fromJson(i);
    }).toList();

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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) {
      data['config'] = this.config.toJson();
    }
    if (this.gridNav != null) {
      data['gridNav'] = this.gridNav.toJson();
    }
    if (this.salesBox != null) {
      data['salesBox'] = this.salesBox.toJson();
    }
    if (this.subNavList != null) {
      data['subNavList'] = this.subNavList.map((v) => v.toJson()).toList();
    }
    if (this.gridNav != null) {
      data['bannerList'] = this.bannerList.map((v)=>v.toJson()).toList();
    }
    if (this.gridNav != null) {
      data['localNavList'] = this.localNavList.map((v)=>v.toJson()).toList();
    }
    return data;
  }
}
