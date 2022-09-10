import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'Profiles_model.dart';
import 'update_model.dart';
import 'package:gardenfth/Services/getJwt.dart';
import 'network_profiles.dart';
//jwt JWTINSTANCE = jwt();


Future<String> url(String param)async
{
  return  "http://35.232.23.172:8000/profiles/user/"+param+"/?id_token=" + await jwtToken();
}

//String url = 'http://35.232.23.172:8000/profiles/user/${user.id}/?id_token=${jwtToken()}#';
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<NameUp> updateName(NameUp name) async {
  print(user.id);
  final http.Response response = await http.put(await
      url("${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(name.toJson())
  );

  if (response.statusCode <= 201) {
    print('updated firstname & lastname');
    print(json.decode(response.body));
  } else {
    print(response.statusCode);
    printWrapped(response.body);
    throw Exception('Failed to update');
  }
}

Future<EmailUp> updateEmail(EmailUp email) async {
  final http.Response response = await http.put(
      await url("${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(email.toJson())
  );

  if (response.statusCode <= 201) {
    print('updated email');
    print(json.decode(response.body));
  } else {
    print(response.statusCode);
    printWrapped(response.body);
    throw Exception('Failed to update');
  }
}

Future<PhoneUp> updatePhone(PhoneUp phone) async {
  final http.Response response = await http.put(
      await url("${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(phone.toJson())
  );

  if (response.statusCode <= 201) {
    print('updated phone');
    print(json.decode(response.body));
  } else {
    print(response.statusCode);
    printWrapped(response.body);
    throw Exception('Failed to update');
  }
}