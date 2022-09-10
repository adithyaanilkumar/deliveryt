import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'details_model.dart';
import 'package:gardenfth/Services/getJwt.dart';

//final String urlA = "http://35.232.23.172:8000/profiles/cartitem/?id_token=${jwtToken()}#";

Future<String> urlA()async
{
  return  "http://35.232.23.172:8000/profiles/cartitem/?id_token=" + await jwtToken();
}
Future<String> url()async
{
  return  "http://35.232.23.172:8000/profiles/cart/?id_token=" + await jwtToken();
}
Future<String> urlB(String param)async
{
  return  "http://35.232.23.172:8000/profiles/cartitem/"+param+"/?id_token=" + await jwtToken();
}

var cartitem;
var id;

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<double> fetchAlbum(var userid, var productid) async {
  String quantityS;
  int idS;
  double quantity = 0.00;
  final response =
  await http.get(await url());
  if (response.statusCode <= 201) {
    var jsonData = json.decode(response.body);
    print(jsonData);
    for(var i = 0 ; i < jsonData[0]['cart_items'].length ; i++){
      if(jsonData[0]['cart_items'][i]['product']['id'] == productid){
        quantityS = jsonData[0]['cart_items'][i]['quantity'];
        quantity = double.parse('${quantityS}');
        idS = jsonData[0]['cart_items'][i]['id'];
      }
    }
    id = idS;
    return quantity;
  } else {
    throw Exception('Failed to load item');
  }
}

Future<Album> addCart(Cart item) async {
  final http.Response response = await http.post(
      await urlA(),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(item.toJson())
  );

  if (response.statusCode <= 201) {
    print(json.decode(response.body));
    cartitem = Album.fromJson(json.decode(response.body));
    print(cartitem.id);
    id = cartitem.id;
  } else {
    printWrapped(response.body);
    print(response.statusCode);
    throw Exception('Failed to add');
  }
}

Future<Album> updateCart(Cart item) async {
  final http.Response response = await http.put(
    await urlB("$id"),
//      'http://35.232.23.172:8000/profiles/cartitem/$id/?id_token=${jwtToken()}#',
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

Future<Album> deleteCart() async {
  final http.Response response = await http.delete(
    await urlB("$id"),
//    'http://35.232.23.172:8000/profiles/cartitem/$id/?id_token=${jwtToken()}#',
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