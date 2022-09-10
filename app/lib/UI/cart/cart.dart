import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gardenfth/Constants/authConst.dart';
import 'package:gardenfth/UI/mainScreen/mainsc.dart';
import 'package:gardenfth/UI/payment/summary.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'blank.dart';
import 'package:gardenfth/Services/cart/getCart.dart';
import 'package:gardenfth/Services/cart/updateCart.dart';
import 'package:gardenfth/Services/cart/cart_model.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCart();
  }

  List<double> fastquan = List<double>();
  List<double> fastprice = List<double>();
  List<double> fasttotal = List<double>();

  Future<void> fastQuan(AsyncSnapshot snapshot) async {
    for (int i = 0; i < snapshot.data.length; i++) {
      fastquan.add(double.parse(snapshot.data[i].quantity));
      print(fastquan[i]);
      fastprice.add(double.parse(snapshot.data[i].discount_price));
      fasttotal.add(fastquan[i] * fastprice[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    Widget createCart(BuildContext context, AsyncSnapshot snapshot) {
      double quantity;
      double add(String quan, int ind) {
        quantity = double.parse(quan);
        print(quantity);
        quantity += 1;
        setState(() {
          fastquan[ind] = quantity;
          fasttotal[ind] = quantity * fastprice[ind];
        });
        return quantity;
      }

      double reduce(String quan, int ind) {
        quantity = double.parse(quan);
        if (quantity > 1) {
          quantity -= 1;
          setState(() {
            fastquan[ind] = quantity;
            fasttotal[ind] = quantity * fastprice[ind];
          });
          return quantity;
        }
      }

      if (snapshot.data.length == 0) {
        return Center(
            child: Container(
                child: Column(
          children: [
            new Image(
              image: new AssetImage("assets/images/empty_cart.gif"),
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Your cart is empty',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            )
          ],
        )));
      } else {
        return Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: screenheight / 1.55,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                            '${snapshot.data[index].image_url}'),
                                      ),
                                      height: 50,
                                      width: 70,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        final item = UpdateCart(
                                          cartid: snapshot.data[index].cartid,
                                          user: 1,
                                          ordered: true,
                                          quantity: add(
                                              snapshot.data[index].quantity,
                                              index),
                                        );
                                        deleteCart(item);
                                        Navigator.of(context).push(
                                          MaterialPageRoute<void>(
                                              builder: (context) => Blank()),
                                        );
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: 13, top: 6, bottom: 6),
                                          padding: const EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.blueGrey),
                                            borderRadius:
                                                BorderRadius.circular(1),
                                          ),
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(color: Colors.red),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.transparent)),
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  height: 87,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${snapshot.data[index].name}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'SFPROBOLD'),
                                      ),
//                                    SizedBox(height: 4),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              '${snapshot.data[index].discount_price}'),
                                          Text(
                                            ' x ${fastquan[index]}',
                                          ),
                                        ],
                                      ),
//                                    Container(child: Text(''),),
                                      Text(
                                        '₹ ${fasttotal[index]}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'SFPROBOLD'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.transparent)),
                                height: 87,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        final item = UpdateCart(
                                          cartid: snapshot.data[index].cartid,
                                          user: 1,
                                          ordered: true,
                                          quantity: add(
                                              fastquan[index].toString(),
                                              index),
                                        );
                                        updateCart(item);
//                                                  Navigator.of(context).push(
//                                                    MaterialPageRoute<void>(builder: (context) => Blank(auth: widget.auth,)),
//                                                  );
                                      },
                                      child: Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Center(
                                      child: Center(
                                        child: Text(
                                          '${fastquan[index]}',
                                          style:
                                              TextStyle(fontFamily: 'SF-Pro'),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        final item = UpdateCart(
                                          cartid: snapshot.data[index].cartid,
                                          user: 1,
                                          ordered: true,
                                          quantity: reduce(
                                              fastquan[index].toString(),
                                              index),
                                        );
                                        updateCart(item);
//                                                  Navigator.of(context).push(
//                                                    MaterialPageRoute<void>(builder: (context) => Blank(auth: widget.auth,)),
//                                                  );
                                      },
                                      child: Icon(Icons.keyboard_arrow_down,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            height: 0.9,
                            width: double.infinity,
                            color: Colors.black12,
                          ),
                        ),
                      ]);
                    }),
              ),
            )
          ],
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(' '),
                      Center(
                          child: Text(
                        '           Your Cart',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      HomePage(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ));
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 0.9,
                    width: double.infinity,
                    color: Colors.redAccent[100],
                  ),
                ),
              ],
            ),
            Container(
              height: screenheight / 1.32,
              child: ListView(
                children: <Widget>[
//                  topbar(context),
//          cards(context),
                  FutureBuilder(
                    future: fetchCartItem(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Container(
                            height: screenheight,
                            width: screenWidth,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(bottom: screenheight / 2),
                              child: SpinKitRing(
                                lineWidth: 4,
                                color: Colors.blueGrey,
                                size: 50.0,
                              ),
                            ));
                      } else {
                        fastQuan(snapshot);
                        return createCart(context, snapshot);
                      }
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FutureBuilder(
                future: fetchCart(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: SpinKitThreeBounce(
                          color: Colors.grey[500],
                          size: 20.0,
                        ),
                      ),
                    );
                  } else {
                    return lowerBar(context, snapshot);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget lowerBar(BuildContext context, AsyncSnapshot snapshot) {
    bool empty;
    if (snapshot.data.total_price == null) {
      snapshot.data.total_price = '0';
      empty = true;
    } else if ('${snapshot.data.total_price}' == '0') {
      empty = true;
    } else {
      print('${snapshot.data.total_price}');
      empty = false;
    }
    return Column(
      children: [
        Container(
          color: Colors.grey[300],
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Container(
                child: empty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 17,
                            ),
                            Text('Empty Cart'),
                          ],
                        ),
                      )
                    : Spacer(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Subtotal:  ${snapshot.data.total_price}',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            if (empty == true) {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => HomePage(),
                  transitionDuration: Duration(milliseconds: 900),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  }));
            } else {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      summary(snapshot.data.total_price),
                  transitionDuration: Duration(milliseconds: 900),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  }));
            }
          },
          child: Container(
            height: 40,
            width: double.infinity,
            color: empty ? Colors.redAccent : Colors.green,
            child: Center(
                child: empty
                    ? Text(
                        'Go back to Shopping',
                        style: TextStyle(color: Colors.white),
                      )
                    : Text('Proceed to Checkout',
                        style: TextStyle(color: Colors.white))),
          ),
        )
      ],
    );
  }
}

