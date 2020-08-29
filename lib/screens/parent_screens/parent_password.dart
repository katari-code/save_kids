import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/app_localizations.dart';
import 'package:save_kids/bloc/parent_password_bloc.dart';
import 'package:save_kids/components/control_widgets/message.dart';
import 'package:save_kids/components/stream_input_field.dart';
import 'package:save_kids/util/constant.dart';

import 'package:save_kids/util/style.dart';

class ParentPassword extends StatefulWidget {
  @override
  _ParentPasswordState createState() => _ParentPasswordState();
}

class _ParentPasswordState extends State<ParentPassword> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  //  p
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlueColor,
      body: Stack(
        children: <Widget>[
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                        Text(
                          "Account",
                          style: kBubblegum_sans32.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Consumer<ParentPasswordBloc>(
            builder: (context, parentPasswordBloc) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Verify Your Account Password",
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
                    child: Column(
                      children: <Widget>[
                        StreamReusablefield(
                          label: 'Password',
                          stream: parentPasswordBloc.password.stream,
                          onChangeFunction: parentPasswordBloc.password.add,
                          isPass: true,
                        ),
                        GestureDetector(
                          onTap: () async {
                            final result = parentPasswordBloc.verifyPassword();
                            if (result) {
                              Navigator.pushReplacementNamed(
                                  context, kParentDashboardRoute);
                            } else {
                              Message(
                                      color: kRedColor,
                                      context: context,
                                      input:
                                          'Password is incorrect, Please Try Again!')
                                  .displayMessage();
                            }
                          },
                          child: Stack(
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
                                  'Verify',
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
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
