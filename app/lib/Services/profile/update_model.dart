class NameUp{
  String username;
  String firstname;
  String lastname;
  NameUp({this.username,this.firstname,this.lastname});

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["username"] =  this.username;
    data["first_name"] =  this.firstname;
    data["last_name"] =  this.lastname;
    return data;
  }
}

class EmailUp{
  String username;
  String email;
  EmailUp({this.username,this.email});

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["username"] =  this.username;
    data["email"] =  this.email;
    return data;
  }
}

class PhoneUp{
  String username;
  String phone;
  PhoneUp({this.username,this.phone});

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["username"] =  this.username;
    data["phone"] =  this.phone;
    return data;
  }
}
