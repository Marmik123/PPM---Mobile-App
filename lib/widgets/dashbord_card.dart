import 'package:flutter/material.dart';

Widget dashboardContainer({
  String name,
  String url,
  VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 100,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              color: Colors.cyan,
              height: 50,
              width: 50,
            ),
            Text(name),
          ],
        ),
      ),
    ),
  );
}
