import 'package:flutter/material.dart';
import 'package:gardenfth/Services/product_model.dart';
import 'package:gardenfth/UI/mainScreen/modules.dart';

class Cell extends StatelessWidget {
  const Cell(this.pro);
  @required
  final Products pro;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right:8.0),
      child: card_details(
          "${pro.image_url}",
          "${pro.name}",
          "${pro.regular_price}",
          pro),
    );
  }
}
