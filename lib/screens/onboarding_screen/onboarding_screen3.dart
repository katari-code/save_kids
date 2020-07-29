import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/components/canvas/onborading_canvas.dart';
import 'package:save_kids/util/style.dart';

import '../../app_localizations.dart';

class OnboardingScreen3 extends StatefulWidget {
  @override
  _OnboardingScreen3State createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends State<OnboardingScreen3> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: CanvaView(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: kBlueColor,
              child: Stack(
                children: <Widget>[
 
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "images/svgs/onboading_screen1_.svg",
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Set Time Limit",
                          style: GoogleFonts.bubblegumSans(
                            textStyle: kBubblegum_sans1.copyWith(fontSize: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Set watch time limits and monitor your child's watch history .",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.capriola(
                            textStyle:
                                kBubblegum_sans2.copyWith(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          )
        ],
      ),
    );
  }
}
