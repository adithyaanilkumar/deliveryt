import 'package:flutter/material.dart';
import 'package:gardenfth/UI/cart/cart.dart';
import 'package:gardenfth/UI/mainScreen/search.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:badges/badges.dart';
import 'package:gardenfth/Services/cart/getCart.dart';
import '../../Services/cart/getCart.dart';
import 'package:gardenfth/Services/profile/address/get_address.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key key,this.iconButton}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);


  @override
  final Size preferredSize; // default is 56.0
  final IconButton iconButton;
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{
  final List<String> _dropdownValues = [
    "682021",
    "682022",
    "682023",
    "682024",
    "682025"
  ]; //The list of values we want on the dropdown
  String _currentlySelected = "Kannur"; //var to hold currently selected value

  Widget dropdownWidget() {
    return DropdownButton(
      items: _dropdownValues
          .map((value) => DropdownMenuItem(
        child: Text(value),
        value: value,
      ))
          .toList(),
      onChanged: (String value) {
        setState(() {
          _currentlySelected = value;
        });
      },
      isExpanded: false,
      value: _dropdownValues.first,
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => cart(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }


  String dropdownValue = 'Kannur 1';
  @override
  Widget build(BuildContext context) {
    AdresscacheManager adresscacheManager = AdresscacheManager();
    double screenWidth = MediaQuery.of(context).size.width;
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          Padding(
            padding:  EdgeInsets.only(right:MediaQuery.of(context).size.width * 0.4,top: 4),
            child:  Container(
              child: Center(
                child: FutureBuilder(
                    future: adresscacheManager.getProfiles(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Text('Pin code');
                      } else {
                        return Text('${snapshot.data.pin_code}',style: TextStyle(color: Colors.grey[600]),);
                      }
                    }),
              ),
            ),
          ),
          widget.iconButton,
          IconButton(
            icon:  FutureBuilder(
                    future: fetchItemsNumber(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Icon(Icons.add_shopping_cart);
                      } else {
                        return Badge(
                          badgeContent: Text('${snapshot.data}',style: TextStyle(color: Colors.white),),
                          child: Icon(Icons.add_shopping_cart),
                        );
                      }
                    }),
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
          ),
        ],
    );
  }
}

