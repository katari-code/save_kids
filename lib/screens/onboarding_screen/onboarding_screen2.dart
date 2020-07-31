import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/components/canvas/onborading_canvas.dart';
import 'package:save_kids/util/style.dart';

import '../../app_localizations.dart';

class OnboardingScreen2 extends StatefulWidget {
  @override
  _OnboardingScreen2State createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "images/svgs/onboading_screen2_.svg",
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Choose categories",
                          style: GoogleFonts.bubblegumSans(
                            textStyle: kBubblegum_sans32.copyWith(fontSize: 40),
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
                    Text(
                      "Choose from many categories of fun ",
                      style: GoogleFonts.capriola(
                          textStyle:
                              kBubblegum_sans28.copyWith(color: Colors.black)),
                    ),
                    Text(
                      "and family friendly content ",
                      style: GoogleFonts.capriola(
                        textStyle:
                            kBubblegum_sans28.copyWith(color: Colors.black),
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
