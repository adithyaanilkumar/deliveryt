import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/Services/user_exists/service.dart';
import 'package:gardenfth/UI/auth/details/auth_xtra_deets.dart';
import 'package:gardenfth/UI/cart/cart.dart';
import 'package:gardenfth/UI/mainScreen/categories_helper.dart';
import 'package:gardenfth/UI/mainScreen/popular_helper.dart';
import 'package:gardenfth/UI/mainScreen/sales_helper.dart';
import 'package:provider/provider.dart';
import '../cart/cart.dart';
import 'package:gardenfth/UI/profile/profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'search.dart';
import 'modules.dart';
import 'carousal.dart';
import 'package:gardenfth/UI/widgets/appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
    @override
    _MyTabbedPageState createState() => _MyTabbedPageState();
  }

class _MyTabbedPageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isWaiting = false;
  Map<String, String> coinValues = {};



  void getData() async {
    isWaiting = true;
    try {
      var data = await getData();
      isWaiting = false;
    } catch (e) {
      print(e);
    }
  }
  Future<String> newAddress;
  @override
  void initState() {
    super.initState();
    getData();
    newAddress = ifUserfirstTime();
  }

  Future<void> _signOut() async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> checkNewUser() async
  {
    return FutureBuilder(
        future: newAddress,

        builder: (BuildContext context, AsyncSnapshot snapshot) {
//                    try {
//                      a = snapshot.data[0];
//                      print("${snapshot.data} is in the try block");
//                      return HomePage();
//                    } catch (e) {
//                      print("jumping to here");
//                    return xtraDeets();
////                      return HomePage();
//                    }
//                  if (snapshot.connectionState == ConnectionState.waiting)
//                    return Center(
//                      child: CircularProgressIndicator(),
//                    );
//                  else if (snapshot.hasError) {
//                    return Center(
//                      child: Text("ERROR: ${snapshot.error}"),
//                    );
//                  } else {
//                    if (snapshot.data.isNotEmpty)
//                      return HomePage();
//                    else //`snapShot.hasData` can be false if the `snapshot.data` is null
//                      return xtraDeets();
////                      return Center(
////                        child: Text("No Data Found"),
////                      );
//                  }
//                },

          if (snapshot.data == null) {
            print("${snapshot.data} is going to be in xtra details page");
            print("xtra deets page");
            return xtraDeets();
//                    return HomePage();
//          return Container(
//            child: Center(
//              child: Spinner(context),
//            ),
//          );
          } else {
            print("${snapshot.data} is going to be in HOME page");
            return HomePage();
            if(snapshot.data[0].email != null){print("HOMEPAGE ${snapshot.data} is null here");
            return HomePage();}else return Text("try again");

          }
        } );
  }

  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    setState(() {
      build(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 2076, allowFontScaling: true);
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double size = mediaQueryData.size.height;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        iconButton: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (context) => Search()),
            );
          },
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ),
      drawer: Drawer(context),
      body: SmartRefresher(
        enablePullDown: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
          child: ListView(
            children: <Widget>[
              Carousal(),
              Popular_items(),
              Categories_on_screen(),
              Sales_main_screen(),
            ],
          ),
      ),
    );
  }

  //drawer
  Widget Drawer(BuildContext buildContext) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
        ),
        width: screenWidth / 1.5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (context) => Profile()),
                );
              },
              child: Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(7)),
                  color: Colors.redAccent,
                ),
                height: 57,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Pablo',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            drawer_list(context, Icons.home, "Home", HomePage()),
            Divider(
              thickness: 1,
              height: 10,
            ),
            drawer_list(context, Icons.shopping_cart, "My Cart", cart()),
            Divider(
              thickness: 1,
              height: 10,
            ),
            drawer_list(context, Icons.call, "Contact Us", () {}),
            Divider(
              thickness: 1,
              height: 10,
            ),
            drawer_list(
                context, FontAwesomeIcons.dollarSign, "Earn Rewards", () {}),
            Divider(
              thickness: 1,
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 15, top: 8, bottom: 8),
              child: GestureDetector(
                onTap: _signOut,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.red[100],
                      child: Center(
                        child: Icon(
                          Icons.exit_to_app,
                          size: 20,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Text(
                      "Logout",
                      style: TextStyle(fontSize: 15, fontFamily: 'SF-Pro'),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class drawer_list extends StatelessWidget {
  drawer_list(this.context, this.icona, this.header, this._route);

  final BuildContext context;
  final IconData icona;
  final String header;
  var _route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 15, top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => _route,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ));
        },
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.red[100],
              child: Center(
                child: Icon(
                  icona,
                  size: 20,
                  color: Colors.redAccent,
                ),
              ),
            ),
            SizedBox(
              width: 13,
            ),
            Text(
              header,
              style: TextStyle(fontSize: 15, fontFamily: 'SF-Pro'),
            )
          ],
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//class HomePage extends StatefulWidget {
//  @override
//  _HomePageState createState() => _HomePageState();
//}
//
//class _HomePageState extends State<HomePage> {
//
//  @override
//  Widget build(BuildContext context) {
//    ScreenUtil.init(context, width: 1080, height: 2060, allowFontScaling: false);
//    return SafeArea(
//      child: Row(
//        children: [
//          Container(
//            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
//            width: 537.5.w,
//            height: 1920.h,
//            color: Colors.red,
//            child: Text(
//              'My width:${375.w}dp \n'
//              'My height:${1038.h}dp',
//              style: TextStyle(
//                  color: Colors.white, fontSize: ScreenUtil().setSp(40)),
//            ),
//          ),
//          Container(
//            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
//            width: ScreenUtil().setHeight(537.5),
//            height: ScreenUtil().setHeight(1920),
//            color: Colors.blue,
//            child: Text(
//                'My width:${ScreenUtil().setWidth(375)}dp \n'
//                'My height:${ScreenUtil().setHeight(200)}dp \n Device width:${ScreenUtil.screenWidth}px \n Device width:${ScreenUtil.screenWidthDp}dp \n Device height:${ScreenUtil.screenHeight}px \n Device height:${ScreenUtil.screenHeightDp}dp',
//                style: TextStyle(
//                    color: Colors.white, fontSize: ScreenUtil().setSp(40))),
//          ),
//        ],
//      ),
//    );
//  }
//}
