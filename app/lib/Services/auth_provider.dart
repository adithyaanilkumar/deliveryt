import 'package:flutter/cupertino.dart';
import 'package:gardenfth/Services/Auth.dart';

class AuthProvider extends InheritedWidget{
  AuthProvider({this.auth,@required this.child});
  final AuthBase auth;
  final Widget child;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static AuthBase of(BuildContext context)
  {
    AuthProvider provider = context.inheritFromWidgetOfExactType(AuthProvider);
    return provider.auth;
  }
}