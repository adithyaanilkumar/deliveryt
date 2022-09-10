import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/UI/auth/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'cart.dart';
import 'package:gardenfth/Services/Auth.dart';

class Blank extends StatefulWidget {

  @override
  _BlankState createState() => _BlankState();
}

class _BlankState extends State<Blank> {
  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 1), () {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => cart()));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(

          
        ),
      ),
    );
  }
}
