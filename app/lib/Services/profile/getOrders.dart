import 'package:gardenfth/Services/getJwt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'orders_model.dart';

String url = "http://35.232.23.172:8000/orders/orders/?id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjVlOWVlOTdjODQwZjk3ZTAyNTM2ODhhM2I3ZTk0NDczZTUyOGE3YjUiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU4ODI2NjEwMCwidXNlcl9pZCI6Ik1nU2dLRmJmU2pYczRocnZucExueEJrTjBXVjIiLCJzdWIiOiJNZ1NnS0ZiZlNqWHM0aHJ2bnBMbnhCa04wV1YyIiwiaWF0IjoxNTg4MjY2MTAwLCJleHAiOjE1ODgyNjk3MDAsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.F-wZuh9XJdcYR2owIoCqUShhKwdkhuKCTTvDVoP4o9gLEc0Zq3qHMmgRdWtN1Y26jhPNxndqrL-IKrn0V5Xwl2jNFy4Qap9AzNrVxNeDWMnBDf5aLG6DNMOOMlYn8hmXCuyoGRFrYkABghz3HkWPlCbbxdcK9UcZQbtT4nuyorMALugo1-0IlzMNtt5hoLxWyvIO2CG2v3GL1Ts4cuvrAaK_Fzu0Plz9eTeWUeftVeiWMzI3bCCzgpOd6ZbmPosph4iw-vAgtnwuRAYm66coWi3CgmzEARF6tspzZZF2C4KSyMjC5-Enz181xBbifaWwEoOrlMEELIMkPsxAXrqApQ#";

Future<List<OrderInfo>> FetchOrderInfo() async{
  final response = await http.get(url);
  List<OrderInfo> orderinfo = [];
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    for(var  i = 0 ; i < jsonData.length ; i++){
      String orderList = jsonData[i]['order_items'].toString();
      OrderInfo info = OrderInfo(
        jsonData[i]['id'],
        jsonData[i]['order_id'],
        jsonData[i]['payment_status'],
        jsonData[i]['ordered'],
        jsonData[i]['completed'],
        jsonData[i]['tax'],
        jsonData[i]['delivery_fee'],
        jsonData[i]['coupon_discount'],
        jsonData[i]['cart_price'],
        jsonData[i]['total_price'],
        jsonData[i]['user'],
        jsonData[i]['order_cart'],
        jsonData[i]['address'],
        ConvertOrderList(orderList),
        jsonData[i]['created_at'].toString().substring(0,10),
        jsonData[i]['updated_at'],
      );
      orderinfo.add(info);
    }
    return orderinfo;
  }
  else{
    print(response.statusCode);
    print('failed to load orders');
  }
}

String ConvertOrderList(String orderList){
  String prodList1 = orderList.replaceAll(RegExp("'prod_list1':"), 'Products: \n');
  String prodList2 = prodList1.replaceAll(RegExp('{'), '');
  String prodList3 = prodList2.replaceAll(RegExp('}'), '');
  String prodList4 = prodList3.replaceAll(RegExp('qty'), 'quantity');
  String prodList5 = prodList4.replaceAll(RegExp('name'), '\n name');
  String prodList6 = prodList5.replaceAll(RegExp('"'), '');
  String prodList = prodList6.replaceAll(RegExp("'"), " ");

  return prodList;
}