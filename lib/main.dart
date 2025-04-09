import 'package:flutter/material.dart';
import 'package:weather_app1/pages/weatherpage.dart';
import 'package:get/get.dart';

class myclass {
  late int _n;
  String _s;

  myclass(this._n, this._s);

  myclass.named(this._s) {
    int _n = 99;
  }

  void prnt() {
    print('$_n $_s');
  }
}

void main() {
  //myclass cls = myclass.named('5');
  //cls.prnt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherHome(),
    );
  }
}
