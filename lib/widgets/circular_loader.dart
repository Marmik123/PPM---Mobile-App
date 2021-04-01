import 'package:flutter/material.dart';

buildLoader({Color color = Colors.teal}) {
  return CircularProgressIndicator(
    strokeWidth: 1,
    valueColor: AlwaysStoppedAnimation<Color>(color),
    backgroundColor: Colors.grey,
  );
}
