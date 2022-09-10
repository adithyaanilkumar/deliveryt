import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gardenfth/UI/auth/Old_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'Profiles_model.dart';
import 'package:gardenfth/Services/getJwt.dart';
import 'package:path/path.dart' as path;


class User{
  int id;
}
var user = User();
//jwt JWTINSTANCE = jwt();

//final String url = "http://35.232.23.172:8000/profiles/user/?id_token=eyJhbGciOiJSUzI1NiIsImtpZCI6IjVlOWVlOTdjODQwZjk3ZTAyNTM2ODhhM2I3ZTk0NDczZTUyOGE3YjUiLCJ0eXAiOiJKV1QifQ.eyJwcm92aWRlcl9pZCI6ImFub255bW91cyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9nYXJkZW4tZnRoIiwiYXVkIjoiZ2FyZGVuLWZ0aCIsImF1dGhfdGltZSI6MTU4ODI2NjEwMCwidXNlcl9pZCI6Ik1nU2dLRmJmU2pYczRocnZucExueEJrTjBXVjIiLCJzdWIiOiJNZ1NnS0ZiZlNqWHM0aHJ2bnBMbnhCa04wV1YyIiwiaWF0IjoxNTg4MjY2MTAwLCJleHAiOjE1ODgyNjk3MDAsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnt9LCJzaWduX2luX3Byb3ZpZGVyIjoiYW5vbnltb3VzIn19.F-wZuh9XJdcYR2owIoCqUShhKwdkhuKCTTvDVoP4o9gLEc0Zq3qHMmgRdWtN1Y26jhPNxndqrL-IKrn0V5Xwl2jNFy4Qap9AzNrVxNeDWMnBDf5aLG6DNMOOMlYn8hmXCuyoGRFrYkABghz3HkWPlCbbxdcK9UcZQbtT4nuyorMALugo1-0IlzMNtt5hoLxWyvIO2CG2v3GL1Ts4cuvrAaK_Fzu0Plz9eTeWUeftVeiWMzI3bCCzgpOd6ZbmPosph4iw-vAgtnwuRAYm66coWi3CgmzEARF6tspzZZF2C4KSyMjC5-Enz181xBbifaWwEoOrlMEELIMkPsxAXrqApQ#";

 Future<String> url()async
{
  return  "http://35.232.23.172:8000/profiles/user/?id_token=" + await jwtToken();
}
class ProfileCacheManager extends BaseCacheManager {
  static const key = "customCache";

  static ProfileCacheManager _instance;

  factory ProfileCacheManager() {
    if (_instance == null) {
      _instance = new ProfileCacheManager._();
    }
    return _instance;
  }

  ProfileCacheManager._()
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

  Future<Profiles> getProfiles() async {
    var data = await http
        .get(Uri.encodeFull(await url()), headers: {"Accept": "application/json"});

    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);
      print(jsonData);
      Profiles profile = Profiles(jsonData[0]["id"],jsonData[0]['last_login'], jsonData[0]["username"], jsonData[0]["first_name"], jsonData[0]["last_name"], jsonData[0]["email"],jsonData[0]['date_joined'],jsonData[0]["phone"],);
      user.id = jsonData[0]['id'];
      return profile;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load ');
    }
  }
}



