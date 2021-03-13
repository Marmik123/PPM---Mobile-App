import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Support',
      style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black),
      ),
      ),
    ),
    );
  }
}