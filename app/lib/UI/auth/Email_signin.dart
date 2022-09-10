import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gardenfth/Constants/authConst.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/Services/auth_provider.dart';
import 'package:gardenfth/UI/auth/Email_signup.dart';
import 'package:gardenfth/UI/auth/validator.dart';
import 'package:gardenfth/UI/cart/cart.dart';
import 'package:provider/provider.dart';



class EmailSignIn extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmailSignInForm(),
    );
  }
}

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator{

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

String get _email => _emailController.text;
  String get _pass => _passController.text;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();


  @override
  void dispose(){
    _emailController.dispose();
    _passController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    print("Dispose called");
    super.dispose();
  }

//  bool submitted = false;
  Function _emaileditingcomplete()
  {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }


  void _submit()async{
    setState(() {
//      submitted = true;
    });
    try{
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithEmailAndPassword(_email, _pass);
   FirebaseUser user = await FirebaseAuth.instance.currentUser();
   String token;
   user.getIdToken().then((result) {
     token = result.token;
     print('${token} is gay ');
   });
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


//    bool submitEnabled = widget.emailValidator.isValid(_email) &&
//        widget.passValidator.isValid(_pass);


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
                              child: Text("Sign In", style: heading_auth_smol),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              child: Text(
                                "Sign Up",
                                style: heading_auth_smol_2,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
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
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(

//                        onEditingComplete: _emaileditingcomplete(),
                        focusNode: _emailFocusNode,
                        autocorrect: false,
                        onChanged: (email) => _updateState(),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _emailController,
                        validator: (val) =>
                        !val.contains('@') ? "Invalid Email" : null,
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          hintText: "Enter valid email",
//                          errorText: !widget.emailValidator.isValid(_email) ? widget.Invalidemailerrortext : null ,
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
                        onChanged: (password) => _updateState(),
                        obscureText: _obscureText,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
//                          errorText: !widget.passValidator.isValid(_pass) ? widget.Invalidpasserrortext : null ,
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
                            child: Text("Sign In"),
                            color: Colors.redAccent[100],
                            textColor: Colors.white,
                            padding: EdgeInsets.only(
                                left: 38, right: 38, top: 15, bottom: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
//                            onPressed: submitEnabled ? _submit : false,
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

  void _updateState() {
    print("email : $_email , pass : $_pass");
    setState(() {
    });
  }


}