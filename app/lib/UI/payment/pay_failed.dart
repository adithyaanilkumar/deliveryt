import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'pay_success.dart';

class PayFailed extends StatefulWidget {

  final PaymentFailureResponse response;
  PayFailed({
    @required this.response,
  });

  @override
  _PayFailedState createState() => _PayFailedState();
}

class _PayFailedState extends State<PayFailed> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: screenheight/1.9,
                width: screenWidth/1.3,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                         Center(
                            child: Image.asset('assets/images/payment_failed.jpg'),
                          ),
                        SizedBox(height: 5,),
                        Text('Payment Failed',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                        Text("Your payment is Failed and the response is\n Code: ${widget.response.code}\nMessage: ${widget.response.message}",),
                        SizedBox(height: 8,),
                        Text('Please check your internet connection',style: TextStyle(fontSize: 15,color: Colors.grey[600]),),
                        Spacer(),
                        FlatButton(
                          onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (context) => PaySuccess(response: null,
                                  )),
                            );
                          },
                          child: Text('Retry',style: TextStyle(color: Colors.white),),
                          color: Colors.redAccent,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
