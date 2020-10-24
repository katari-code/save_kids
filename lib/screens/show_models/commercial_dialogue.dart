import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_kids/bloc/auth_bloc.dart';
import 'package:save_kids/screens/child_display_videos/widget/childTimer.dart';
import 'package:save_kids/util/style.dart';

class CommercialDialogue extends StatelessWidget {
  final AuthBloc auth;
  CommercialDialogue({this.auth});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 650,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: kRedColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                    ),
                    Container(height: 530, color: kBlueDarkColor),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      "images/background.png",
                      repeat: ImageRepeat.repeat,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: const Color(0x7affffff),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 200,
                          height: 330,
                          child: Image.asset("images/wc_popup.gif"),
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: Colors.white),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x29000000),
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: kRedColor,
                                child: Text(
                                  "1",
                                  style: kBubblegum_sans28.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Schedule 📅 watch times for your kids ",
                                    style: kBubblegum_sans20.copyWith(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "Control the showtimes for your kids \n throughout the days",
                                    textAlign: TextAlign.center,
                                    style: kCapriola16.copyWith(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: kRedColor,
                                child: Text(
                                  "2",
                                  style: kBubblegum_sans28.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Specify Channels 📺, and Videos 🎞️",
                                    textAlign: TextAlign.start,
                                    style: kBubblegum_sans20.copyWith(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Customize the cahnnels and viedos \n that you want",
                                    textAlign: TextAlign.center,
                                    style: kCapriola16.copyWith(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            // auth.setAccountPremuim();
                            // await buildShowModeDialog3(context);
                            Navigator.pop(context);
                          },
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 58.00,
                                width: 226.00,
                                decoration: BoxDecoration(
                                  color: kYellowColor,
                                  borderRadius: BorderRadius.circular(8.00),
                                ),
                              ),
                              Positioned(
                                top: -15,
                                left: 0,
                                child: Transform.scale(
                                  scale: 1.25,
                                  child: SvgPicture.asset(
                                      "images/svgs/mask_button.svg"),
                                ),
                              ),
                              Positioned(
                                left: 40,
                                top: 58 * 0.23,
                                child: Text(
                                  'Only 2,99 \$',
                                  style: kBubblegum_sans32.copyWith(
                                      color: Colors.white),
                                ),
                              ),
                            ],
                            overflow: Overflow.clip,
                          ),
                        ),
                      ],
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
