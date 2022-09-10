import 'package:flutter/material.dart';
import 'package:gardenfth/UI/payment/pay_failed.dart';
import 'package:gardenfth/UI/payment/pay_success.dart';
import 'package:gardenfth/UI/profile/settings.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckRazor extends StatefulWidget {
  final String amount;
final String order_id;
  CheckRazor({@required this.amount,@required this.order_id});

  @override
  _CheckRazorState createState() => _CheckRazorState();
}

class _CheckRazorState extends State<CheckRazor> {
  Razorpay _razorpay = Razorpay();
  var options;

  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  /// handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => PaySuccess(
          response: response,
        ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
    // Do something when payment succeeds
  }

  /// handle payment failed
  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => PayFailed(
          response: response,
        ),
      ),
      (Route<dynamic> route) => false,
    );
    _razorpay.clear();
  }

  /// handle external wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    options = {
      'key': "rzp_test_S1hzq8h7JbH0QQ", // Enter the Key ID generated from the Dashboard

      'amount': widget.amount, //in the smallest currency sub-unit.
      'name': 'organization',
      'order_id': widget.order_id,
      'currency': "INR",
      'theme.color': "#F37254",
      'buttontext': "Pay with Razorpay",
      'description': 'RazorPay example',
      'prefill': {
        'contact': '6969696969',
        'email': 'gardenFTH@gmail.com',
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    // print("razor runtime --------: ${_razorpay.runtimeType}");
    return Scaffold(
      body: FutureBuilder(
          future: payData(),
          builder: (context, snapshot) {
            return Container(
              child: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
