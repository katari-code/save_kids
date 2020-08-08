import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_localizations.dart';
import '../../bloc/sign_in_bloc.dart';
import '../../components/stream_input_field.dart';
import '../../util/style.dart';
import '../../util/style.dart';
import '../../util/style.dart';
import '../../util/style.dart';
import '../../util/style.dart';
import '../../util/style.dart';
import '../../util/style.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);

    return Scaffold(
      // resizeToAvoidBottomPadding: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlueColor,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.10,
            child: SvgPicture.asset(
              "images/svgs/Asset1.svg",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  height: 80,
                  // width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    color: kYellowColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.white,
                      ),
                      Text(
                        "Settings",
                        style: kBubblegum_sans40.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                    color: kYellowColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Settings",
                        style: kBubblegum_sans28.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
     
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(
                  flex: 3,
                ),
                Text(
                  "Account Information",
                  style: kBubblegum_sans28,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(25),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  //settings
                  child: Consumer<SignInBloc>(
                    builder: (context, signInBloc) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamReusablefield(
                          label: 'Full Name',
                          stream: signInBloc.password,
                          onChangeFunction: signInBloc.changePassword,
                          isPass: true,
                        ),
                        StreamReusablefield(
                          label: 'Password',
                          stream: signInBloc.password,
                          onChangeFunction: signInBloc.changePassword,
                          isPass: true,
                        ),
                        StreamReusablefield(
                          label: 'Email',
                          stream: signInBloc.password,
                          onChangeFunction: signInBloc.changePassword,
                          isPass: true,
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 58.00,
                              width: 226.00,
                              decoration: BoxDecoration(
                                color: Color(0xfff6b039),
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
                              left: 226 * 0.35,
                              top: 58 * 0.23,
                              child: Text(
                                text.translate('SAVE'),
                                style: GoogleFonts.bubblegumSans(
                                  textStyle: kBubblegum_sans32.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          overflow: Overflow.clip,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
