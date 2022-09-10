import 'package:flutter/material.dart';
import 'package:gardenfth/Services/profile/network_profiles.dart';
import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:gardenfth/Services/getJwt.dart';
import 'dart:convert';
import 'model.dart';
//jwt JWTINSTANCE = jwt();

//final String url =
//    "http://35.232.23.172:8000/profiles/user/?id_token=${jwtToken()}#";

Future<String> url() async
{
  return  "http://35.232.23.172:8000/orders/orders/?id_token=" + await jwtToken();
}

  var o_id;
  var rep;


Future<OrderDeetsUP> getOrderId(OrderDeetsUP deetsUP) async {
  final http.Response response = await http.post(
    await url(),
    headers: {"Accept": "application/json", "content-type": "application/json"},
    body: jsonEncode(
        deetsUP.toJson(),
    ),
  );
  if(response.statusCode == 201)
    {
      rep = json.decode(response.body);
      print(rep);
      return rep;
    }else{
    print(response.body);
    print(response.statusCode);
    throw Exception('Failed to add');
  }
}


Future<OrderDeetsdown> getorderlistid() async {
  var data = await http
      .get(Uri.encodeFull(
      await url() ), headers: {"Accept": "application/json"},);

  if (data.statusCode == 200) {
    var jsonData = json.decode(data.body);
    OrderDeetsdown deetsdown = OrderDeetsdown(
        jsonData[0]['id'],
        jsonData[0]['orderId'],
        jsonData[0]['paymentStatus'],
        jsonData[0]['ordered'],
        jsonData[0]['completed'],
        jsonData[0]['tax']
    );

    print("$jsonData");
    return deetsdown;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load ');
  }
}
