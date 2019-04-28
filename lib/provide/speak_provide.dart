import 'package:flutter/material.dart';

class SpeakProvide with ChangeNotifier {
  String searchResult = '';
  TextEditingController controller = TextEditingController();

  setSearchResult(String result) {
    searchResult = result;
    controller.text = result;
    notifyListeners();
  }
}
