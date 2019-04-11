//首页网格卡片模式


import 'common_model.dart';

class GridNavModel {
//  GridNavItem hotel	Object	NonNull
//  GridNavItem flight	Object	NonNull
//  GridNavItem travel	Object	NonNul
  final GridNavItem hotel;
  final GridNavItem flight;
  final GridNavItem travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return json != null
        ? GridNavModel(
            hotel: GridNavItem.fromJson(json['hotel']),
            flight: GridNavItem.fromJson(json['flight']),
            travel: GridNavItem.fromJson(json['travel']),
          )
        : null;
  }
  Map<String, dynamic> toJson(){
    final Map<String,dynamic> data = Map<String,dynamic>();
    if(this.hotel!=null){
      data['hotel'] = this.hotel;
    }

    if(this.flight!=null){
      data['flight'] = this.flight;
    }

    if(this.travel!=null){
      data['travel'] = this.travel;
    }

    return data;
  }

}

class GridNavItem {
//  String startColor	String	NonNull
//  String endColor	String	NonNull
//  CommonModel mainItem	Object	NonNull
//  CommonModel item1	Object	NonNull
//  CommonModel item2	Object	NonNull
//  CommonModel item3	Object	NonNull
//  CommonModel item4	Object	NonNull

  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridNavItem(
      {this.startColor,
      this.endColor,
      this.mainItem,
      this.item1,
      this.item2,
      this.item3,
      this.item4});

  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    return GridNavItem(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;

    if (this.mainItem!= null) {
      data["mainItem"] = this.mainItem.toJson();
    }

    if (this.item1!= null) {
      data['item1'] = this.item1.toJson();
    }
    if (this.item2!= null) {
      data['item1'] = this.item2.toJson();
    }
    if (this.item3 != null) {
      data['item1'] = this.item3.toJson();
    }
    if (this.item4 != null) {
      data['item1'] = this.item4.toJson();
    }
    return data;
  }
}
