import 'dart:convert';

//import 'package:gardenfth/Services/cart/updateCart.dart';
import 'package:gardenfth/Services/getJwt.dart';
import 'package:flutter/material.dart';
import 'package:gardenfth/Services/user_exists/model.dart';
import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:gardenfth/Services/url_const.dart';
import 'package:http/http.dart' as http;
//jwt JWTINSTANCE = jwt();




Future<String> ifUserfirstTime() async {
  var data = await http
      .get(Uri.encodeFull(await url("profiles/user")), headers: {"Accept": "application/json"});

  if (data.statusCode == 200) {
    final responseBody = json.decode(data.body);
    List<UserExist> users = [];
    if (responseBody is List)
      {users = responseBody
          .map((data) => new UserExist.fromJson(data))
          .toList();
      print(users[0].firstName);
      return users[0].firstName;
      }

    else {
      print(responseBody);
      return null;
    }
  }else{
    print(data.statusCode);
    throw Exception("Problem in fetching address List");
  }
//    var jsonData = json.decode(data.body);
//    List<UserExist> users = [];
//
//
//    for (var i in jsonData) {
//      UserExist user = UserExist(
//        i["id"],
//        i["username"],
//        i["firstName"],
//        i["lastName"],
//        i["email"],
//        i["phone"],
//
//      );
//      users.add(user);
//    }


}