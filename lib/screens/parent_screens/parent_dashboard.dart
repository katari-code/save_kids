import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/util/style.dart';

class ParentDashBoard extends StatefulWidget {
  @override
  _ParentDashBoardState createState() => _ParentDashBoardState();
}

class _ParentDashBoardState extends State<ParentDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Icon(Icons.settings),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Opacity(
              opacity: 0.15,
              child: Transform.scale(
                scale: 5,
                child: SvgPicture.asset("images/svgs/background.svg"),
              ),
            ),

            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 21,
                      ),
                      Text(
                        'Hello, john',
                        style: kBubblegum_sans32.copyWith(color: Colors.black),
                      ),
                      Text(
                        'Monitor your children account',
                        style: kBubblegum_sans24.copyWith(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(
                                color: kPurpleColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                            "images/svgs/schedule.svg"),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Watch Schedule",
                                          style: kBubblegum_sans24.copyWith(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "sssssssssssssssssssssssssssssssssss",
                                      style: kCapriola24.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(
                                color: kPurpleColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                            "images/svgs/schedule.svg"),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Watch History",
                                          style: kBubblegum_sans24.copyWith(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "sssssssssssssssssssssssssssssssssss",
                                      style: kCapriola24.copyWith(
                                          color: Colors.white),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )

            // Center(
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: 150,
            //     // width: 300,
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: kBlueColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            color: kYellowColor,
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {},
            child: Text(
              'Switch To Kids',
              style: kBubblegum_sans32.copyWith(
                fontSize: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildParentFeatures() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       InkWell(
  //         child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           color: kYellowColor,
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 child: SvgPicture.asset(
  //                   "images/svgs/schedule.svg",
  //                 ),
  //                 padding: EdgeInsets.only(
  //                   top: 0,
  //                   left: 20,
  //                   right: 20,
  //                 ),
  //                 height: 100,
  //                 width: 115,
  //               ),
  //               Text(
  //                 'Schedule',
  //                 style: kBubblegum_sans24,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         width: 32,
  //       ),
  //       InkWell(
  //         child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           color: kPurpleColor,
  //           child: Column(
  //             children: <Widget>[
  //               Container(
  //                 child: SvgPicture.asset(
  //                   "images/svgs/schedule.svg",
  //                 ),
  //                 padding: EdgeInsets.only(top: 0, left: 20, right: 20),
  //                 height: 100,
  //                 width: 115,
  //               ),
  //               Text(
  //                 'History',
  //                 style: kBubblegum_sans24,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

}
