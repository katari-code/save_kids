import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:save_kids/bloc/sign_up_bloc.dart';
import 'package:save_kids/components/control_widgets/message.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/stream_input_field.dart';
import 'package:save_kids/screens/sign_in/sign_in.dart';
import 'package:save_kids/util/constant.dart';

import 'package:save_kids/util/style.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
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
          SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset('images/logos/appLogo_small.svg'),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        color: Colors.white,
                      ),
                      child: SingleChildScrollView(
                        child: Consumer<SignUpBloc>(
                          builder: (conext, signUpBloc) => Column(
                            children: <Widget>[
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                height: 40.00,
                                width: 244.00,
                                decoration: BoxDecoration(
                                  color: Color(0xff035aa6),
                                  borderRadius: BorderRadius.circular(28.00),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Hero(
                                          tag: "Sign up",
                                          child: Container(
                                            height: 28.00,
                                            width: 102.00,
                                            decoration: BoxDecoration(
                                              color: Color(0xfffcbf1e),
                                              borderRadius:
                                                  BorderRadius.circular(50.00),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Sign up",
                                                style:
                                                    kBubblegum_sans20.copyWith(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          Navigator.pushReplacementNamed(
                                              context, kSignInRoute),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15.0),
                                        child: Text(
                                          "Login",
                                          style: kBubblegum_sans20.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              StreamReusablefield(
                                  label: 'Full Name',
                                  stream: signUpBloc.streamName,
                                  onChangeFunction: signUpBloc.changeName),
                              StreamReusablefield(
                                label: 'Email',
                                stream: signUpBloc.streamEmail,
                                onChangeFunction: signUpBloc.changeEmail,
                                type: TextInputType.emailAddress,
                              ),
                              StreamReusablefield(
                                label: 'Password',
                                stream: signUpBloc.streamPassword,
                                onChangeFunction: signUpBloc.changePassword,
                                isPass: true,
                              ),
                              StreamReusablefield(
                                label: 'Phone Number',
                                stream: signUpBloc.streamPhoneNumber,
                                onChangeFunction: signUpBloc.changePhoneNumber,
                                type: TextInputType.phone,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              buildSubmitButton(signUpBloc),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSubmitButton(SignUpBloc signUpBloc) {
    return StreamBuilder<bool>(
        stream: signUpBloc.signInStatus,
        builder: (context, snapshot) {
          if (!snapshot.data) {
            return GestureDetector(
              onTap: () async {
                if (signUpBloc.validateSignInFields()) {
                  signUpBloc.showProgressBar(true);
                  final result = await signUpBloc.signUp();
                  signUpBloc.showProgressBar(false);
                  if (result != null) {
                    Navigator.pushReplacementNamed(context, kChildAccountRoute);
                  }

                  Message(
                          color: Colors.redAccent,
                          input: 'Something Went Wrong',
                          context: context)
                      .displayMessage();
                }
              },
              child: Column(
                children: <Widget>[
                  Container(
                    height: 58.00,
                    width: 221.00,
                    decoration: BoxDecoration(
                      color: Color(0xfffcbf1e),
                      borderRadius: BorderRadius.circular(84.00),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.bubblegumSans(
                          textStyle:
                              kBubblegum_sans32.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return ProgressBar();
        });
  }
}
