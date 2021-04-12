import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/generated/l10n.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(S.of(context).Support,
      style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black),
      ),
      ),
    ),
    );
  }
}