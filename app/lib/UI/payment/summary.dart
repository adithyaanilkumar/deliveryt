import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gardenfth/Constants/authConst.dart';
import 'package:gardenfth/Razorpay/check_razor.dart';
import 'package:gardenfth/Services/cart/updateCart.dart';
import 'package:gardenfth/Services/order_payments/model.dart';
import 'package:gardenfth/Services/order_payments/network.dart';
import 'package:gardenfth/Services/profile/network_profiles.dart';
import 'package:gardenfth/UI/cart/cart.dart';
import 'package:gardenfth/Services/profile/address/get_address.dart';
import 'package:gardenfth/UI/widgets/loader.dart';
import 'package:gardenfth/UI/profile/address.dart';


class summary extends StatefulWidget {

  final String total;

  summary(this.total);


  @override
  _summaryState createState() => _summaryState();
}

class _summaryState extends State<summary> {
  var u_id = user.id;

  Future<void> getadressid(AsyncSnapshot snapshot) async {
    ad_id = snapshot.data.id;
    print("$ad_id is the address id");
//    print("$u_id is the user id for razorpay");
  }

  var ad_id;
  var order_id;

  bool press = false;

  @override
  Widget build(BuildContext context) {
    AdresscacheManager adresscacheManager = AdresscacheManager();

    displayAddress(context, snapshot) {
      return Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
              ),
              child: Column(
                children: [
                  Icon(Icons.location_on),
                  Text(" "),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
            ),

            /// deliver to address column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Deliver To : ${snapshot.data.address1}',
                    style: TextStyle(fontSize: 17,
                        height: 1.0,
                        letterSpacing: 0.2,
                        fontFamily: 'SFPROBOLD',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text('${snapshot.data.name}'),
                Text('${snapshot.data.pin_code} \n${snapshot.data
                    .city} \n${snapshot.data.state}'),
              ],
            ),
          ),
        ],
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [

                /// this is the appbar
                Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                              pageBuilder: (context, animation,
                                  secondaryAnimation) =>
                                  cart(),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation,
                                  child) {
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
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 25,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Delivery Options            ',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      Text(" "),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                /// this is the address placeholder
                Container(
                  height: 95,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                          future: adresscacheManager.getProfiles(),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  child: Center(
                                      child: Spinner(context)
                                  ),
                                ),
                              );
                            } else {
                              getadressid(snapshot);
                              return displayAddress(context, snapshot);
                            }
                          }),

                      ///change address
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                        builder: (context) => Address()),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(color: Colors.blueGrey),
                                  ),
                                  child: Text("Change"),
                                ),
                              ),
                              Text(" "),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                /// this is the grey area in between address and to pay total
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
                ),

                /// Bill details area
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('Bill Details',
                                    style: TextStyle(height: 1.0,
                                        letterSpacing: 0.2,
                                        fontFamily: 'SFPROBOLD',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),),
                                  Text('Standard Delivery',
                                    style: heading_auth_smol,),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                height: 0.9,
                                width: double.infinity,
                                color: Colors.black12,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text('Subtotal'),
                                  Text('${widget.total}'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("Shipping"),
                                  Text("30"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DottedBorder(
                                color: Colors.red[800],
                                strokeWidth: 1,
                                child: Container(
                                  width: double.infinity,
                                  height: 40,
                                  color: Colors.redAccent[100],
                                  child: Center(child: Text(
                                      'You are saving ₹ 100 on this order')),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Container(
              height: 50,
              width: double.infinity,
              color: Colors.blueGrey,
              child:press ?
              FutureBuilder(
                  future: getorderlistid(),
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
                          MaterialPageRoute<void>(
                              builder: (context) => CheckRazor(amount: widget.total,order_id: snapshot.data.orderId)
                          ),
                        );
                        },
                        child: Text('${snapshot.data.orderId}'),
                      );
                    }
                  })
              :Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amount to pay',
                          style: TextStyle(fontSize: 16, color: Colors.white),),
                        Text('₹ ${widget.total} + Delivery',
                          style: TextStyle(fontSize: 17, color: Colors.white),),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        press = true;
                      });
//
                      final deetsUP = OrderDeetsUP(
                        user: 9,
                        address: 7,
                      );
                      getOrderId(deetsUP);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Place Order',
                          style: TextStyle(color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.white,)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    ),);
  }
}
