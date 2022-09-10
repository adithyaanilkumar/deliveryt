import 'package:flutter/material.dart';
import 'dart:async';
import 'onB.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/UI/auth/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new landingPage()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnBoarding()));
    }
  }

  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Card(
            elevation: 10,
            color: Colors.redAccent[200],
            child: Center(child: Text('GARDEN', style: TextStyle(fontFamily: 'SF-Pro',color: Colors.white,fontSize: 28,letterSpacing: 2, fontWeight: FontWeight.w700),)),
          ),
        ),
      ),
    );
  }
}
