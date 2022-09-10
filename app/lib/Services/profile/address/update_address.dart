import 'package:gardenfth/Services/profile/address/get_address.dart';
import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'address_model.dart';
import 'package:gardenfth/Services/url_const.dart';


var userid =1;
//jwt JWTINSTANCE = jwt();

//String url = 'http://35.232.23.172:8000/profiles/address/${addressid.id}/?id_token=${jwtToken()}#';

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<AddressUp> updateAddress(AddressUp address) async {
  final http.Response response = await http.put(
      await url("profiles/address/${addressid.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(address.toJson())
  );

  if (response.statusCode <= 201) {
    print('updated address');
    print(json.decode(response.body));
  } else {
    print(response.statusCode);
    printWrapped(response.body);
    throw Exception('Failed to update');
  }
}