//  Widget lowerBar(BuildContext context) {
//    double screenHeight = MediaQuery.of(context).size.height;
//    double screenWidth = MediaQuery.of(context).size.width;
//    return Container(
//      height: 500,
//      width: screenWidth,
//      child: Card(
//        child: Padding(
//          padding: const EdgeInsets.only(left: 30.0, right: 20),
//          child: Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  FutureBuilder(
//                    future: fetchCartCart(),
//                    builder: (BuildContext context, AsyncSnapshot snapshot) {
//                      if (snapshot.data == null) {
//                        return Container(
//                          child: Center(
//                            child: Text('Calculating',
//                                style: TextStyle(
//                                  color: Colors.grey[400],
//                                  fontFamily: 'SF-Pro',
//                                  fontSize: 18,
//                                )),
//                          ),
//                        );
//                      } else {
//                        return Text(
//                          'Total:  ${snapshot.data}',
//                          style: TextStyle(color: Colors.white, fontSize: 20),
//                        );
//                      }
//                    },
//                  ),
//                  Spacer(),
//                  Align(
//                      alignment: Alignment.center,
//                      child: Icon(
//                        Icons.keyboard_arrow_up,
//                        color: Colors.white,
//                      )),
//                  Spacer(),
//                  FlatButton(
//                    onPressed: () {
//                      Navigator.of(context).push(
//                        MaterialPageRoute<void>(builder: (context) => Pay()),
//                      );
//                    },
//                    child: Row(
//                      children: <Widget>[
//                        Text(
//                          'Pay',
//                          style: TextStyle(color: Colors.white, fontSize: 20),
//                        ),
//                        Icon(
//                          Icons.navigate_next,
//                          color: Colors.white,
//                          size: 30,
//                        )
//                      ],
//                    ),
//                  )
//                ],
//              ),
//              SizedBox(
//                height: 30,
//              ),
////              Container(
////                  height: screenHeight / 2,
////                  width: screenWidth / 1,
////                  child: Card(
////                    color: Colors.white,
////                    shape: RoundedRectangleBorder(
////                        borderRadius: BorderRadius.circular(20)),
////                    child: Padding(
////                      padding: EdgeInsets.only(
////                          top: 20, right: 20, left: 20, bottom: 20),
////                      child: TextField(
////                        decoration: InputDecoration(
////                          hintText: "Enter your specifications",
////                          hintStyle: TextStyle(color: Colors.grey[400]),
////                        ),
////                        maxLines: 20,
////                      ),
////                    ),
////                  ))
//            ],
//          ),
//        ),
////        elevation: 10,
////        margin: EdgeInsets.only(bottom: 0, left: 0, right: 0),
////        shape: RoundedRectangleBorder(
////          borderRadius: BorderRadius.only(
////              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
////        ),
//        color: Colors.black,
//      ),
//    );
//  }
//}

@override
Widget topbar(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text(
            'Cart',
            style: title,
          )
        ],
      ),
    ),
  );
}
