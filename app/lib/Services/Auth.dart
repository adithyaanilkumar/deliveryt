import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  User({@required this.uid});

  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;

  Future<User> currentUser();
  Future<User> signInAnon();
  Future<User> signInWithGoogle();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<User> signInWithOTP(smsCode, verId);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  //this is a method to tranform firebase user to User
  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInAnon() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '1');
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', '1');
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: "Missing google auth token");
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: "Sign in aborted by User");
    }
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signIn(AuthCredential authCreds) async {
    final authResult = await _firebaseAuth.signInWithCredential(authCreds);
    print("${authResult.user} is gay");
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    final authResult = signIn(authCreds);
//    print("i am  ${authResult.user})");
//    return _userFromFirebase(authResult.user);
  }


    @override
    Future<void> signOut() async {
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", "");
      await _firebaseAuth.signOut();
    }
  }

//class AuthService  {
//  final _firebaseAuth = FirebaseAuth.instance;
//
//  //Sign out
//  @override
//  signOut() {
//    _firebaseAuth.signOut();
//  }
//
//  //SignIn
//  @override
//  signIn(AuthCredential authCreds) {
//    _firebaseAuth.signInWithCredential(authCreds);
//  }
//
//  @override
//  signInWithOTP(smsCode, verId) {
//    AuthCredential authCreds = PhoneAuthProvider.getCredential(
//        verificationId: verId, smsCode: smsCode);
//    signIn(authCreds);
//  }
//}