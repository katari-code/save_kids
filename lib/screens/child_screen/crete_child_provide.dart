import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/app_localizations.dart';
import 'package:save_kids/util/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChildScreen extends StatefulWidget {
  @override
  _ChildScreenState createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
      ),
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
                  text.translate('add_child_screen_title_1'),
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
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Child Name",
                        labelStyle: GoogleFonts.bubblegumSans(
                                textStyle: kBubblegum_sans2)
                            .copyWith(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        focusColor: Colors.black,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      text.translate('add_child_screen_title_2'),
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
                          text: text.translate('add_child_screen_title_3'),
                        ),
                        AgeChip(
                          highet: 57.00,
                          width: 110.00,
                          text: "5-7",
                        ),
                        AgeChip(
                          highet: 57.00,
                          width: 100.00,
                          text: "8-12",
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
                      text.translate('yellow_button'),
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
            textStyle: kBubblegum_sans2.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
