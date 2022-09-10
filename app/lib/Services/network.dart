import 'dart:io';

import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'product_model.dart';
import 'getJwt.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:gardenfth/Services/url_const.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//jwt JWTINSTANCE = jwt();

//Future<String> url(String page)async
//{
//  return  "http://35.232.23.172:8000/"+ page+"/?id_token=" + await jwtToken();
//}


class MyCacheManager extends BaseCacheManager {
  static const key = "customCache";

  static MyCacheManager _instance;

  factory MyCacheManager() {
    if (_instance == null) {
      _instance = new MyCacheManager._();
    }
    return _instance;
  }

  MyCacheManager._()
      : super(
          key,
          maxAgeCacheObject: Duration(minutes: 20),
          maxNrOfCacheObjects: 20,
        );

  @override
  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return path.join(directory.path, key);
  }


//   Future<List<Products>> getProducts() async {
//    var response = await http
//        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//
//    if (response.statusCode == 200) {
//      List<Products> list = parseProducts(response.body);
//      return list;
//    } else {
//      throw Exception("Failed to load products");
//    }
//  }
//  static List<Products> parseProducts(String responseBody) {
//    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//
//    return parsed.map<Products>((json) => Products.fromJson(json)).toList();
//  }


  Future<List<Products>> getProducts() async {
//    var uri =
//    Uri.https(url, queryParameters);
    var data = await http
        .get(Uri.encodeFull(await url("products")), headers: {"Accept": "application/json"},);

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);
      List<Products> product = [];


      for (var i in jsonData) {
        Products pro = Products(
          i["id"],
          i["name"],
          i["category"],
          i["description"],
          i["image_url"],
          i["regular_price"],
          i["discount_price"],
          i["active"],
          i["popular"],
          i["stock"],
          i["taxable"],
//          i["created_at"],
//          i["updated_at"]
        );
        product.add(pro);
      }
      print("$product");
      return product;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load ');
    }
  }
}

//class HttpProvider {
//  Future<Response> getProducts(String url) async {
//    var data = await DefaultCacheManager().getSingleFile(url);
//    if (data != null && await data.exists()) {
//      var res = await data.readAsString();
//      print("I AM TESTING HERE BOSS $res");
//      return Response(res, 200);
//    }
//    return Response(null, 404);
//  }
//}


//Future<List<Products>> getProducts() async {
//  var data = await http.get(
//    Uri.encodeFull(url),headers: {"Accept":"application/json"}
//  );
//
//  if (data.statusCode == 200) {
//    var jsonData = json.decode(data.body);
//    List<Products> product = [];
//
//    for (var i in jsonData) {
//      Products pro = Products(
//        i["id"],
//        i["name"],
//        i["category"],
//        i["description"],
//          i["image_url"],
//          i["regular_price"],
//          i["discount_price"],
//          i["active"],
//          i["popular"],
//          i["stock"],
//          i["taxable"],
////          i["created_at"],
////          i["updated_at"]
//      );
//      product.add(pro);
//    }
//    print("$product");
//    return product;
//  } else {
//    // If that call was not successful, throw an error.
//    throw Exception('Failed to load ');
//  }
//}