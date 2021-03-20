import 'package:flutter/material.dart';

Widget dashboardContainer({
  String name,
  IconData icon,
  VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.all(10),
      child: Card(
        color: Colors.cyanAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 50,
            ),
            // : Container(
            //     margin: EdgeInsets.all(10),
            //     color: Colors.cyan,
            //     height: 50,
            //     width: 50,
            //   ),
            Text(name),
          ],
        ),
      ),
    ),
  );
}
