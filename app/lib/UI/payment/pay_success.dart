import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaySuccess extends StatefulWidget {

  final PaymentSuccessResponse response;
  PaySuccess({
    @required this.response,
  });

  @override
  _PaySuccessState createState() => _PaySuccessState();
}

class _PaySuccessState extends State<PaySuccess> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.add,color: Colors.white,),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Icon(Icons.check,color: Colors.white,size: 80,),
              Padding(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                child: Text('PAYMENT SUCCESSFUL',style: TextStyle(color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.bold,fontSize: 20),),
              ),
              Text('Lorem ipsum ipsum Lorem',style: TextStyle(color: Colors.white),),
          Text("Your payment is successful and the response is\n OrderId: ${widget.response.orderId}\nPaymentId: ${widget.response.paymentId}\nSignature: ${widget.response.signature}"),
              SizedBox(height: screenheight/4,),
              Text('Receipt',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w400),),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Column(
                      children: [
                        Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 2, color: Colors.white)),
                        child: Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                        ),
              ),
                        Text('Mail',style: TextStyle(color: Colors.white),),
                      ],
                    ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(width: 2, color: Colors.white)),
                              child: Icon(
                                Icons.chat_bubble_outline,
                                color: Colors.white,
                              ),
                            ),
                            Text('SMS',style: TextStyle(color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
