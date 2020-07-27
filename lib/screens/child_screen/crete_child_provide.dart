import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/app_localizations.dart';
import 'package:save_kids/util/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChildScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  "Create a profile for your kids",
                  style: GoogleFonts.bubblegumSans(textStyle: kBubblegum_sans1),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black,
                ),
                Form(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.12),
                    child: TextFormField(),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('first_string'),
                      style: GoogleFonts.bubblegumSans(
                          textStyle: kBubblegum_sans1),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        AgeChip(
                          highet: 57.00,
                          width: 110.00,
                          text: "4 or less",
                        ),
                        AgeChip(
                          highet: 57.00,
                          width: 110.00,
                          text: "1 - 5",
                        ),
                        AgeChip(
                          highet: 57.00,
                          width: 100.00,
                          text: "1 - 5",
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  height: 58.00,
                  width: 226.00,
                  decoration: BoxDecoration(
                    color: Color(0xfff6b039),
                    borderRadius: BorderRadius.circular(50.00),
                  ),
                  child: Center(
                    child: Text(
                      "NEXT",
                      style: GoogleFonts.bubblegumSans(
                        textStyle: kBubblegum_sans2.copyWith(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AgeChip extends StatelessWidget {
  const AgeChip({
    this.width,
    this.highet,
    this.text,
  });

  final highet;
  final width;
  final text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: highet,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xff035AA6),
        borderRadius: BorderRadius.circular(20.00),
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.bubblegumSans(
            textStyle: kBubblegum_sans1.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
