import 'package:flutter/material.dart';

buildLoader({Color color = Colors.teal}) {
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
