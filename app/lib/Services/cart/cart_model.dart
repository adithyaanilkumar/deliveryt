class FetchCartInfo{
  int id;
  int user;
  bool ordered;
  String total_price;

  FetchCartInfo(
      this.id,
      this.user,
      this.ordered,
      this.total_price
      );
}

class FetchCartItems{
  int cartid;
  int user;
  bool ordered;
  int id;
  String name;
  String category;
  String description;
  String image_url;
  String regular_price;
  String discount_price;
//  bool active;
//  bool popular;
//  String stock;
//  bool taxable;
  String quantity;
  //  String amount_saved;
  String price;

  FetchCartItems(
      this.cartid,
      this.user,
      this.ordered,
      this.id,
      this.name,
      this.category,
      this.description,
      this.image_url,
      this.regular_price,
      this.discount_price,
      this.quantity,
      this.price
      );
}

class UpdateCart{
  int cartid;
  int user;
  double quantity;
  bool ordered;

  UpdateCart({
    this.cartid,
    this.user,
    this.quantity,
    this.ordered
  });

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] =  this.cartid;
    data["user"] = this.user;
    data["ordered"] =  this.ordered;
    data["quantity"] = this.quantity;

    return data;
  }
}

