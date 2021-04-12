import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcm/controller/support_controller.dart';
import 'package:pcm/generated/l10n.dart';
import 'package:pcm/widgets/circular_loader.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  SupportController ctrl = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Support,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Support Details",
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                    color: Colors.cyan,
                    fontSize: 35,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Expanded(
              child: Obx(
            () => ctrl.isLoading.value
                ? buildLoader()
                : ListView.builder(
                    itemCount: ctrl.sData.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                          leading: Text(
                            "${ctrl.sData[index]['supportType']} :" ?? "-",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.cyan,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          trailing: Text(ctrl.sData[index]['data'] ?? "-"),
                        )),
          ))
        ],
      ),
    );
  }
}
