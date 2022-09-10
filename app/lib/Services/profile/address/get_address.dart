import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'address_model.dart';
import 'package:gardenfth/Services/getJwt.dart';
import 'package:path/path.dart' as path;
import 'package:gardenfth/Services/url_const.dart';


class AddressId{
  int id;
}
var addressid = AddressId();
//jwt JWTINSTANCE = jwt();

var userid = 1;
//final String url = "http://35.232.23.172:8000/profiles/address/?id_token=${jwtToken()}#";

class AdresscacheManager extends BaseCacheManager {
  static const key = "customCache";

  static AdresscacheManager _instance;

  factory AdresscacheManager() {
    if (_instance == null) {
      _instance = new AdresscacheManager._();
    }
    return _instance;
  }

  AdresscacheManager._()
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

  Future<GetAddress> getProfiles() async {
    var data = await http
        .get(Uri.encodeFull(await url("profiles/address")), headers: {"Accept": "application/json"});

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);
      print(jsonData);
      GetAddress address = GetAddress(
          jsonData[0]["id"],
          jsonData[0]["uid"],
          jsonData[0]["name"],
          jsonData[0]["address1"],
          jsonData[0]["address2"],
          jsonData[0]["city"],
          jsonData[0]["state"],
          jsonData[0]["pin_code"],
          jsonData[0]["lat"],
          jsonData[0]["longt"]);

      addressid.id = jsonData[0]["id"];
//      print("${addressid.id} is the address id");
      return address;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Address');
    }
  }
}