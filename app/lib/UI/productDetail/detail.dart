import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gardenfth/Services/product_model.dart';
import 'package:gardenfth/Services/details/cart_service.dart';
import 'package:gardenfth/Services/details/details_model.dart';
import 'package:gardenfth/UI/widgets/appbar.dart';
import 'package:gardenfth/UI/mainScreen/mainsc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:gardenfth/UI/widgets/loader.dart';
import 'dart:async';
import 'package:gardenfth/Services/profile/network_profiles.dart';

class Detail extends StatefulWidget {
  final Products product;

  Detail(this.product);

  @override
  _DetailState createState() => _DetailState();
}


class _DetailState extends State<Detail> {
//  var userid = us;
  double quantity = 1;

  void add() {
    build(context);
    quantity += 1;
    setState(() {
      quantity = quantity;
      build(context);
    });
  }

  void _bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                  height: 1500.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Center(
                          child: Text(
                            "Description",
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Gotik",
                                fontSize: 16.0),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                        child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen.",
                            style: TextStyle(
                                fontFamily: "Gotik",
                                color: Colors.black54,
                                letterSpacing: 0.3,
                                wordSpacing: 0.5)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Spesifications :",
                          style: TextStyle(
                              fontFamily: "Gotik",
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                              color: Colors.black,
                              letterSpacing: 0.3,
                              wordSpacing: 0.5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                        child: Text(
                          " - Lorem ipsum is simply dummy  ",
                          style: TextStyle(
                              fontFamily: "Gotik",
                              color: Colors.black54,
                              letterSpacing: 0.3,
                              wordSpacing: 0.5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  var _suggestedItem = Padding(
    padding:
    const EdgeInsets.only(left: 15.0, right: 20.0, top: 30.0, bottom: 20.0),
    child: Container(
      height: 280.0,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Top Rated Products",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: "Gotik",
                    fontSize: 15.0),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "See All",
                  style: TextStyle(
                      color: Colors.indigoAccent.withOpacity(0.8),
                      fontFamily: "Gotik",
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 20.0, bottom: 2.0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                FavoriteItem(
                  image: "assets/imgItem/shoes1.jpg",
                  title: "Fish!",
                  Salary: "\$ 10",
                  sale: "923 Sale",
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                FavoriteItem(
                  image: "assets/imgItem/acesoris1.jpg",
                  title: "Chicken",
                  Salary: "\₹ 200",
                  sale: "892 Sale",
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                FavoriteItem(
                  image: "assets/imgItem/kids1.jpg",
                  title: "Leg piece",
                  Salary: "\₹ 3",
                  sale: "110 Sale",
                ),
                Padding(padding: EdgeInsets.only(left: 10.0)),
                FavoriteItem(
                  image: "assets/imgItem/man1.jpg",
                  title: "Beef",
                  Salary: "\₹ 8",
                  sale: "210 Sale",
                ),
                Padding(padding: EdgeInsets.only(right: 10.0)),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  void reduce() {
    if (quantity == 1.0) {
      print('lowest quantity possible');
      setState(() {
        added = false;
      });
    } else {
      quantity -= 1;
    }
    setState(() {
      quantity = quantity;
      build(context);
    });
  }

  bool added;
  ProfileCacheManager cacheManager = ProfileCacheManager();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cacheManager.getProfiles();
    print(widget.product.id);
  }

  bool updated = true;

  void refresh(){
    setState(() {
      build(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget loader(){
      new Timer(new Duration(milliseconds: 300), () {
        setState(() {
          updated = true;
        });
      });
      return Spinner(context);
    }
    Widget _buildWidget() {
      try {
        return Image.network('${widget.product.image_url}');
      } catch (e) {
        print('enter catch exception start');
        print(e);
        print('enter catch exception end');
        return Container();
      }
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        iconButton: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (context) => HomePage()),
            );
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 300.0,
                    child: Material(
                      child: Image.network(widget.product.image_url),
                    ),
                  ),

                  ///title , price , add to cart
                  Container(
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Color(0xFF656565).withOpacity(0.15),
                        blurRadius: 1.0,
                        spreadRadius: 0.2,
                      )
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.product.name,
                                style: TextStyle(
                                    fontFamily: 'SF-Pro',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.grey[600]),
                              ),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Text(
                                "₹ ${widget.product.regular_price}",
                                style: TextStyle(
                                    fontFamily: 'SF-Pro',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              Padding(padding: EdgeInsets.only(top: 10.0)),
                              Divider(
                                color: Colors.black12,
                                height: 1.0,
                              ),
                            ],
                          ),

                          FutureBuilder(
                              future: fetchAlbum(user.id,widget.product.id),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Padding(
                                    padding:  EdgeInsets.only(left:58.0),
                                    child: Center(
                                        child: Spinner(context)
                                    ),
                                  );
                                } else if (snapshot.data == 0.00 && added != true) {
                                  return Padding(
                                    padding:  EdgeInsets.only(left:58.0),
                                    child: FlatButton(
                                      onPressed: () {
                                        setState(() {
                                          added = true;
                                          updated = false;
                                        });
                                        final cart = Cart(
                                            ordered: true,
                                            quantity: quantity,
                                            user: user.id,
                                            product: widget.product.id);
                                        addCart(cart);

                                        Flushbar(
//                                        title: "Hi",S
                                          message: "You've just added this product to cart",
                                          duration: Duration(seconds: 3),
                                          flushbarPosition: FlushbarPosition.BOTTOM,
                                          flushbarStyle: FlushbarStyle.GROUNDED,
                                          reverseAnimationCurve: Curves.decelerate,
                                          forwardAnimationCurve: Curves.elasticInOut,
                                          backgroundColor: Colors.greenAccent,
                                        )..show(context);
                                        refresh();
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                      child: Text(
                                        'ADD TO CART',
                                        style: TextStyle(
                                            fontFamily: 'SF-Pro', color: Colors.white),
                                      ),
                                      color: Colors.redAccent,
                                    ),
                                  );
                                } else {
                                  quantity = snapshot.data.toDouble();
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          if(quantity < 2){
                                            reduce();
                                            deleteCart();
                                            setState(() {
                                            updated = false;
                                            });
                                          }else{
                                            reduce();
                                          final cart = Cart(
                                              ordered: true,
                                              quantity: quantity,
                                              user: user.id,
                                              product: widget.product.id);
                                          updateCart(cart);
                                          setState(() {
                                            updated = false;
                                          });}
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 55.0, right: 15),
                                          padding: const EdgeInsets.all(15.0),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          child: FaIcon(
                                            FontAwesomeIcons.minus,
                                            size: 10.0,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      )
                                      , updated
                                          ?Text(
                                        '$quantity',
                                        style: TextStyle(
                                            fontFamily: 'SF-Pro',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )
                                          :loader(),

                                      InkWell(
                                        onTap: () {
                                          add();
                                          final cart = Cart(
                                              ordered: true,
                                              quantity: quantity,
                                              user: user.id,
                                              product: widget.product.id);
                                          updateCart(cart);
                                          setState(() {
                                            updated = false;
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 15.0),
                                          padding: const EdgeInsets.all(15.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey),
                                            borderRadius: BorderRadius.circular(
                                                2),
                                          ),
                                          child: FaIcon(
                                            FontAwesomeIcons.plus,
                                            size: 10.0,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      )

                                    ],
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ),

                  /// Background white for description
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 205.0,
                      width: 600.0,
                      decoration:
                      BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Color(0xFF656565).withOpacity(0.15),
                          blurRadius: 1.0,
                          spreadRadius: 0.2,
                        )
                      ]),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Gotik",
                                    fontSize: 16.0),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0,
                                    right: 20.0,
                                    bottom: 10.0,
                                    left: 20.0),
                                child: Text(
                                  widget.product.description,
                                  style: TextStyle(
                                      fontFamily: 'SF-Pro',
                                      fontSize: 15,
                                      color: Colors.grey[500]),
                                ),
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () {
                                  _bottomSheet();
                                },
                                child: Text(
                                  "View More",
                                  style: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 15.0,
                                    fontFamily: "Gotik",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  _suggestedItem
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  String image, Salary, title, sale;

  FavoriteItem({this.image, this.Salary, this.title, this.sale});

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF656565).withOpacity(0.15),
                blurRadius: 4.0,
                spreadRadius: 1.0,
//           offset: Offset(4.0, 10.0)
              )
            ]),
        child: Wrap(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.0),
                          topRight: Radius.circular(7.0)),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                ),
                Padding(padding: EdgeInsets.only(top: 15.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    title,
                    style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.black54,
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 1.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    Salary,
                    style: TextStyle(
                        fontFamily: "Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                  child: Text(
                    sale,
                    style: TextStyle(
                        fontFamily: "Sans",
                        color: Colors.black26,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// If user click icon chart SnackBar show
/// this code to show a SnackBar
/// and Increase a valueItemChart + 1
//InkWell(
//onTap: () {},
////            {
////              var snackbar = SnackBar(
////                content: Text("Item Added"),
////              );
////              setState(() {
////                valueItemChart++;
////              });
////              _key.currentState.showSnackBar(snackbar);
////            },
//child: Padding(
//padding: const EdgeInsets.only(bottom: 5.0),
//child: Container(
//color: Colors.white,
//child: Text(" ")
////                Row(
////                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////                  children: <Widget>[
////                    Container(
////                      height: 40.0,
////                      width: 60.0,
////                      decoration: BoxDecoration(
////                          color: Colors.white12.withOpacity(0.1),
////                          border: Border.all(color: Colors.black12)),
////                      child: Center(
////                        child: Icon(Icons.shopping_cart)
////                      ),
////                    ),
////
////                    /// Button Pay
////                    InkWell(
////                      onTap: () {},
//////                      {
//////                        Navigator.of(context).push(PageRouteBuilder(
//////                            pageBuilder: (_, __, ___) => new delivery()));
//////                      },
////                      child: Container(
////                        height: 45.0,
////                        width: 200.0,
////                        decoration: BoxDecoration(
////                          color: Colors.indigoAccent,
////                        ),
////                        child: Center(
////                          child: Text(
////                            "Pay",
////                            style: TextStyle(
////                                color: Colors.white,
////                                fontWeight: FontWeight.w700),
////                          ),
////                        ),
////                      ),
////                    ),
////                  ],
////                ),
//),
//),
//)


//      body: Padding(
//        padding: EdgeInsets.all(20),
//        child: Column(
//          children: <Widget>[
//            Center(
//              child: Container(
//                  width: width / 2,
//                  height: height / 3,
//                  child: Image.network(
//                      widget.product.image_url)
//              ),
//            ),
//            Center(
//              child: Container(
//                color: Colors.grey[300],
//                width: 40,
//                height: 23,
//                child: Center(
//                    child: Text(
//                      '1KG',
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold, color: Colors.grey[700]),
//                    )),
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: Center(
//                child: Text(
//                  widget.product.regular_price,
//                  style: TextStyle(
//                      fontFamily: 'SF-Pro',
//                      fontWeight: FontWeight.bold,
//                      fontSize: 25),
//                ),
//              ),
//            ),
//            Center(
//              child: Text(
//                widget.product.name,
//                style: TextStyle(
//                    fontFamily: 'SF-Pro',
//                    fontWeight: FontWeight.bold,
//                    fontSize: 20,
//                    color: Colors.grey[600]),
//              ),
//            ),
//            SizedBox(height: 10),
//            Center(
//              child: Text(
//                widget.product.description,
//                style: TextStyle(
//                    fontFamily: 'SF-Pro',
//                    fontSize: 15,
//                    color: Colors.grey[500]),
//              ),
//            ),
//            SizedBox(height: 20),
//            Padding(
//              padding: const EdgeInsets.all(10.0),
//              child: Center(
//                child: Text(
//                  'Quantity',
//                  style: TextStyle(
//                      fontFamily: 'SF-Pro',
//                      fontWeight: FontWeight.bold,
//                      fontSize: 18,
//                      color: Colors.grey[500]),
//                ),
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
//              child: FutureBuilder(
//                  future: fetchAlbum(userid, productid),
//                  builder: (BuildContext context, AsyncSnapshot snapshot) {
//                    if (snapshot.data == null) {
//                      return Text('bruh hold up');
//                    } else if (snapshot.data == 0.00) {
//                      return FlatButton(
//                        onPressed: () {
//                          setState(() {
//                            added = true;
//                          });
//                          final cart = Cart(
//                              ordered: true,
//                              quantity: quantity,
//                              user: 1,
//                              product: widget.product.id);
//                          addCart(cart);
//                          fetchAlbum(userid, productid);
//                        },
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(5)),
//                        child: Text(
//                          'ADD TO CART',
//                          style: TextStyle(
//                              fontFamily: 'SF-Pro', color: Colors.white),
//                        ),
//                        color: Colors.redAccent,
//                      );
//                    } else {
//                      quantity = snapshot.data;
//                      return Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          OutlineButton(
//                            onPressed: () {
//                              reduce();
//                              final cart = Cart(
//                                  ordered: true,
//                                  quantity: quantity,
//                                  user: 1,
//                                  product: widget.product.id);
//                              updateCart(cart);
//                              fetchAlbum(userid, productid);
//                            },
//                            borderSide:
//                            BorderSide(width: 2, color: Colors.grey[400]),
//                            child: FaIcon(
//                              FontAwesomeIcons.minus,
//                              size: 20.0,
//                              color: Colors.grey[400],
//                            ),
//                            padding: EdgeInsets.all(15.0),
//                            shape: CircleBorder(),
//                          ),
//                          Text(
//                            '$quantity',
//                            style: TextStyle(
//                                fontFamily: 'SF-Pro',
//                                fontWeight: FontWeight.bold,
//                                fontSize: 30),
//                          ),
//                          OutlineButton(
//                            onPressed: () {
//                              add();
//                              final cart = Cart(
//                                  ordered: true,
//                                  quantity: quantity,
//                                  user: 1,
//                                  product: widget.product.id);
//                              updateCart(cart);
//                              fetchAlbum(userid, productid);
//                            },
//                            borderSide:
//                            BorderSide(width: 2, color: Colors.grey[400]),
//                            child: FaIcon(
//                              FontAwesomeIcons.plus,
//                              size: 20.0,
//                              color: Colors.grey[400],
//                            ),
//                            padding: EdgeInsets.all(15.0),
//                            shape: CircleBorder(),
//                          ),
//                        ],
//                      );
//                    }
//                  }),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}

//quantity = snapshot.data;
//                      return

