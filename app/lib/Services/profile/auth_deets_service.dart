import 'package:gardenfth/Services/auth_deets_model.dart';
import 'package:gardenfth/Services/cart/updateCart.dart';
import 'package:gardenfth/Services/getJwt.dart';
import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_deets_model.dart';
//jwt JWTINSTANCE = jwt();
import 'package:gardenfth/Services/url_const.dart';


Future<String> url()async
{
  String urlA = "http://35.232.23.172:8000/profiles/user/?id_token=${await jwtToken()}#";
  print(urlA);
  return  urlA;
}


//final String url = "http://35.232.23.172:8000/profiles/user/?id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjgyMmM1NDk4YTcwYjc0MjQ5NzI2ZDhmYjYxODlkZWI3NGMzNWM4MGEiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU5MDQ5NjI1MywidXNlcl9pZCI6IkZhOGE2Q3dxeEVaVVJuUVJhMWZ4UkZQNk5CdjIiLCJzdWIiOiJGYThhNkN3cXhFWlVSblFSYTFmeFJGUDZOQnYyIiwiaWF0IjoxNTkwNDk2MjUzLCJleHAiOjE1OTA0OTk4NTMsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.mmjEHCEPQGCdj-G3mAvMoQjmXfpshj6IcLrwv1NI5VeZFO7GAEBmzXg-xpJyq2HWhqdNPTBbYLlPzgAhjF8nwej85UBlKbDmIYxM2HzZ0FgKMOgf7kTewL5xNEqBTKLncS3M91dQyEBNFafRvcRuctxkfFi229nLIc9zJfkEMTcV1m20XURXTh39RpbgpOAVRBm2pt957xRjTw9m2i4zG1ewRz5PjJK7lh8koNOVMUXAz7FwKxTAdQwzgvJYQhGCGgou4_9HY70WKlZ_OfZ9RgZvVVT_RbB9xlXbUxOT6gXgzv0ZUXdhNK-fPDVipixbfiXA3a4K57bzyoCMeHolEQ#";

var response_item;
var firname;


Future<AuthUp> updateDeets(AuthUp authUp) async {
  final http.Response response = await http.post(
    await url()
    ,headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  },
      body: jsonEncode(authUp.toJson())

  );
  if (response.statusCode == 201) {
    response_item = json.decode(response.body);
    print(response_item);
    return response_item;
  } else {

    print(response.body);
    print(response.statusCode);
    throw Exception('Failed to add');
  }
}

Future<AuthDown> getDeets() async {
  var data = await http
      .get(Uri.encodeFull(
      await url() ), headers: {"Accept": "application/json"},);

  if (data.statusCode == 200) {
    var jsonData = json.decode(data.body);
      AuthDown authDown = AuthDown(
        jsonData[0]['id'],
        jsonData[0]['username'],
        jsonData[0]['first_name'],
        jsonData[0]['last_name'],
        jsonData[0]['email'],
        jsonData[0]['phone']
      );

    print("$jsonData");
    return authDown;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load ');
  }
}