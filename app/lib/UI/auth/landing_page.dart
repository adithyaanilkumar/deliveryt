import 'package:flutter/material.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/Services/user_exists/model.dart';
import 'package:gardenfth/Services/user_exists/service.dart';
import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:gardenfth/UI/auth/details/auth_xtra_deets.dart';
import 'package:gardenfth/UI/auth/login/final_login.dart';
import 'package:gardenfth/UI/mainScreen/mainsc.dart';
import 'package:gardenfth/UI/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class landingPage extends StatefulWidget {
  @override
  _landingPageState createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  Future<String> newAddress;
  String a;
  @override
  void initState() {
    newAddress = ifUserfirstTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user != null || snapshot.hasData) {



              return HomePage();
//return checkFirstTime();
            }
            return test_old_signin(); //temp placeholder for homepage
          } else {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }

//  @override
//  void afterFirstLayout(BuildContext context) {
//    // Calling the same function "after layout" to resolve the issue.
//    checkFirstTime();
//  }

  Widget checkFirstTime() {
    return FutureBuilder(
      future: ifUserfirstTime(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          print("xtr adeets page");
          return xtraDeets();
          return HomePage();
//          return Container(
//            child: Center(
//              child: Spinner(context),
//            ),
//          );
        } else {
          return HomePage();
        }
      },
    );
  }
}
