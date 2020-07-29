import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/util/style.dart';

class AccountsDashborasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        children: <Widget>[
          SvgPicture.asset(
            "images/svgs/dashborad_background.svg",
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset("images/svgs/parent.svg"),
                      SvgPicture.asset("images/svgs/edit.svg"),
                    ],
                  ),
                ),
                Text(
                  "Hi, John",
                  style: GoogleFonts.bubblegumSans(
                    textStyle: kBubblegum_sans1.copyWith(
                      fontSize: 30,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Who is using the app now ?",
                  style: GoogleFonts.capriola(
                    textStyle: kBubblegum_sans1.copyWith(
                      fontSize: 16,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Consumer<KidsData>(
                  builder: (context, kidsData, child) => Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GridView.count(
                        primary: false,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: List<Widget>.generate(
                          kidsData.kids.length == 4
                              ? kidsData.kids.length
                              : kidsData.kids.length + 1,
                          (index) => kidsData.kids.length == 4
                              ? GestureDetector(
                                  onTap: () {},
                                  child: Column(children: <Widget>[
                                    Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundColor: kYellowColor,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 45,
                                          backgroundImage: NetworkImage(
                                            kidsData.kids[index].imagePath,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      kidsData.kids[index].name,
                                      style: GoogleFonts.bubblegumSans(
                                        textStyle: kBubblegum_sans2.copyWith(
                                            color: kBluesColor),
                                      ),
                                    ),
                                  ]),
                                )
                              : index == kidsData.kids.length
                                  ? GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: <Widget>[
                                          Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 45,
                                                backgroundColor: kYellowColor,
                                              ),
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 70,
                                              )
                                            ],
                                          ),
                                          Text(
                                            "Create profile",
                                            style: GoogleFonts.capriola(),
                                          )
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {},
                                      child: Column(children: <Widget>[
                                        Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundColor: kYellowColor,
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 45,
                                              backgroundImage: NetworkImage(
                                                kidsData.kids[index].imagePath,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          kidsData.kids[index].name,
                                          style: GoogleFonts.bubblegumSans(
                                            textStyle: kBubblegum_sans2
                                                .copyWith(color: kBluesColor),
                                          ),
                                        ),
                                      ]),
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
              
              ],
            ),
          )
        ],
      ),
    );
  }
}
