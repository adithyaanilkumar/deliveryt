import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gardenfth/Constants/authConst.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/Services/auth_provider.dart';
import 'package:gardenfth/UI/auth/Email_signin.dart';
import 'package:gardenfth/UI/cart/cart.dart';
import 'package:provider/provider.dart';



class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {


  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;
  String get _pass => _passController.text;

  @override
  void dispose(){
    _emailController.dispose();
    _passController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    print("Dispose called");
    super.dispose();
  }

  Function _onEditingComplete()
  {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }


  void _submit()async{
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.createUserWithEmailAndPassword(_email, _pass);
      Navigator.of(context).pop();}
    catch(e)
    {print(e.toString(),);}
  }


  double screenHeight;
  bool _obscureText = true ;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, bottom: 30.0, left: 20, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text("Sign Up", style: heading_auth_smol),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              child: Text(
                                "Sign In",
                                style: heading_auth_smol_2,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmailSignIn(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Welcome to the Garden App", style: heading_auth),
                      ),
                      SizedBox(height: 5,),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Let's get started.",
                            style: heading_auth_smol_1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
//                      TextFormField(
//                        decoration: InputDecoration(
//                          labelText: "Name",
//                          hintText: "Enter your name",
//                          icon: Icon(
//                            Icons.account_circle,
//                            size: 30,
//                            color: Colors.red,
//                          ),
//                        ),
//                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
//                        onEditingComplete: _onEditingComplete(),
                        focusNode: _emailFocusNode,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        validator: (val) =>
                        !val.contains('@') ? "Invalid Email" : null,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          hintText: "Enter valid email",
                          icon: Icon(
                            Icons.mail,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onEditingComplete: _submit,
                        focusNode: _passwordFocusNode,
                        controller: _passController,
                        obscureText: _obscureText,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
//                        setState(() => _obscureText = !_obscureText); //TODO fix setstate part of this
                            },
                            child: Icon(Icons.visibility),
                          ),
                          labelText: "Password",
                          hintText: "Enter password",
                          icon: Icon(
                            Icons.lock,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Expanded(
                            child: Container(),
                          ),
                          FlatButton(
                            child: Text("Sign Up"),
                            color: Colors.redAccent[100],
                            textColor: Colors.white,
                            padding: EdgeInsets.only(
                                left: 38, right: 38, top: 15, bottom: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: _submit,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}