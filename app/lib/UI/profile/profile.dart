import 'package:flutter/material.dart';
import 'package:gardenfth/Constants/authConst.dart';
import 'package:gardenfth/Services/profile/network_profiles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gardenfth/UI/profile/about_apps.dart';
import 'package:gardenfth/UI/profile/call_centerr.dart';
import 'package:gardenfth/UI/profile/orders.dart';
import 'package:gardenfth/UI/widgets/loader.dart';
import 'address.dart';
import 'settings.dart';
import 'package:gardenfth/UI/widgets/loader.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    ProfileCacheManager cacheManager = ProfileCacheManager();
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;

    Widget createProfileListview(BuildContext context, AsyncSnapshot snapshot) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top:screenheight/30),
                child: Text('${snapshot.data.first_name} ${snapshot.data.last_name}',style: TextStyle(fontFamily: 'SF-PRO',fontWeight: FontWeight.bold,fontSize: screenheight/28),),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top:screenheight/60, bottom: screenheight/20),
                child: Text('${snapshot.data.email}',style: TextStyle(fontSize: 15,fontFamily: 'SF-Pro',color: Colors.grey[500]),),
              ),
            ),
            list_block(screenheight, "Address", Icons.location_on, Address()),
            Divider(thickness: 0.5,),
            list_block(screenheight, "My Orders", FontAwesomeIcons.truck,
                MyOrders()),
            Divider(thickness: 0.5,),
            list_block(screenheight, "Settings", Icons.settings, Account()),
            Divider(thickness: 0.5,),
            list_block(screenheight, "Call Center", FontAwesomeIcons.phoneAlt,
                callCenter()),
            Divider(thickness: 0.5,),
            list_block(screenheight, "About Apps", FontAwesomeIcons.staylinked,
                aboutApps()),
          ],
        ),
      );
    }


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text('Profile'),
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: cacheManager.getProfiles(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                      child: Spinner(context)
                  ),
                );
              } else {
                return createProfileListview(context, snapshot);
              }
            })
    );
  }
}

class list_block extends StatelessWidget {
  list_block(this.screenheight, this.title, this.icon, this.route);

  final double screenheight;
  final String title;

  final IconData icon;
  final Widget route;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        highlightColor: Colors.white,
        splashColor: Colors.white,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (context) => route),
          );
        },
        child: Padding(
            padding: EdgeInsets.only(
                top: screenheight / 100, bottom: screenheight / 100),
            child: Row(
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.grey[400],
                  size: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '$title',
                    style: TextStyle(
                        fontFamily: 'SF-Pro',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3),
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.navigate_next,
                  color: Colors.grey[400],
                  size: 30,
                )
              ],
            )),
      ),
    );
  }
}
