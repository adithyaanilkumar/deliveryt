class Deets {
  int id;
  dynamic last_login;
  String username;
  String first_name;
  String last_name;
  String email;
  String phone;
  List<int> address;

  Deets({
    this.id,
    this.last_login,
    this.username,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.address,
  });

  factory Deets.fromJson(Map<String, dynamic> json) {
    return Deets(
      id: json["id"],
      last_login: json["last_login"],
      username: json["username"],
      first_name: json["first_name"],
      last_name: json["last_name"],
      email: json["email"],
      phone: json["phone"],
      address: List<int>.from(json["address"].map((x) => x)),
    );
  }


}

class Deetsa {
  int id;
  dynamic last_login;
  String username;
  String first_name;
  String last_name;
  String email;
  String phone;
//  List<int> address;

  Deetsa(
    this.id,
    this.last_login,
    this.username,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
//    this.address,
  );
}