import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gardenfth/UI/mainScreen/mainsc.dart';
import 'package:gardenfth/UI/profile/profile.dart';
import 'cart.dart';

class CartDrawer extends StatefulWidget {
  @override
  _CartDrawerState createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery. of(context). size. width;
    double screenheight = MediaQuery. of(context). size. height;
    return Container(
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
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (context) => HomePage()),
                );
              },
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 15,backgroundColor: Colors.red[100],child: Icon(Icons.home,color: Colors.redAccent,),),
                  SizedBox(width: 10,),
                  Text('Home',style: TextStyle(fontSize: 15,fontFamily: 'SF-Pro'),)
                ],
              ),
            ),
          ),
          Divider(thickness: 0.5,height: 10,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (context) => cart()),
                );
              },
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 15,backgroundColor: Colors.red[100],child: Icon(Icons.local_grocery_store,color: Colors.redAccent,),),
                  SizedBox(width: 10,),
                  Text('My Cart',style: TextStyle(fontSize: 15,fontFamily: 'SF-Pro'),)
                ],
              ),
            ),
          ),
          Divider(thickness: 0.5,height: 10,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: (){},
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 15,backgroundColor: Colors.red[100],child: Icon(Icons.call,color: Colors.redAccent,),),
                  SizedBox(width: 10,),
                  Text('Contact Us',style: TextStyle(fontSize: 15,fontFamily: 'SF-Pro'),)
                ],
              ),
            ),
          ),
          Divider(thickness: 0.5,height: 10,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: (){},
              child: Row(
                children: <Widget>[
                  CircleAvatar(radius: 15,backgroundColor: Colors.red[100],child: Icon(Icons.attach_money,color: Colors.redAccent,),),
                  SizedBox(width: 10,),
                  Text('Earn Rewards',style: TextStyle(fontSize: 15,fontFamily: 'SF-Pro'),)
                ],
              ),
            ),
          ),
          Divider(thickness: 0.5,height: 10,),

        ],
      ),
    );
  }
}
