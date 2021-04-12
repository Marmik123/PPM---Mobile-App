import 'package:flutter/material.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PlaceOrder extends StatefulWidget {
  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(left: 10, right: 10),
        children: [
          SizedBox(
            height: 100,
          ),
/*          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              alignment: Alignment.center,
              height: 100,
              width: 100,
              child: Text('QR Scanner'),
            ),
          )*/
          SizedBox(
            height: 30,
          ),
          Divider(
            height: 2,
            thickness: 2,
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            // controller: con.sController,
            decoration: InputDecoration(
              hintText: S.of(context).hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueGrey),
              ),
              // prefixIcon: Icon(Icons.person),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              // errorText: client?.get('phone_number') ?? '',
              // errorStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          RoundedLoadingButton(
            child: Text(S.of(context).send),
            borderRadius: 10,
            height: 35,
            width: 100,
            // controller: con.btnController,
            // onPressed: () async {
            //   await con.sendFeedback();
            // },
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: S.of(context).otp,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueGrey),
              ),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
          SizedBox(
            height: 25,
          ),
          RoundedLoadingButton(
            child: Text(S.of(context).Verify),
            borderRadius: 10,
            height: 35,
            width: 100,
            // controller: con.btnController,
            // onPressed: () async {
            //   await con.sendFeedback();
            // },
          ),
        ],
      ),
    );
  }
}
