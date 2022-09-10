import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gardenfth/Services/profile/auth_deets_model.dart';
import 'package:gardenfth/Services/profile/auth_deets_service.dart';
import 'package:gardenfth/UI/mainScreen/mainsc.dart';
import 'package:gardenfth/Services/auth_deets_model.dart';
import 'package:gardenfth/UI/mainScreen/mainsc.dart';

class xtraDeets extends StatefulWidget {
  @override
  _xtraDeetsState createState() => _xtraDeetsState();
}

class _xtraDeetsState extends State<xtraDeets> {

  final TextEditingController _fnamecontroller = TextEditingController();
  String get _fname => _fnamecontroller.text;

  final TextEditingController _lnamecontroller = TextEditingController();
  String get _lname => _lnamecontroller.text;

  final TextEditingController _emailcontroller = TextEditingController();
  String get _email => _emailcontroller.text;

  final TextEditingController _phonecontroller = TextEditingController();
  String get _phone => _phonecontroller.text;
//  Future<Deets> _futureDeets;
  bool press = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EXTRA DEETS YO'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _fnamecontroller,
                decoration: InputDecoration(hintText: 'Enter First'),
              ),
              TextField(
                controller: _lnamecontroller,
                decoration: InputDecoration(hintText: 'Enter Last'),
              ),
              TextField(
                controller: _emailcontroller,
                decoration: InputDecoration(hintText: 'Enter Email'),
              ),
              TextField(
                controller: _phonecontroller,
                decoration: InputDecoration(hintText: 'Enter Phone'),
              ),
              press
                  ? FutureBuilder(
                  future: getDeets(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                            child: Text('Bruh Hold Up')
                        ),
                      );
                    } else {
                      return RaisedButton(
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(builder: (context) => HomePage()),
                          );
                        },
                        child: Text('${snapshot.data.username}'),
                      );
                    }
                  })
                  :RaisedButton(
                child: Text('Create Data'),
                onPressed: () {
                  setState(() {
                    press = true;
                  });
                  final authUp = AuthUp(
                      fname: _fname,
                      lname: _lname,
                      email: _email,
                      phone: _phone
                  );
                  updateDeets(authUp);
                },
              )
            ],
          )
        ),
    );
  }
}
