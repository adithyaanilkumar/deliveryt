import 'package:flutter/material.dart';

class title_common extends StatelessWidget {


  title_common(this.title);
  final String title;


  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'SF-Pro',
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      padding: EdgeInsets.only(top: 20, left: 17),
    );
  }
}