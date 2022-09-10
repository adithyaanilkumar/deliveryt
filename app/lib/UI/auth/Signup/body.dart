import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/UI/auth/Signup/bg.dart';
import 'package:gardenfth/UI/auth/Signup/or_divider.dart';
import 'package:gardenfth/UI/auth/Signup/social_icons.dart';
import 'package:gardenfth/UI/auth/components/already_have.dart';
import 'package:gardenfth/UI/auth/components/rounded_button.dart';
import 'package:gardenfth/UI/auth/components/rounded_input.dart';
import 'package:gardenfth/UI/auth/components/rounded_pass.dart';
import 'package:gardenfth/UI/auth/login/final_login.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

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
  bool _isLoading = false;
  Future<void> _signInWGoogle(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      String token;
      user.getIdToken().then((result) {
        token = result.token;
        print('${token} is gay ');
      });
    } catch (e) {
      print(e.toString());
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  double screenHeight;
  bool _obscureText = true ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/login_icons/signup.svg",
              height: size.height * 0.35,
            ),
            /// email
            RoundedInputField(
              hintText: "Enter valid email",
              onChanged: (value) => _updateState,
              controller: _emailController,
            ),

            ///password

            RoundedPasswordField(
              submit: _submit,
              focusNode: _passwordFocusNode,
              controller: _passController,
              onChanged: (value) => _updateState,
              obscure: _obscureText,
              showPass: () {
                setState(() => _obscureText = !_obscureText); //TODO fix setstate part of this
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: _submit ,
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
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