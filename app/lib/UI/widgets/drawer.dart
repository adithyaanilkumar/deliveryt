import 'package:flutter/material.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gardenfth/UI/mainScreen/mainsc.dart';
import 'package:gardenfth/UI/cart/cart.dart';
import 'package:gardenfth/UI/profile/profile.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({@required this.auth});
  final AuthBase auth;

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
     Container(
      color: Colors.white,
      width: screenWidth/2,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.solidUserCircle,
                size: 70,
                color: Colors.red[100],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (context) => Profile()),
                );
              },
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {},
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red[100],
                    child: Icon(
                      Icons.call,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 15, fontFamily: 'SF-Pro'),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {},
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red[100],
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Earn Rewards',
                    style: TextStyle(fontSize: 15, fontFamily: 'SF-Pro'),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: _signOut,
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.red[100],
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(fontSize: 15, fontFamily: 'SF-Pro'),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            height: 10,
          ),
        ],
      ),
    );
  }
}
