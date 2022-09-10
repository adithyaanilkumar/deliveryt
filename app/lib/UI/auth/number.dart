import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'otp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String phoneNo, verificationId, smsCode;

  bool codeSent = false;

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                  children: <Widget>[
                    Container(
                        constraints: const BoxConstraints(
                            maxWidth: 500
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(text: 'We will send you an ', style: TextStyle(color: Colors.red)),
                            TextSpan(
                                text: 'One Time Password ', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            TextSpan(text: 'on this mobile number', style: TextStyle(color: Colors.red)),
                          ]),
                        )),
                    Container(
                      height: 40,
                      constraints: const BoxConstraints(
                          maxWidth: 500
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: CupertinoTextField(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5,color: Colors.grey[300]),
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(4),
                            )
                        ),
                        clearButtonMode: OverlayVisibilityMode.editing,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        placeholder: 'Enter your number',
                        onChanged: (val) {
                          setState(() {
                            this.phoneNo = "+91$val";
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      constraints: const BoxConstraints(
                          maxWidth: 500
                      ),
                      child: RaisedButton(
                        onPressed: (){
                          if(codeSent){
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(builder: (context) => OtpPage(verificationId: verificationId,)),
                            );}
                                else{
                            verifyPhone(phoneNo);
                          }
                                },
                        color: Colors.red,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                            codeSent ? Text('Login',style: TextStyle(color: Colors.white),) : Text('Verify',style: TextStyle(color: Colors.white),),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  color: Colors.red
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            ],
          )),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      Auth().signIn(authResult);
    };

    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}