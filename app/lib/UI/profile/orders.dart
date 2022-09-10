import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:gardenfth/Services/profile/getOrders.dart';
import 'package:gardenfth/UI/widgets/loader.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double screenheight = MediaQuery
        .of(context)
        .size
        .height;
    Widget creatOrderInfo(BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [

                Container(
                    padding: EdgeInsets.only(top: 10),
                    width: screenWidth,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10,top: 10,right:screenWidth),
                          child: Text('${index+1}'),
                        ),
                        Text('Tax:                   ₹ ${snapshot.data[index].tax}',style: TextStyle(color: Colors.grey),),
                        Text('Delivery fee:       ₹ ${snapshot.data[index].delivery_fee}',style: TextStyle(color: Colors.grey),),
                        Text('Discount:                ${snapshot.data[index].coupon_discount}',style: TextStyle(color: Colors.grey),),
                        Text('Cart price:      ₹ ${snapshot.data[index].cart_price}',style: TextStyle(color: Colors.grey),),
                        Text('Total price:     ₹ ${snapshot.data[index].total_price}',style: TextStyle(color: Colors.grey[700],fontSize: 17),),

                        ExpansionTile(
                          backgroundColor: Colors.white,
                          title: Text('See more',style: TextStyle(color: Colors.grey),),
                          children: [
                            Container(
                              child: Text('Date:       ${snapshot.data[index].created_at}',style: TextStyle(color: Colors.grey[700],fontSize: 15),),
                            ),
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Text('${snapshot.data[index].prod_list}',style: TextStyle(color: Colors.grey),)),
                          ],
                        ),
                      ],
                    ),
                  ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    height: 10,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
                ),
              ],
            );
          },
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('My Orders',style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pop(PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                  Profile(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
          future: FetchOrderInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                    child: Spinner(context)
                ),
              );
            } else {
              return creatOrderInfo(context, snapshot);
            }
          }),
    );
  }
}
