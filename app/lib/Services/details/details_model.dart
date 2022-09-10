class Cart{
//  int id;
  bool ordered;
  double quantity;
  int user;
  int product;

  Cart({
//    this.id,
    this.ordered,
    this.quantity,
    this.user,
    this.product
  });

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["ordered"] =  this.ordered;
    data["quantity"] = this.quantity;
    data["user"] = this.user;
    data["product"] =  this.product;

    return data;
  }


//  Map<String, dynamic> toJson(){
//    return{
////      "id": id,
//      "ordered": ordered,
//      "quantity": quantity,
//      "amount_saved": amount_saved,
//      "price": price,
//      "user": user,
//      "product": product
//    };
//  }

}

class Album {
  final int id;
  final bool ordered;
  final String quantity;
  final int user;
  final int product;

  Album({
    this.id,
    this.ordered,
    this.quantity,
    this.user,
    this.product
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        id: json['id'],
        ordered: json['ordered'],
        quantity: json['quantity'],
        user: json['user'],
        product: json['product']
    );
  }
}