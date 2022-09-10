import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

Widget Spinner(BuildContext context){
  return SpinKitRing(
    lineWidth: 4,
    color: Colors.blueGrey,
    size: 50.0,
  );
}