class Products {
  int id;
  String name;
  String category;
  String description;
  String image_url;
  String regular_price;
  String discount_price;
  bool active;
  bool popular;
  String stock;
  bool taxable;


  Products(
      this.id,
      this.name,
      this.category,
      this.description,
      this.image_url,
      this.regular_price,
      this.discount_price,
      this.active,
      this.popular,
      this.stock,
      this.taxable,
  );
}

//import 'dart:convert';
//class Products {
//  int id;
//  String name;
//  String category;
//  String description;
//  String imageUrl;
//  String regularPrice;
//  String discountPrice;
//  bool active;
//  bool popular;
//  String stock;
//  bool taxable;
//  DateTime createdAt;
//  DateTime updatedAt;
//
//  Products({
//    this.id,
//    this.name,
//    this.category,
//    this.description,
//    this.imageUrl,
//    this.regularPrice,
//    this.discountPrice,
//    this.active,
//    this.popular,
//    this.stock,
//    this.taxable,
//    this.createdAt,
//    this.updatedAt,
//  });
//
//  factory Products.fromJson(Map<String, dynamic> json) => Products(
//    id: json["id"],
//    name: json["name"],
//    category: json["category"],
//    description: json["description"],
//    imageUrl: json["image_url"],
//    regularPrice: json["regular_price"],
//    discountPrice: json["discount_price"],
//    active: json["active"],
//    popular: json["popular"],
//    stock: json["stock"],
//    taxable: json["taxable"],
//    createdAt: DateTime.parse(json["created_at"]),
//    updatedAt: DateTime.parse(json["updated_at"]),
//  );
//
//}