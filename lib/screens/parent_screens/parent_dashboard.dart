import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

class ParentDashboard extends StatefulWidget {
  @override
  _ParentDashboardState createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Icon(Icons.settings),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.10,
            child: SvgPicture.asset(
              "images/svgs/Asset1.svg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 40,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: kBlueDarkColor,
                ),
                child: Center(
                  child: Text(
                    "Free Verison",
                    style: kBubblegum_sans20.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
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
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, kWatchSchdeuleRoute),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kPurpleColor,
                    ),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset('images/svgs/schedule.svg'),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Watch Schedule",
                              style: kBubblegum_sans32.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffFFA846),
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'images/whatchHistory.png',
                        height: 70,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Watch History",
                        style: kBubblegum_sans32.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xffFF7E71),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'images/viedos.png',
                            height: 90,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Specify Videos",
                            style: kBubblegum_sans16.copyWith(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: kRedColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'images/svgs/timer.svg',
                            height: 100,
                          ),
                          Text(
                            "Set Timer",
                            style: kBubblegum_sans16.copyWith(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
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
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: kBlueColor,
        child: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(
            context,
            kParentDashboardRoute,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              color: kYellowColor,
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.center,
            child: Text(
              'Switch To Kids',
              style: kBubblegum_sans40.copyWith(
                color: Colors.white,
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
