import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:save_kids/bloc/sign_in_bloc.dart';
import 'package:save_kids/components/control_widgets/message.dart';
import 'package:save_kids/components/control_widgets/progress_bar.dart';
import 'package:save_kids/components/stream_input_field.dart';
import 'package:save_kids/models/parent.dart';
import 'package:save_kids/util/constant.dart';
import 'package:save_kids/util/style.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlueColor,
      body: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "images/background.png",
                repeat: ImageRepeat.repeat,
              ),
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
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        color: Colors.white,
                      ),
                      child: Consumer<SignInBloc>(
                        builder: (context, signInBloc) => Column(
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
                                  Hero(
                                    tag: "login",
                                    child: GestureDetector(
                                      onTap: () =>
                                          Navigator.pushReplacementNamed(
                                              context, kSginUpRoute),
                                      child: Text(
                                        "Sign Up",
                                        style: kBubblegum_sans20.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Container(
                                        height: 28.00,
                                        width: 102.00,
                                        decoration: BoxDecoration(
                                          color: Color(0xfffcbf1e),
                                          borderRadius:
                                              BorderRadius.circular(50.00),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Login",
                                            style: GoogleFonts.bubblegumSans(
                                              textStyle:
                                                  kBubblegum_sans24.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            StreamReusablefield(
                              label: 'Email',
                              stream: signInBloc.email,
                              onChangeFunction: signInBloc.changeEmail,
                              type: TextInputType.emailAddress,
                            ),
                            StreamReusablefield(
                              label: 'Password',
                              stream: signInBloc.password,
                              onChangeFunction: signInBloc.changePassword,
                              isPass: true,
                            ),
                            Text(
                              "Forget your Password ?",
                              style: GoogleFonts.bubblegumSans(
                                textStyle: TextStyle(
                                  fontFamily: "Bubblegum Sans",
                                  fontSize: 16,
                                  color: Color(0xfffdc402),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            buildSignInOptions(signInBloc, context),
                          ],
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

  Widget buildSignInOptions(SignInBloc signInBloc, context) {
    return StreamBuilder<bool>(
        stream: signInBloc.signInStatus,
        initialData: false,
        builder: (context, snapshot) {
          if (!snapshot.data) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    // Logger().i('Sign in  ${await signInBloc.signIn()}');
                    // final result = await signInBloc.signIn();
                    // if (result != null) {
                    //   Navigator.pushReplacementNamed(context, kChildAccountRoute);
                    // }

                    if (signInBloc.validateSignInFields()) {
                      signInBloc.showProgressBar(true);
                      final result = await signInBloc.signIn();
                      signInBloc.showProgressBar(false);
                      if (result is PlatformException) {
                        String error = '';
                        if (result.code == 'ERROR_USER_NOT_FOUND') {
                          error = 'User not found!';
                        } else if (result.code == 'ERROR_WRONG_PASSWORD' ||
                            result.code == 'ERROR_INVALID_EMAIL') {
                          error = 'Wrong email and/or password!';
                        } else
                          error = 'Something went Wrong!';
                        return Message(
                                color: Colors.redAccent,
                                input: error,
                                context: context)
                            .displayMessage();
                      }
                      Navigator.pushReplacementNamed(
                          context, kChildAccountRoute);
                    }
                  },
                  child: Container(
                    height: 58.00,
                    width: 221.00,
                    decoration: BoxDecoration(
                      color: Color(0xfffcbf1e),
                      borderRadius: BorderRadius.circular(84.00),
                    ),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.bubblegumSans(
                          textStyle:
                              kBubblegum_sans32.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    signInBloc.showProgressBar(true);
                    final result = await signInBloc.signInWithGoogle();
                    signInBloc.showProgressBar(false);
                    if (result != null) {
                      Navigator.pushReplacementNamed(
                          context, kChildAccountRoute);
                    }
                    Message(
                            color: Colors.redAccent,
                            input: 'User Not Found',
                            context: context)
                        .displayMessage();
                  },
                  child: Container(
                    height: 58.00,
                    width: 221.00,
                    decoration: BoxDecoration(
                      color: Color(0xff40BAD5),
                      borderRadius: BorderRadius.circular(84.00),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset('images/svgs/googleIcon.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Continue with Google",
                          style: GoogleFonts.bubblegumSans(
                            textStyle: kBubblegum_sans16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return ProgressBar(
            color: kBlueDarkColor,
          );
        });
  }
}
