import 'package:flutter/material.dart' show required;

class CartItem {
  final String id;
  final String title;
  int quantity;
  final double price;
  final String size;
  final String unit;
  final String imageName;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.size,
    @required this.unit,
    @required this.imageName,
  });
}
