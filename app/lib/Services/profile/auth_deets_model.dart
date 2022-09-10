class AuthUp{
  String fname;
  String lname;
  String email;
  String phone;
  AuthUp({this.fname,this.lname,this.email,this.phone});

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["first_name"] =  this.fname;
    data["last_name"] =  this.lname;
    data["email"] =  this.email;
    data["phone"] = this.phone;
    return data;
  }
}

class AuthDown{
  int id;
  String username;
  String firstname;
  String lastname;
  String email;
  String phone;

  AuthDown(
      this.id,
      this.username,
      this.firstname,
      this.lastname,
      this.email,
      this.phone
      );
}