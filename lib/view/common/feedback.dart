import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/feedback_controller.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

// ignore: must_be_immutable
class FeedbackPage extends StatelessWidget {
  FeedbackController con = Get.put(FeedbackController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: con.fkey,
      appBar: AppBar(
        title: Text(
          'Feedback',
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            // Container(
            //   color: Colors.cyan,
            //   height: 50,
            //   width: 50,
            // ),
            TextField(
              controller: con.sController,
              decoration: InputDecoration(
                labelText: 'Subject',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                fillColor: Colors.black26,
                // prefixIcon: Icon(Icons.person),
                labelStyle: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                // errorText: client?.get('phone_number') ?? '',
                // errorStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'FeedBack',
                hintText: 'Enter Feedback',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
              ),
              controller: con.mController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(
              height: 25,
            ),
            RoundedLoadingButton(
              child: Text('Submit'),
              borderRadius: 10,
              height: 35,
              width: 100,
              controller: con.btnController,
              onPressed: () async {
                await con.sendFeedback();
              },
            ),
          ],
        ),
      ),
    );
  }
}
