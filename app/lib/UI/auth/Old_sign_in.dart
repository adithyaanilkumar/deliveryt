import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gardenfth/Services/Auth.dart';
import 'package:gardenfth/Services/auth_provider.dart';
import 'package:gardenfth/Services/getJwt.dart';
import 'package:gardenfth/UI/auth/Email_signin.dart';
import 'package:gardenfth/UI/auth/number.dart';
import 'package:provider/provider.dart';
import 'Email_signup.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> jwtToken() async {
//  _test_old_signinState inst = _test_old_signinState();
//  print("${inst.getToken()} from the jwt function");
  String value = await storage.read(key: 'jwt');
  print("$value is not working");
  return value;
}

final storage = FlutterSecureStorage();
String tokenF;

// const String token = jwtToken();
class test_old_signin extends StatefulWidget {
  @override
  _test_old_signinState createState() => _test_old_signinState();
}

class _test_old_signinState extends State<test_old_signin> {
  bool _isLoading = false;

// String token;
// Future<String> getToken ()async
// {
//   print("$token is from inside the class");
//   return await _signInAnon(context);
// }

  Future<void> _signInAnon(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnon();
      FirebaseUser user = await FirebaseAuth.instance.currentUser();


      user.getIdToken().then((result) async{
        tokenF = result.token;
        print('${tokenF} is gay ');
        await storage.write(key: 'jwt', value: tokenF);
        return tokenF;
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWGoogle(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      user.getIdToken().then((result) async{
        tokenF = result.token;
        print('${tokenF} is gay ');
        await storage.write(key: 'jwt', value: tokenF);
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _signInWEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EmailSignIn(),
      ),
    );
  }

  void _signUpWEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => SignUpPage(),
      ),
    );
  }

  void _signupWphone(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50.0, child: _buildHeade()),
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              onPressed: () => _signInWEmail(context),
              child: Text('SIGN IN',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.redAccent,
                  )),
            ),
            RaisedButton(
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              onPressed: () => _isLoading ? null : _signInWGoogle(context),
              child: Text('SIGN IN WITH GOOGLE',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.redAccent,
                  )),
            ),
            RaisedButton(
              elevation: 10,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              onPressed: () => _signupWphone(context),
              child: Text('SIGN UP WITH NUMBER',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.redAccent,
                  )),
            ),
            RaisedButton(
              elevation: 10,
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              onPressed: () async {
                if (_isLoading) {
                  return null;
                } else {
                  return await _signInAnon(context);
                }
              },
//                onPressed: () => _isLoading ? null : _signInAnon(context),
              child: Text('GO ANON',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )),
            ),
            FlatButton(
              color: Colors.redAccent,
              onPressed: () => _signUpWEmail(context),
              child: Text('SIGN UP',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeade() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Text(
            ' to',
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Text(
            ' Garden',
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      );
    }
  }
}
