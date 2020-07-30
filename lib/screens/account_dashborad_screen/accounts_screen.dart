import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:save_kids/models/child.dart';
import 'package:save_kids/screens/child_screen/create_child_profile.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sa_v1_migration/sa_v1_migration.dart';

import 'package:save_kids/util/style.dart';
import 'package:animated_widgets/animated_widgets.dart';

class AccountsDashborasScreen extends StatefulWidget {
  @override
  _AccountsDashborasScreenState createState() =>
      _AccountsDashborasScreenState();
}

class _AccountsDashborasScreenState extends State<AccountsDashborasScreen> {
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
                    textStyle: kBubblegum_sans32.copyWith(
                      fontSize: 30,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Who is using the app now ?",
                  style: GoogleFonts.capriola(
                    textStyle: kBubblegum_sans32.copyWith(
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
                              ? CustomAnimation(
                                  duration: Duration(milliseconds: 800),
                                  delay: Duration(
                                    milliseconds: (800 * 2).round(),
                                  ),
                                  curve: Curves.elasticOut,
                                  tween: Tween<double>(
                                    begin: 0,
                                    end: 1,
                                  ),
                                  builder: (context, child, value) =>
                                      GestureDetector(
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
                                          textStyle: kBubblegum_sans28.copyWith(
                                              color: kBlueDarkColor),
                                        ),
                                      ),
                                    ]),
                                  ),
                                )
                              : index == kidsData.kids.length
                                  ? CustomAnimation(
                                      duration: Duration(milliseconds: 800),
                                      delay: Duration(
                                        milliseconds: (800 * 2).round(),
                                      ),
                                      curve: Curves.elasticOut,
                                      tween: Tween<double>(
                                        begin: 0,
                                        end: 1,
                                      ),
                                      builder: (context, child, value) =>
                                          GestureDetector(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChildScreen(),
                                          ),
                                        ),
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
                                      ),
                                    )
                                  : CustomAnimation(
                                      duration: Duration(milliseconds: 800),
                                      delay: Duration(
                                        milliseconds: (800 * 2).round(),
                                      ),
                                      curve: Curves.elasticOut,
                                      tween: Tween<double>(
                                        begin: 0,
                                        end: 1,
                                      ),
                                      builder: (context, child, value) =>
                                          Transform.scale(
                                        scale: value,
                                        child: GestureDetector(
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
                                                    kidsData
                                                        .kids[index].imagePath,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              kidsData.kids[index].name,
                                              style: GoogleFonts.bubblegumSans(
                                                textStyle:
                                                    kBubblegum_sans28.copyWith(
                                                        color: kBlueDarkColor),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
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
