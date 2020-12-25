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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBlueColor,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/ChildernBK.png",
              fit: BoxFit.cover,
            ),
          ),
          Transform.translate(
            offset: Offset(50, 0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SvgPicture.asset(
                "images/fox_screen.svg",
                height: 200,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, 60),
            child: Align(
              alignment: Alignment.topCenter,
              child: SvgPicture.asset(
                "images/logo-enhanceds.svg",
                height: 130,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  // height: 80,
                  // width: 180,

                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            'images/svgs/Back_video.svg',
                            height: 70,
                          ),
                        ),
                        // Icon(
                        //   Icons.arrow_back,
                        //   size: 30,
                        //   color: Colors.white,
                        // ),
                        // Text(
                        //   "Account",
                        //   style: kBubblegum_sans32.copyWith(
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Consumer<ParentPasswordBloc>(
            builder: (context, parentPasswordBloc) => Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Write Your Account Password",
                      style: kBubblegum_sans28,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(25),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
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
                              final result =
                                  parentPasswordBloc.verifyPassword();
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
