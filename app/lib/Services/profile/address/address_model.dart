
class GetAddress{
  int id;
  String uid;
  String name;
  String address1;
  String address2;
  String city;
  String state;
  String pin_code;
  String lat;
  String longt;

  GetAddress(
      this.id,
      this.uid,
      this.name,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.pin_code,
      this.lat,
      this.longt
      );
}

class AddressUp{
  int id;
  String uid;
  String name;
  String address1;
  String address2;
  String city;
  String state;
  String pin_code;
  double lat;
  double longt;
  AddressUp({
    this.id,
    this.uid,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.pin_code,
    this.lat,
    this.longt
  });

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] =  this.id;
    data["uid"] =  this.uid;
    data["name"] =  this.name;
    data["address1"] =  this.address1;
    data["address2"] =  this.address2;
    data["city"] =  this.city;
    data["state"] =  this.state;
    data["pin_code"] =  this.pin_code;
    data["lat"] =  this.lat;
    data["longt"] =  this.longt;
    return data;
  }
}