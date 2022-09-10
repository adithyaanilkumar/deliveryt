import 'package:gardenfth/Services/getJwt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart_model.dart';
import 'package:gardenfth/UI/auth/Old_sign_in.dart';
var userid = 1;

Future<String> url()async
{
  return  "http://35.232.23.172:8000/profiles/cart/?id_token=" + await jwtToken();
}


Future<FetchCartInfo> fetchCart() async {
  final response = await http.get(await url());
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    FetchCartInfo cartInfo = FetchCartInfo(
      jsonData[0]['id'],
      jsonData[0]['user'],
      jsonData[0]['ordered'],
      jsonData[0]['total_price']
    );
    return cartInfo;
  } else {
    print(response.statusCode);
    throw Exception('Failed to load Cart Info');
  }
}

Future<List<FetchCartItems>> fetchCartItem() async {
  final response = await http.get(await url());
  List<FetchCartItems> fetchItems = [];
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(jsonData[0]['cart_items'].length);
    for(var i=0; i<jsonData[0]['cart_items'].length ; i++){
      print(jsonData[0]['cart_items'][i]['product']['id']);
      FetchCartItems item = FetchCartItems(
        jsonData[0]['cart_items'][i]['id'],
        jsonData[0]['cart_items'][i]['user'],
        jsonData[0]['cart_items'][i]['ordered'],
        jsonData[0]['cart_items'][i]['product']['id'],
        jsonData[0]['cart_items'][i]['product']['name'],
        jsonData[0]['cart_items'][i]['product']['category'],
        jsonData[0]['cart_items'][i]['product']['description'],
        jsonData[0]['cart_items'][i]['product']['image_url'],
        jsonData[0]['cart_items'][i]['product']['regular_price'],
        jsonData[0]['cart_items'][i]['product']['discount_price'],
        jsonData[0]['cart_items'][i]['quantity'],
        jsonData[0]['cart_items'][i]['price'],
      );
      fetchItems.add(item);
    }
    return fetchItems;
  } else {
    print(response.statusCode);
    throw Exception('Failed to load Items');
  }
}

Future<int> fetchItemsNumber() async{
  final response = await http.get(await url());
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    return jsonData[0]['cart_items'].length;
  }else{
    print(response.statusCode);
    throw Exception('Failed to load');
  }
}