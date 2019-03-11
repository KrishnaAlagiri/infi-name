import 'dart:async';
import 'package:flutter/material.dart';
import 'landingscreen.dart';

void main() =>
    runApp(new MaterialApp(
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/MyApp': (BuildContext context) => new MyApp()
      },
    ));

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/MyApp');
  }
  @override
  void initState() {
    super.initState();
    startTime();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
