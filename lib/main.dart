import 'package:flutter/material.dart';
import 'package:flutter_hotel/pages/home_page.dart';
import 'package:flutter_hotel/pages/splash_page.dart';
import 'package:flutter_hotel/pages/tab_navigator.dart';
import 'package:flutter_hotel/provide/speak_provide.dart';
import 'package:provide/provide.dart';

//void main() => runApp(MyApp());
void main() {
  var speak = SpeakProvide();
  var providers = Providers();
  providers..provide(Provider<SpeakProvide>.value(speak));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pinkAccent,
          platform: TargetPlatform.iOS,
        ),
        home: TabNavigatorPage(),
//      home: SplashPage(),
      ),
    );
  }
}
