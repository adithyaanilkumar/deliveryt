import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart_model.dart';
import 'dart:async';

var cartitem;
var id;

Future<String> url(String param)async
{
  return  "http://35.232.23.172:8000/profiles/cartitem/"+param +"/?id_token=" + await jwtToken();
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<UpdateCart> updateCart(UpdateCart item) async {
  final http.Response response = await http.put(
      await url("${item.cartid}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson())
  );

  if (response.statusCode <= 201) {
    print('updated');
    print(json.decode(response.body));
  } else {
    printWrapped(response.body);
    print(response.statusCode);
    throw Exception('Failed to update');
  }
}

Future<UpdateCart> deleteCart(UpdateCart item) async {
  final http.Response response = await http.delete(
    await url("${item.cartid}"),
//    'http://35.232.23.172:8000/profiles/cartitem/${item.cartid}/?id_token=${jwtToken()}#',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode <= 201) {
    print('deleted');
  } else {
    printWrapped(response.body);
    print(response.statusCode);
    throw Exception('Failed to delete');
  }
}