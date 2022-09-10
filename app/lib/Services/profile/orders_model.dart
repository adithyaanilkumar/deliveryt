class OrderInfo{
  int id;
  String order_id;
  String payment_status;
  bool ordered;
  bool completed;
  String tax;
  String delivery_fee;
  String coupon_discount;
  String cart_price;
  String total_price;
  int user;
  int order_cart;
  int address;
  String prod_list;
  String created_at;
  String updated_at;
  OrderInfo(
      this.id,
      this.order_id,
      this.payment_status,
      this.ordered,
      this.completed,
      this.tax,
      this.delivery_fee,
      this.coupon_discount,
      this.cart_price,
      this.total_price,
      this.user,
      this.order_cart,
      this.address,
      this.prod_list,
      this.created_at,
      this.updated_at
      );
}
