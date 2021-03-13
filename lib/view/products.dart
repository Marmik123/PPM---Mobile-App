import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
