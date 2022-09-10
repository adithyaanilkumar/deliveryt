import 'package:gardenfth/UI/auth/Old_sign_in.dart';

Future<String> url(String page)async
{
  return  "http://35.232.23.172:8000/"+ page+"/?id_token=" + await jwtToken();
}