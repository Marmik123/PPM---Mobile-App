import 'package:flutter/material.dart';

buildLoader({Color color = Colors.green}) {
  return Center(
    child: Container(
      height: 50,
      width: 40,
      padding: const EdgeInsets.only(top: 10),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: Colors.grey,
      ),
    ),
  );
}

buildSmallLoader({Color color = Colors.green}) {
  return Container(
    height: 10,
    width: 5,
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 10),
    child: CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(color),
      backgroundColor: Colors.grey,
    ),
  );
}
