import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_kids/models/calender.dart';
import 'package:save_kids/screens/child_screen/create_child_profile.dart';
import 'package:save_kids/util/style.dart';

class WatchSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurpleColor,
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
            child: Column(
              children: <Widget>[
                Container(
                  color: kYellowColor,
                  padding: EdgeInsets.all(15),
                  height: 90,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.arrow_back),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Watch Schedule",
                            style: kBubblegum_sans28.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "January",
                            style: kBubblegum_sans16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ...List<Container>.generate(
                      days.length,
                      (index) => Container(
                        padding: EdgeInsets.all(2),
                        width: 50,
                        height: 40,
                        decoration: BoxDecoration(
                          color: kRedColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            days[index],
                            style: kBubblegum_sans20.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(top: 18),
                        decoration: BoxDecoration(
                          color: kBlueColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                        ),
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "From",
                                        style: kBubblegum_sans20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "4:00 PM",
                                        style: kBubblegum_sans20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "To",
                                        style: kBubblegum_sans20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "4:30 PM",
                                        style: kBubblegum_sans20,
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    'images/shape.png',
                                    height: 40,
                                  ),
                                ],
                              ),
                              Container(
                                width: 250,
                                height: 10,
                                child: Wrap(
                                  spacing: 30,
                                  children: <Widget>[
                                    Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.teal,
                                    ),
                                    Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.teal,
                                    ),
                                    Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.teal,
                                    ),
                                    Container(
                                      height: 10,
                                      width: 80,
                                      color: Colors.teal,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                AgeChip(
                  highet: 60.0,
                  width: 220.0,
                  text: "Add to Schedule",
                  color: kBlueDarkColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
