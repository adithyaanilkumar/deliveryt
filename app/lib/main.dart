import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/Services/auth_provider.dart';
import 'package:gardenfth/UI/auth/landing_page.dart';
import 'package:gardenfth/UI/auth/main_signin_page.dart';
import 'package:gardenfth/UI/onBoarding/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Provider<AuthBase>(
    create: (context) => Auth(),
//    auth: Auth(),
    child: MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red,
        accentColor: Colors.white,
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) => Splash(),
      },
    ),
  ));
//  FlutterImageCompress.showNativeLog = true;
}