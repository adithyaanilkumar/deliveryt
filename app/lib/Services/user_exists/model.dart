//class UserExist {
//  int id;
////  dynamic lastLogin;
//  String username;
//  String firstName;
//  String lastName;
//  String email;
//  String phone;
////  List<int> address;
//
//  UserExist(
//    this.id,
////    this.lastLogin,
//    this.username,
//    this.firstName,
//    this.lastName,
//    this.email,
//    this.phone,
////    this.address,
//  );
//
//}
class UserExist {
  int id;
  dynamic lastLogin;
  String username;
  String firstName;
  String lastName;
  String email;
  String phone;
  List<int> address;

  UserExist({
    this.id,
    this.lastLogin,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
  });

  factory UserExist.fromJson(Map<String, dynamic> json) => UserExist(
    id: json["id"],
    lastLogin: json["last_login"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    address: List<int>.from(json["address"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "last_login": lastLogin,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "address": List<dynamic>.from(address.map((x) => x)),
  };
}