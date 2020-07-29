import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/components/canvas/onborading_canvas.dart';
import 'package:save_kids/util/style.dart';

import '../../app_localizations.dart';

class OnboardingScreen4 extends StatefulWidget {
  @override
  _OnboardingScreen4State createState() => _OnboardingScreen4State();
}

class _OnboardingScreen4State extends State<OnboardingScreen4> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: kPurpleColor,
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.10,
            child: SvgPicture.asset(
              "images/svgs/Asset1.svg",
              color: Colors.black,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "images/svgs/onboading_screen4_.svg",
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Finally let your children",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bubblegumSans(
                    textStyle: kBubblegum_sans1.copyWith(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Have",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bubblegumSans(
                        textStyle: kBubblegum_sans1.copyWith(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "F",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.bubblegumSans(
                        textStyle: kBubblegum_sans1.copyWith(
                          fontSize: 40,
                          color: Color(0xff90C747),
                        ),
                      ),
                    ),
                    Text(
                      "U",
                      style: GoogleFonts.bubblegumSans(
                        textStyle: kBubblegum_sans1.copyWith(
                          fontSize: 40,
                          color: Color(0xff40BAD5),
                        ),
                      ),
                    ),
                    Text(
                      "N",
                      style: GoogleFonts.bubblegumSans(
                        textStyle: kBubblegum_sans1.copyWith(
                          fontSize: 40,
                          color: Color(0xffFF2A7F),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
