class OrderDeetsUP {
  int id;
  String orderId;
  String paymentStatus;
  bool ordered;
  bool completed;
  String tax;
  String deliveryFee;
  dynamic couponDiscount;
  String cartPrice;
  String totalPrice;
  String orderItems;
  DateTime createdAt;
  DateTime updatedAt;
  int user;
  int orderCart;
  int address;

  OrderDeetsUP({
    this.id,
    this.orderId,
    this.paymentStatus,
    this.ordered,
    this.completed,
    this.tax,
    this.deliveryFee,
    this.couponDiscount,
    this.cartPrice,
    this.totalPrice,
    this.orderItems,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.orderCart,
    this.address,
  });

  factory OrderDeetsUP.fromJson(Map<String, dynamic> json) => OrderDeetsUP(
        id: json["id"],
        orderId: json["order_id"],
        paymentStatus: json["payment_status"],
        ordered: json["ordered"],
        completed: json["completed"],
        tax: json["tax"],
        deliveryFee: json["delivery_fee"],
        couponDiscount: json["coupon_discount"],
        cartPrice: json["cart_price"],
        totalPrice: json["total_price"],
        orderItems: json["order_items"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: json["user"],
        orderCart: json["order_cart"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "payment_status": paymentStatus,
        "ordered": ordered,
        "completed": completed,
        "tax": tax,
        "delivery_fee": deliveryFee,
        "coupon_discount": couponDiscount,
        "cart_price": cartPrice,
        "total_price": totalPrice,
        "order_items": orderItems,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user,
        "order_cart": orderCart,
        "address": address,
      };
}



class OrderDeetsdown {
  int id;
  String orderId;
  String paymentStatus;
  bool ordered;
  bool completed;
  String tax;
//  String deliveryFee;
//  dynamic couponDiscount;
//  String cartPrice;
//  String totalPrice;
//  String orderItems;
//  DateTime createdAt;
//  DateTime updatedAt;
//  int user;
//  int orderCart;
//  int address;

  OrderDeetsdown(
    this.id,
    this.orderId,
    this.paymentStatus,
    this.ordered,
    this.completed,
    this.tax,
//    this.deliveryFee,
//    this.couponDiscount,
//    this.cartPrice,
//    this.totalPrice,
//    this.orderItems,
//    this.createdAt,
//    this.updatedAt,
//    this.user,
//    this.orderCart,
//    this.address,
  );
}
