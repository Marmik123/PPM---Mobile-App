import 'package:flutter/material.dart';

class BottomWidget extends StatefulWidget {
  final VoidCallback onTap;
  final double rotation;

  const BottomWidget({
    Key key,
    this.onTap,
    this.rotation,
  });

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.cyan,
      child: Transform.rotate(
        angle: widget.rotation * 540,
        child: IconButton(
          iconSize: 30,
          icon: Icon(
            Icons.history,
            color: Colors.white,
          ),
          tooltip: 'History',
          onPressed: widget.onTap,
          // onPressed: widget.onTap,
        ),
      ),
    );
    //   Card(
    //   elevation: 2,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //   child: Row(
    //     mainAxisSize: MainAxisSize.max,
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           IconButton(
    //             iconSize: 30,
    //             tooltip: 'Settings',
    //             icon: Icon(
    //               Icons.settings,
    //             ),
    //             onPressed: () => Get.to(() => SettingsPage()),
    //           ),
    //           // Text('Settings'),
    //         ],
    //       ),
    //       Container(
    //         height: 25,
    //         width: 2,
    //         color: Colors.black26,
    //       ),
    //       Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           IconButton(
    //             iconSize: 30,
    //             icon: Icon(Icons.feedback_outlined),
    //             tooltip: 'Feedback',
    //             onPressed: () => Get.to(() => FeedbackPage()),
    //           ),
    //           // Text('FeedBack'),
    //         ],
    //       ),
    //       Container(
    //         height: 25,
    //         width: 2,
    //         color: Colors.black26,
    //       ),
    //       Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           IconButton(
    //             iconSize: 30,
    //             icon: Icon(Icons.support_agent),
    //             tooltip: 'Support',
    //             onPressed: () => Get.to(() => Support()),
    //           ),
    //           // Text('Support'),
    //         ],
    //       ),
    //       showHistory
    //           ? Container(
    //               height: 25,
    //               width: 2,
    //               color: Colors.black26,
    //             )
    //           : SizedBox.shrink(),
    //       showHistory
    //           ? Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 // Text('History'),
    //               ],
    //             )
    //           : SizedBox.shrink(),
    //     ],
    //   ),
    // );
  }
}
